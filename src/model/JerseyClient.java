package model;

import java.util.Comparator;
import java.util.TreeMap;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.WebResource;

public class JerseyClient {

	//public static JSONObject[] attributesObjectList;
	//public static JSONObject createdAtObject;

	public static String getJson() {
		Client client = Client.create();
		WebResource webResource = client
				// 100件
				.resource("https://mobile.ng.bluemix.net:443/data/rest/v1/apps/b055935a-0e02-49b4-a9e0-e95936f1f129/objects?classname=Item&start=0&num=100");
				// 1件
				//.resource("https://mobile.ng.bluemix.net:443/data/rest/v1/apps/b055935a-0e02-49b4-a9e0-e95936f1f129/objects?start=0&num=1");

				String json = webResource.accept("application/json")
						.header("IBM-Application-Secret","6a8a572675c2f3d12a27855f50f4334ada080ba8")
						.get(String.class);

		return json;
	}

	public static JSONObject[] getJsonAttrObject(String json) throws JSONException {

		// ルートオブジェクトを取り出す
		JSONObject rootObject = new JSONObject(json);

		// object配列を取り出す
		JSONArray objectArray = rootObject.getJSONArray("object");

		// objectオブジェクトを取り出す
		JSONObject objectObject[] = new JSONObject[objectArray.length()];
		for(int i = 0; i < objectArray.length(); i++){
			objectObject[i] = objectArray.getJSONObject(i);
		}

		// attributesとcreatedAtオブジェクトを取り出す
		JSONObject[] attr = new JSONObject[objectObject.length];
		for(int i = 0; i < objectObject.length; i++){
			attr[i] = objectObject[i].getJSONObject("attributes");
		}


		return attr;

		//attributesObjectList.add(new JSONObject(objectObject[i].getString("attributes")));

		// CreatedAtオブジェクトを取り出す
		//createdAtObject = objectObject[0].getJSONObject("createdAt");
	}

	public static TreeMap<String, JSONObject> sortList(JSONObject[] rawAttr){
		TreeMap<String, JSONObject> sortedAttr = new TreeMap<String, JSONObject>( new Comparator<String>() {
			public int compare(String s, String n) {
				return ((String) s).compareTo(n) * -1;
			}
		});

		//TreeMap<String, JSONObject> sortedAttr = new TreeMap<String, JSONObject>();

		for(JSONObject obj : rawAttr){
			String key;

			try{
				key = obj.getString("access_flag");
				sortedAttr.put(key, obj);
			}catch(JSONException e){}
		}

		return sortedAttr;
	}

}
