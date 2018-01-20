Shader "FoxShaders/tpp3DDF_BurnInvisible_LayerSRGBBl_Dirty_NrmUV_LNM"
{
	Properties
	{
		MatParamIndex_0("MatParamIndex_0", Vector) = (0.0, 0.0, 0.0, 0.0)
		BurnColor("BurnColor", Vector) = (0.0, 0.0, 0.0, 0.0)
		AlphaMax("AlphaMax", Vector) = (0.0, 0.0, 0.0, 0.0)
		UShift_UV("UShift_UV", Vector) = (0.0, 0.0, 0.0, 0.0)
		VShift_UV("VShift_UV", Vector) = (0.0, 0.0, 0.0, 0.0)
		UShiftBL_UV("UShiftBL_UV", Vector) = (0.0, 0.0, 0.0, 0.0)
		VShiftBL_UV("VShiftBL_UV", Vector) = (0.0, 0.0, 0.0, 0.0)
		MaskColorAdd("MaskColorAdd", Vector) = (0.0, 0.0, 0.0, 0.0)
		Base_Tex_SRGB("Base_Tex_SRGB", 2D) = "white" {}
		NormalMap_Tex_NRM("NormalMap_Tex_NRM", 2D) = "white" {}
		SpecularMap_Tex_LIN("SpecularMap_Tex_LIN", 2D) = "white" {}
		BurnPattern_Tex_LIN("BurnPattern_Tex_LIN", 2D) = "white" {}
		Layer_Tex_SRGB("Layer_Tex_SRGB", 2D) = "white" {}
		Dirty_Tex_LIN("Dirty_Tex_LIN", 2D) = "white" {}
	}
		
	Subshader
	{
		Tags{ "Queue" = "AlphaTest" "Ignore Projector" = "True" "RenderType" = "Opaque" }
		LOD 200

		Blend SrcAlpha OneMinusSrcAlpha

		AlphaToMask On

		Pass
		{
			ZWrite Off
			ColorMask 0
		}

		CGPROGRAM

		#pragma surface surf Standard fullforwardshadows alpha
		#pragma target 3.0

		sampler2D Base_Tex_SRGB;
		sampler2D NormalMap_Tex_NRM;
		sampler2D SpecularMap_Tex_LIN;
		sampler2D Translucent_Tex_LIN;

		struct Input
		{
			float2 uvBase_Tex_SRGB;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 mainTex = tex2D(Base_Tex_SRGB, IN.uvBase_Tex_SRGB);
			o.Albedo = mainTex.rgb;
			o.Alpha = mainTex.a;
			o.Metallic = 0.0f;
			o.Smoothness = 1.0f - tex2D(SpecularMap_Tex_LIN, IN.uvBase_Tex_SRGB).g;
			fixed4 finalNormal = tex2D(NormalMap_Tex_NRM, IN.uvBase_Tex_SRGB);
			finalNormal.r = finalNormal.g;
			finalNormal.g = 1.0f - finalNormal.g;
			finalNormal.b = 1.0f;
			finalNormal.a = 1.0f;
			o.Normal = UnpackNormal(finalNormal);
		}
		ENDCG
	}
	FallBack "Standard"
}