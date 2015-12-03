package;

import flixel.FlxState;
import flixel.math.FlxMath;
import openfl.Assets;


class PlayState extends FlxState
{
	
	override public function create():Void
	{
		
		var sizes:Array<String> = Assets.getText(AssetPaths.sizes__txt).split("\r\n");
		var paperTotal:Int = 0;
		var ribbonTotal:Int = 0;
		var d:Array<String>;
		
		
		
		for (s in sizes)
		{
			d = s.split("x");
			paperTotal += computeNeed(Std.parseInt(d[0]), Std.parseInt(d[1]), Std.parseInt(d[2]));
			ribbonTotal += computeRibbon(Std.parseInt(d[0]), Std.parseInt(d[1]), Std.parseInt(d[2]));
			
			
		}
		trace("Paper total: " + paperTotal + " cubic feet");
		trace("Ribbon total: " + ribbonTotal + " feet");
		
		
		
		super.create();
	}
	
	private function computeRibbon(l:Int, w:Int, h:Int):Int
	{
		var sides:Array<Int> = [l, w, h];
		sides.sort(function(a, b) return a - b);
		return (sides[0] * 2) + (sides[1] * 2) + (l * w * h);
		
	}
	
	private function computeNeed(l:Int, w:Int, h:Int):Int
	{
		var sizes:Array<Int> = [l * w, w * h, h * l];
		sizes.sort(function(a, b) return a - b);
		return sizes[0] + (2 * l * w) + (2 * w * h) + (2 * h * l);
		
	}

}
