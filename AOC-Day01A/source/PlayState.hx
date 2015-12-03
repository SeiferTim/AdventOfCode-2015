package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import openfl.Assets;

class PlayState extends FlxState
{

	override public function create():Void
	{
		
		var floorNo:Int = 0;
		var floorData:String = Assets.getText(AssetPaths.stairs__txt);
		
		floorNo = ~/\(/g.split(floorData).length - ~/\)/g.split(floorData).length;
		
		var txtFloor:FlxText = new FlxText();
		txtFloor.text = "Floor: " + Std.string(floorNo);
		txtFloor.screenCenter(FlxAxes.XY);
		add(txtFloor);
		
		super.create();
	}

}
