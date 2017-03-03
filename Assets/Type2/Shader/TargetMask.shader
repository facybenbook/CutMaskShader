﻿Shader "Custom/TargetMask" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent+10" }

		LOD 200

		// まず、ターゲット部分にマスクを掛ける
		Pass
		{
			Stencil
			{
				Ref 10
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}

			Cull Back
			Zwrite On
//			ColorMask 0

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0

			sampler2D _MainTex;

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
			};

			half _Glossiness;
			half _Metallic;
			fixed4 _Color;

			v2f vert(appdata i)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
				return o;
			}

			float4 frag(v2f i) : SV_Target
			{
				return half4(1, 0, 0, 1);
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}