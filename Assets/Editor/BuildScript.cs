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
        // ���������Ҫ�����ĳ���·��
        string[] scenes = { "Assets/Scenes/Main.unity", "Assets/Scenes/Level1.unity" };

        // ���ù������·��
        string pathToDeploy = "Builds/Windows/Game.exe";

        // ������Ŀ
        BuildPipeline.BuildPlayer(scenes, pathToDeploy, BuildTarget.StandaloneWindows64, BuildOptions.None);
    }
}
