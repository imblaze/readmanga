package common.api;

import java.util.concurrent.ConcurrentHashMap;

public class SharedMap {
	private static ConcurrentHashMap<String, Object> map = new ConcurrentHashMap<String, Object>();

	public static void put(String key, Object o) {
		map.put(key, o);
	}

	public static Object get(String key) {
		return map.get(key);
	}
	
}