package;

import flixel.FlxState;
import haxe.io.UInt16Array;
import openfl.Assets;

class PlayState extends FlxState
{
	
	private var _wires:Map<String, Array<String>>;
	private var _cache:Map<String, Int>;

	private var _inputs:Array<String>;
	private var _lineNo:Int = 0;
	
	override public function create():Void 
	{
		
		_wires = new Map<String, Array<String>>();
		_cache = new Map<String, Int>();

		_inputs = Assets.getText(AssetPaths.input__txt).split("\r\n");
		
		super.create();
	}
	
	override public function update(elapsed:Float):Void 
	{
		
		
		if (_lineNo < _inputs.length)
		{
			parseInput(_inputs[_lineNo]);			
			_lineNo++;
		}
		else if (_lineNo == _inputs.length)		
		{
			_lineNo++;
			var a:Int = getWireValue("a");
			trace('Value for "a": $a');
			_cache = new Map<String, Int>();
			_cache.set("b", a);
			trace('New value for "a": ' + getWireValue("a"));
		}
		
		super.update(elapsed);
	}
	
	private function parseInput(Input:String):Void
	{
		var sourceA:String = "-";
		var sourceB:String = "-";
		var command:String = "-";
		var dest:String = "-";
		
		var sourceR = ~/^([a-z|0-9]*)\s{0,1}([A-Z]*)\s{0,1}([a-z|0-9]*)\s\->\s([a-z]+)$/;
		
		if (sourceR.match(Input))
		{
			sourceA = sourceR.matched(1); 
			command = sourceR.matched(2); 
			sourceB = sourceR.matched(3);
			dest = sourceR.matched(4);
			
		}
		
		_wires.set(dest, [sourceA, sourceB, command]);
		
	}
	
	private function getWireValue(WireID:String):Int
	{
		
		
		var vA:Int = 0;
		var vB:Int = 0;
		var result:Int = 0;
		
		if (_wires[WireID][0] != "")
		{
			if ( ~/^[0-9]+$/.match(_wires[WireID][0]))
			{
				vA = Std.parseInt(_wires[WireID][0]);
			}
			else if (_cache.get(_wires[WireID][0]) == null)
			{
				vA = getWireValue(_wires[WireID][0]);
			}
			else
			{
				vA = _cache.get(_wires[WireID][0]);
			}
			
		}
		if (_wires[WireID][1] != "")
		{
			if ( ~/^[0-9]+$/.match(_wires[WireID][1]))
			{
				vB = Std.parseInt(_wires[WireID][1]);
			}
			else if (_cache.get(_wires[WireID][1]) == null)
			{
				vB = getWireValue(_wires[WireID][1]);
			}
			else
			{
				vB = _cache.get(_wires[WireID][1]);
			}
			
		}
		
		
		
		switch (_wires[WireID][2]) 
		{
			case "NOT":
				result = ~ vB & 0xffff;
			case "AND":
				result = vA & vB & 0xffff;
			case "OR":
				result = vA | vB & 0xffff;
			case "XOR":
				result = vA ^ vB & 0xffff;
			case "LSHIFT":
				result = vA << vB & 0xffff;
			case "RSHIFT":
				result = vA >> vB & 0xffff;
			default:
				result = vA &  0xffff;
		}
		_cache.set(WireID, result);
		return result;
		
	}
}
