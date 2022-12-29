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
		multipliers[0] = value[0];
		multipliers[1] = value[1];
		multipliers[2] = value[2];
		multipliers[3] = value[3];
		multipliers[4] = value[5];
		multipliers[5] = value[6];
		multipliers[6] = value[7];
		multipliers[7] = value[8];
		multipliers[8] = value[10];
		multipliers[9] = value[11];
		multipliers[10] = value[12];
		multipliers[11] = value[13];
		multipliers[12] = value[15];
		multipliers[13] = value[16];
		multipliers[14] = value[17];
		multipliers[15] = value[18];
		trace(multipliers);
		offsets[0] = value[4] / 255.0;
		offsets[1] = value[9] / 255.0;
		offsets[2] = value[14] / 255.0;
		offsets[3] = value[19] / 255.0;
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
