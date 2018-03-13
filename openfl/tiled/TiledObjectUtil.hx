package openfl.tiled;

class TiledObjectUtil {
	
	public static function getTiledObjectGroup(objLayerName:String, tiledMap:TiledMap):TiledObjectGroup {
		for(i in 0...tiledMap.objectGroups.length) {
			if (tiledMap.objectGroups[i].name == objLayerName) {
				return tiledMap.objectGroups[i];
			}
		}
		return null;
	}
	
	public static function getTiledObject(objName:String, objLayerName:String, tiledMap:TiledMap):TiledObject {
		var objLayer:TiledObjectGroup = getTiledObjectGroup(objLayerName, tiledMap);
		for(i in 0...objLayer.objects.length) {
			if (objLayer.objects[i].name == objName) {
				return objLayer.objects[i];
			}
		}
		return null;
	}
	
	public static function getTiledObjectOnLayer(objName:String, objLayer:TiledObjectGroup, tiledMap:TiledMap):TiledObject {
		for(i in 0...objLayer.objects.length) {
			if (objLayer.objects[i].name == objName) {
				return objLayer.objects[i];
			}
		}
		return null;
	}
}