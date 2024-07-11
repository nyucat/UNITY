using System.Collections;
using System.Collections.Generic;

using UnityEditor;
using UnityEngine;

public class BuildScript
{
    public static void PerformBuild()
    {
        string[] scenes = { "Assets/Scenes/0.unity", "Assets/Scenes/1.unity" }; // 替换为你的场景路径
        BuildPipeline.BuildPlayer(scenes, "F:\\mygame\\MyGame.exe", BuildTarget.StandaloneWindows, BuildOptions.None);
        Debug.Log("Build Completed!");
    }
}
