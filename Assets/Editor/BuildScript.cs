using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class NewBehaviourScript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}

public class BuildScript
{
    public static void Build()
    {
        // 添加所有需要构建的场景路径
        string[] scenes = { "Assets/Scenes/Main.unity", "Assets/Scenes/Level1.unity" };

        // 设置构建输出路径
        string pathToDeploy = "Builds/Windows/Game.exe";

        // 构建项目
        BuildPipeline.BuildPlayer(scenes, pathToDeploy, BuildTarget.StandaloneWindows64, BuildOptions.None);
    }
}
