package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxAxes;
import haxe.crypto.Md5;

class PlayState extends FlxState
{
	
	private var i:Int = 0;
	private var key:String = "bgvyzdsv";
	private var matched:Bool = false;
	private var txtAnswer:FlxText;	
	
	override public function create():Void
	{
		txtAnswer = new FlxText();
		txtAnswer.screenCenter(FlxAxes.XY);
		txtAnswer.text = "\\";
		add(txtAnswer);
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		var time:Int = 0;
		var hash:String = "";
		while (!matched && time < 5000)
		{
			i++;
			time++;
			hash = Md5.encode(key + Std.string(i));
			if (StringTools.startsWith(hash ,"000000"))
			{
				matched = true;
			}
		}
		if (matched)
		{
			txtAnswer.text = Std.string(i);
		}
		else
		{
			switch (txtAnswer.text) 
			{
				case "\\":
					txtAnswer.text = "|";
				case "|":
					txtAnswer.text = "/";
				case "/":
					txtAnswer.text = "-";
				case "-":
					txtAnswer.text = "\\";
			}
		}
		
		super.update(elapsed);
	}
	

}
