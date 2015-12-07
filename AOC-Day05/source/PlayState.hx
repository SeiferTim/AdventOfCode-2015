package;

import flixel.FlxState;
import openfl.Assets;

class PlayState extends FlxState
{
	
	override public function create():Void
	{
		var count:Int = 0;
		var allWords:String = Assets.getText(AssetPaths.input__txt);
		var words:Array<String> = allWords.split("\r\n");
		var dubs = ~/\b\w*(\w\w)(?=\w*(\1))\w*\b/ig;
		var gaps = ~/\b\w*(\w)\w\1\w*\b/ig;
		//var bads = ~/\b\w*(ab|cd|pq|xy)\w*\b/ig;
		//words = ["qjhvhtzxzqqjkmpb","xxyxx", "uurcxstgmygtbstg", "ieodomkazucvgmuy", "xyxy", "aabcdefgaa", "aaa"];
		for (w in words)
		{
			
			if (dubs.match(w) && gaps.match(w)) //
			{
				trace(w);
				trace("m " + dubs.matched(1));
				count++;
			}
		}
		
		
		trace(count);
		
		
		super.create();
	}

}
