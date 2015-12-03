package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import openfl.Assets;

class PlayState extends FlxState
{
	
	private var _pos:FlxPoint;
	private var _posRobo:FlxPoint;
	private var _houses:Map<String, Int>;
	private var _route:String;
	
	override public function create():Void
	{
		var count:Int = 0;
		_houses = new Map<String, Int>();
		_pos = FlxPoint.get();
		_posRobo = FlxPoint.get();
		_route = Assets.getText(AssetPaths.route__txt);
		_houses["0,0"] = 1;
		
		for (i in 0..._route.length)
		{
			houseMove(_route.charAt(i), _pos);
		}
		
		for (k in _houses.keys())
		{
			count++;
		}
		
		trace("Year 1: Deliveries = " + count);
		
		_houses = new Map<String, Int>();
		count = 0;
		_pos.set();
		
		_houses["0,0"] = 2;
		
		for (i in 0..._route.length)
		{
			houseMove(_route.charAt(i), i % 2 != 0 ? _pos : _posRobo);
		}
		
		for (k in _houses.keys())
		{
			count++;
		}
		
		trace("Year 2: Deliveries = " + count);
		
		super.create();
	}

	
	private function houseMove(Dir:String,Pos:FlxPoint):Void
	{
		switch (Dir) 
		{
			case ">":
				Pos.x++;
			case "<":
				Pos.x--;
			case "^":
				Pos.y--;
			case "v":
				Pos.y++;
		}
		var coords:String = Std.string(Pos.x) + "," + Std.string(Pos.y);
		var count:Int = 0;
		if (_houses.exists(coords))
		{
			count = _houses[coords];
		}
		_houses[coords] = count + 1;
	}

}
