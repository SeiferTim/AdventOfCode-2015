package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import openfl.Assets;

class PlayState extends FlxState
{

	override public function create():Void
	{
		
		var floorData:String = Assets.getText(AssetPaths.stairs__txt);
		
		var floorNo:Int = 0;
		var charPos:Int = 0;
		
		for (i in 0...floorData.length)
		{
			if (floorData.charAt(i) == "(")
			{
				floorNo++;
			}
			else if (floorData.charAt(i) == ")")
			{
				floorNo--;
				if (floorNo < 0 && charPos == 0)
				{
					charPos = i;
				}
			}
		}
		
		
		var txtFloor:FlxText = new FlxText();
		txtFloor.text = "1st Basement Dir Pos: " + Std.string(charPos+1);
		txtFloor.screenCenter(FlxAxes.XY);
		add(txtFloor);
		
		super.create();
	}

	
}
