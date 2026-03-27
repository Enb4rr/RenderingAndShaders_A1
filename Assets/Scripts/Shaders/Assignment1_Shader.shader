Shader "Unlit/HeadShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Period ("Period", Range(0.0, 100.0)) = 1.0
        _PulseStrength ("Pulse Strength", Range(0.0, 1.0)) = 0.2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Period;
            float _PulseStrength;

            v2f vert (appdata v)
            {
                v2f o;

                // Wave movement (made in class)
                v.vertex.x += sin(_Time.y + v.vertex.y * _Period);

                // Small extra up/down movement (Assignment)
                v.vertex.y += sin(_Time.y * 2.0 + v.vertex.x * _Period) * 0.1;
                
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // Sample the texture (made in class)
                fixed4 col = tex2D(_MainTex, i.uv);

                // Uncomment and Comment the effect you want you want to see :)

                // Pulsing brightness effect (Assignment)
                // float pulse = sin(_Time.y * 2.0) * _PulseStrength;
                // col.rgb += pulse;

                // Pulsing brightness effect from to top Bottom (Assignment)
                float wave = sin(i.uv.y * 10.0 - _Time.y * 3.0) * 0.2;
                col.rgb += wave;
                
                // Apply fog (made in class)
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
