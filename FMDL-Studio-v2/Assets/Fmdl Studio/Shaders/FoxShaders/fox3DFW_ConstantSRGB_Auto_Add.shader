Shader "FoxShaders/fox3DFW_ConstantSRGB_Auto_Add" {
Properties {
	SelfColor("SelfColor", Vector) = (0.0, 0.0, 0.0, 0.0)
	SelfColorIntensityMin("SelfColorIntensityMin", Vector) = (0.0, 0.0, 0.0, 0.0)
	SelfColorIntensityMax("SelfColorIntensityMax", Vector) = (0.0, 0.0, 0.0, 0.0)
	ToneMapExposureMin("ToneMapExposureMin", Vector) = (0.0, 0.0, 0.0, 0.0)
	ToneMapExposureMax("ToneMapExposureMax", Vector) = (0.0, 0.0, 0.0, 0.0)
	Base_Tex_SRGB("Base_Tex_SRGB", 2D) = "white" {}
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}

SubShader {
	Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
	LOD 400

CGPROGRAM
#pragma surface surf BlinnPhong alphatest:_Cutoff
#pragma target 3.0

sampler2D Base_Tex_SRGB;

struct Input {
	float2 uvBase_Tex_SRGB;
};

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 tex = tex2D(Base_Tex_SRGB, IN.uvBase_Tex_SRGB);
	o.Albedo = tex.rgb;
	o.Gloss = tex.a;
	o.Alpha = tex.a;
}
ENDCG
}

FallBack "Standard"
}