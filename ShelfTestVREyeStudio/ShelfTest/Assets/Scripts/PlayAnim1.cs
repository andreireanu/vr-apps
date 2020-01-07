using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayAnim1 : MonoBehaviour {


    public Animator animator;
    public LevelManager levelManager;

    // Use this for initialization
    void Start () {
        animator = GetComponent<Animator>();
	}
	

    public void Run()
    {
        animator.SetBool("start", true);
    }

	// Update is called once per frame
	void Update () {

        if (animator.GetCurrentAnimatorStateInfo(0).IsName("EndState"))
        {
            Debug.Log("ANIM FINISHED");
            levelManager.LoadNextLevel();
        }
    }
}
