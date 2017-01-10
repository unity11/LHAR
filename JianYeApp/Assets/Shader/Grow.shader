Shader "Unlit/Grow"
{
	Properties{
		_TintColor("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex("Particle Texture", 2D) = "white" {}
		_Sness("Sness",float) = 1
	}

		Category{
			Tags{ "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
			Blend SrcAlpha  OneMinusSrcAlpha
			//Blend SrcAlpha One
				AlphaTest Greater .01
				ColorMask RGB
				Cull Off Lighting Off ZWrite Off

				SubShader{
				Pass{

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag



				#include "UnityCG.cginc"
				float _Sness;
			sampler2D _MainTex;
			fixed4 _TintColor;

				struct appdata_t {
					float4 vertex : POSITION;

					float2 uv : TEXCOORD0;
				};

				struct v2f {
					float4 vertex : SV_POSITION;

					float2 uv : TEXCOORD0;

				};

				float4 _MainTex_ST;

				v2f vert(appdata_t v)
				{
					v2f o;
					o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
					o.uv = TRANSFORM_TEX(v.uv,_MainTex);
					return o;
				}

				sampler2D_float _CameraDepthTexture;
				float _InvFade;

				fixed4 frag(v2f i) : SV_Target
				{
					float4 c = tex2D(_MainTex, i.uv);
					c.g = 0;
					c.b = 0;
					c.a = c.r*_Sness;
			//		fixed4 col =_TintColor * c;

					return c;
				}
				ENDCG
			}
		}
	}
}
