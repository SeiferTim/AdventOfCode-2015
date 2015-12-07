package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.math.FlxPoint;
import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import openfl.geom.Rectangle;
import openfl.Assets;
import openfl.display.BitmapData;

class PlayState extends FlxState
{
	
	private var _lights:Array<Array<Int>>;
	//private var _lightDisplay:FlxSprite;
	//private var _colors:Array<FlxColor> = [0xffff0038, 0xff02d003, 0xffff0568, 0xff1f62cb, 0xfffef015];
	private var _commands:Array<String>;
	private var _lineNo:Int = 0;
	private var _onCount:Int = 0;
	private var _finished:Bool = false;
	
	override public function create():Void
	{
		
		defineLights();
		
		_commands = Assets.getText(AssetPaths.lights__txt).split("\r\n");
		//_commands = ["turn on 0,0 through 999,999", "toggle 0,0 through 999,0", "turn off 499,499 through 500,500"];
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (_finished)
		{
			if (_lineNo <= _commands.length)
			{
			
				readCommand(_lineNo);
				
				_lineNo++;
			}
			else if (_onCount == 0)
			{
				_onCount = getCount();
				trace("Lights On: " + _onCount);
				_finished = false;
			}
		}
		
		
		super.update(elapsed);
	}
	
	private function getCount():Int
	{
		var c:Int = 0;
		var t:Int = 0;
		for (x in 0...1000)
		{
			for (y in 0...1000)
			{
				t++;
				c += _lights[x][y];
			}
		}
		trace(t + " " + c);
		return c;
		
	}
	
	
	private function readCommand(LineNo:Int):Void
	{
		var cmd:String = _commands[LineNo];
		
		var task_reg = ~/(?:^)(\D*)(?:\s)/;
		var startPoint_reg = ~/(?:\s)(\d+,\d+)(?:\sthrough)/;
		var endPoint_reg = ~/(?:\s)(\d+,\d+)(?:$)/;
		
		if (task_reg.match(cmd) && startPoint_reg.match(cmd) && endPoint_reg.match(cmd) )
		{
			var task:String = task_reg.matched(1);
			var startPoint:String = startPoint_reg.matched(1);  
			var endPoint:String = endPoint_reg.matched(1);  
			//trace(task + " " + startPoint + " - " + endPoint);
			//_lightDisplay.pixels.lock();
			switch (task)
			{
				case "turn on":
					turnOn(startPoint.split(","), endPoint.split(","));
				case "turn off":
					turnOff(startPoint.split(","), endPoint.split(","));
				case "toggle":
					toggle(startPoint.split(","), endPoint.split(","));
				default:
					trace("!!!");
			}
			//getCount();
			//_lightDisplay.pixels.unlock();
			//_lightDisplay.dirty = true;
			
		}
	
	}
	
	private function turnOn(StartP:Array<String>, EndP:Array<String>):Void
	{
		var sP:FlxPoint = FlxPoint.get(Std.parseInt(StartP[0]), Std.parseInt(StartP[1]));
		var eP:FlxPoint = FlxPoint.get(Std.parseInt(EndP[0]), Std.parseInt(EndP[1]));
		//lightOn(Std.int(sP.x), Std.int(sP.y));
		for (x in Std.int(sP.x)...Std.int(eP.x+1))
		{
			for (y in Std.int(sP.y)...Std.int(eP.y+1))
			{
				lightOn(x,y);
			}
			
		}
		
		sP.put();
		eP.put();
	}
	private function turnOff(StartP:Array<String>, EndP:Array<String>):Void
	{
		var sP:FlxPoint = FlxPoint.get(Std.parseInt(StartP[0]), Std.parseInt(StartP[1]));
		var eP:FlxPoint = FlxPoint.get(Std.parseInt(EndP[0]), Std.parseInt(EndP[1]));
		//lightOff(Std.int(sP.x), Std.int(sP.y));
		for (x in Std.int(sP.x)...Std.int(eP.x+1))
		{
			for (y in Std.int(sP.y)...Std.int(eP.y+1))
			{
				lightOff(x, y);
			}
		}
		sP.put();
		eP.put();
	}
	private function toggle(StartP:Array<String>, EndP:Array<String>):Void
	{
		var sP:FlxPoint = FlxPoint.get(Std.parseInt(StartP[0]), Std.parseInt(StartP[1]));
		var eP:FlxPoint = FlxPoint.get(Std.parseInt(EndP[0]), Std.parseInt(EndP[1]));
		for (x in Std.int(sP.x)...Std.int(eP.x+1))
		{
			for (y in Std.int(sP.y)...Std.int(eP.y+1))
			{
				
				lightOn(x, y);			
				lightOn(x, y);			
			}
		}
		sP.put();
		eP.put();
	}
	
	private function defineLights():Void
	{
		_lights = new Array();
		for (x in 0...1000)
		{
			_lights[x] = new Array();
			for (y in 0...1000)
			{
				_lights[x][y] = 0;
			}
		}
		/*
		_lightDisplay = new FlxSprite();
		_lightDisplay.makeGraphic(4000, 4000, FlxColor.BLACK);
		_lightDisplay.scale.set(.25, .25);
		_lightDisplay.screenCenter(FlxAxes.XY);
		add(_lightDisplay);*/
		_finished = true;
		
	}
	
	
	private function lightOn(X:Int, Y:Int):Void
	{
		_lights[X][Y]++;
		//_lightDisplay.pixels.fillRect(new Rectangle(X * 4, Y * 4, 3, 3),  _colors[(X + (Y*1000)) % _colors.length]);
	}
	
	private function lightOff(X:Int, Y:Int):Void
	{
		_lights[X][Y]--;
		if (_lights[X][Y] < 0)
			_lights[X][Y] = 0;
		//_lightDisplay.pixels.fillRect(new Rectangle(X * 4, Y * 4, 3, 3), FlxColor.BLACK);
	}
	
	

	
}
