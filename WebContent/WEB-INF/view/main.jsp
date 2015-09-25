<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.JerseyClient" %>

<%
String json = JerseyClient.getJson();
JSONObject[] jsonAttrList = JerseyClient.getJsonAttrObject(json); 
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>入退出管理</title>
	</head>
	<body>
		<h1 align="left">入退出管理</h1>
		
		<form action="/EntryAndExitMgr2/EntryAndExitMgr2" method="get">
			<input type="submit" value="更新" style="font-size : 20px">
		</form>
		<br>
		<table border="1" style="font-size : 30px">
			<tr style="background:aqua"> <!-- ヘッダーレコード -->
				<th>Name</th>
				<th>Device ID</th>
				<th>iBeacon ID</th>
			</tr>
			
<% for(JSONObject obj :  jsonAttrList){ %>
			<tr> <!-- 明細レコード -->
				<td><%
		String name = "null";
		try{
			name = obj.getString("name");
		}catch(JSONException e){}%>
		<%= name %>
				</td>
				
				<td><%
		String deviceId = "null";
		try{
			deviceId = obj.getString("device_id");
		}catch(JSONException e){}%>
		<%= deviceId %>
				</td>
				
				<td><%
		String ibeaconId = "null";
		try{
			ibeaconId = obj.getString("ibeacon_id");
		}catch(JSONException e){}%>
		<%= ibeaconId %>
				</td>
			</tr>
<% } %>

		</table><br>
	</body>
</html>