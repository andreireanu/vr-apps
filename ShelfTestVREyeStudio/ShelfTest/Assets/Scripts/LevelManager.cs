using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using UnityEngine.VR;

public class LevelManager : MonoBehaviour { 

    public InputField input;

    void Start()
    {
    }

    public void LoadLevel(string name)
    {
        Debug.Log("Level load requested for" + name);
        SceneManager.LoadScene(name);
     
    }

    public void QuitRequest()
    {
        Debug.Log("Quit requested for" + name);
    }

    public void LoadNextLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1 );
       // VRSettings.enabled = true;

    }

    public void LoadNextLevelDemo()
    {
        //   int val = int.Parse(input.text); 
        //    if ( val > 0 )
        //     {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
  //      }
    }

}
