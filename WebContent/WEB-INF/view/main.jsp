<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.JerseyClient" %>

<%
String json = JerseyClient.getJson();
JSONObject[] jsonAttrList = JerseyClient.getJsonAttrObject(json);
TreeMap<String, JSONObject> sortedJsonAttrList = JerseyClient.sortList(jsonAttrList);
System.out.println("sortedJsonAttrList.size():" + sortedJsonAttrList.size());

Set<String> keySet = sortedJsonAttrList.keySet();
ArrayList<String> nameList = new ArrayList<String>();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>入退出管理Web</title>
	</head>
	<body>
		<h1 align="left">入退出管理Web</h1>

		<form action="/EntryAndExitMgr2/EntryAndExitMgr2" method="get">
			<input type="submit" value="更新" style="font-size : 20px">
		</form>
		<br>
		<table border="1" style="font-size : 30px">
			<tr style="background:aqua"> <!-- ヘッダーレコード -->
				<th>ビーコン名</th>
				<th>部屋</th>
				<th>状況</th>
				<%-- <th>時刻</th> --%>
			</tr>

<%
for(String key : keySet){

	JSONObject obj = sortedJsonAttrList.get(key);

	String buf;
	try{
		buf = obj.getString("ibeacon_id");
		if(nameList.contains(buf)){
			continue;
		}
		nameList.add(buf);
	}catch(JSONException e){}

%>
			<tr> <!-- 明細レコード -->

				<td><%
		String ibeaconId = "null";
		try{
			ibeaconId = obj.getString("ibeacon_id");
		}catch(JSONException e){}%>
		<%= ibeaconId %>
				</td>

				<td><%
		String deviceId = "null";
		try{
			deviceId = obj.getString("device_id");
		}catch(JSONException e){}%>
		<%= deviceId %>
				</td>

				<td><%
		String name = "null";
		try{
			name = obj.getString("name");
		}catch(JSONException e){}%>
		<%= name %>
				</td>

<%--
				<td><%
		String time = "null";
		try{
			time = obj.getString("access_flag");
		}catch(JSONException e){}%>
		<%= time %>
				</td>
--%>
			</tr>

<% } %>

		</table><br>
	</body>
</html>