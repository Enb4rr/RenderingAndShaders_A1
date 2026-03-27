using System;
using UnityEngine;

public class AccessStuff : MonoBehaviour
{
    private Renderer _sineWave;
    
    private void Start()
    {
        _sineWave = GetComponent<Renderer>();
    }


    private void Update()
    {
        _sineWave.material.SetFloat("_Period", Input.mouseScrollDelta.x);
    }
}
