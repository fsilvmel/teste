//
//  StoryViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/30/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    // Statics
    let READ_STORY = "readStory"
    let CURRENT_STORY = "currentStory"
    let NO_FRAMES = "Your story has no frames!"
    let EMPTY_NAME = "Please give a name to your new story!"

    override func viewDidLoad() {
        super.viewDidLoad()

        UserStorage.removeCurrentStory()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func finishStoryClicked(_ sender: Any) {
        if let currentStory = UserStorage.loadCurrentStory() {
            ModalController.showSaveStory(viewController: self, message: EMPTY_NAME, currentStory: currentStory)
        } else {
            ModalController.showErrorMessage(viewController: self, message: NO_FRAMES)
        }
    }
}
