package;

import flixel.system.FlxAssets.FlxShader;

class AdjustShader
{
	public var shader:AdShader;

	public var matrix(default, set):Array<Float>;

	public function new()
	{
		shader = new AdShader();
	}

	function set_matrix(value:Array<Float>)
	{
		var multipliers = shader.Multipliers.value;
		var offsets = shader.Offsets.value;
		if (multipliers == null)
		{
			multipliers = [];
			offsets = [];
		}
		var valueArray:Array<Int> = [0, 1, 2, 3, 5, 6, 7, 8, 10, 11, 12, 13, 15, 16, 17, 18];
		for (i in 0...valueArray.length) multipliers[i] = value[valueArray[i]];
		trace(multipliers);
		valueArray = [4, 9, 14, 19]
		for (i in 0...valueArray.length) offsets[i] = value[valueArray[i]] / 255.0;
		trace(offsets);
		return value;
	}
}

class AdShader extends FlxShader
{
	@:glFragmentSource("
        #pragma header

        uniform mat4 Multipliers;
        uniform vec4 Offsets;

        void main()
        {
            vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);

			if (color.a == 0.0) {

				gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);

			} else {

				color = vec4(color.rgb / color.a, color.a);
				color = Offsets + color * Multipliers;

				gl_FragColor = vec4(color.rgb * color.a, color.a);

			}
        }
    ")
	public function new()
	{
		super();
		Multipliers.value = [1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
		Offsets.value = [0, 0, 0, 0];
	}
}
