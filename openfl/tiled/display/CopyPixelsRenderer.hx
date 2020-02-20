package openfl.tiled.display;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import openfl.tiled.TiledMap;

class CopyPixelsRenderer implements Renderer {

	private var map:TiledMap;

	public function new() {
	}

	public function setTiledMap(map:TiledMap):Void {
		this.map = map;
	}

	public function drawLayer(on:Dynamic, layer:Layer):Void {
		var bgColor = on.numChildren == 0 ? map.backgroundColor:0x00000000;
		var bitmapData = new BitmapData(map.totalWidth, map.totalHeight, true, bgColor);
		var gidCounter:Int = 0;

		if(layer.visible) {
			for(y in 0...map.heightInTiles) {
				for(x in 0...map.widthInTiles) {
					var nextGID = layer.tiles[gidCounter].gid;

					if(nextGID != 0) {
						var point:Point = new Point(layer.offsetX, layer.offsetY);

						switch (map.orientation) {
							case TiledMapOrientation.Orthogonal:
								point = new Point(x * map.tileWidth+layer.offsetX, y * map.tileHeight+layer.offsetY);
							case TiledMapOrientation.Isometric:
								point = new Point((map.width + x - y - 1) * map.tileWidth * 0.5, (y + x) * map.tileHeight * 0.5);
						}

						var tileset:Tileset = map.getTilesetByGID(nextGID);

						var rect:Rectangle = tileset.getTileRectByGID(nextGID);

						if(map.orientation == TiledMapOrientation.Isometric) {
							point.x += map.totalWidth/2;
						}

						// copy pixels
						bitmapData.copyPixels(tileset.image.texture, rect, point, null, null, true);
					}

					gidCounter++;
				}
			}
		}
		
		var bitmap = new Bitmap(bitmapData);
		bitmap.alpha = layer.opacity;

		if(map.orientation == TiledMapOrientation.Isometric) {
			bitmap.x -= map.totalWidth/2;
		}

		on.addChild(bitmap);
	}

	public function drawImageLayer(on:Dynamic, imageLayer:ImageLayer):Void {
		var bitmap = new Bitmap(imageLayer.image.texture);

		on.addChild(bitmap);
	}

	public function clear(on:Dynamic):Void {
		while(on.numChildren > 0){
			on.removeChildAt(0);
		}
	}
}