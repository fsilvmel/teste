//
//  StoryViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/30/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

final class StoryViewController: BaseMVVMViewController, BaseMVVMViewControllerProtocol {
    
    // Statics
    let READ_STORY = "readStory"
    let CURRENT_STORY = "currentStory"
    let NO_FRAMES = "Your story has no frames!"
    let EMPTY_NAME = "Please give a name to your new story!"
    
    // ViewModel
    typealias MVVMProtocol = StoryViewModelProtocol
    var viewModel: MVVMProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func finishStoryClicked(_ sender: Any) {
        if let currentStory = viewModel.loadCurrentStory() {
            ModalController.showSaveStory(viewController: self, message: EMPTY_NAME, currentStory: currentStory)
        } else {
            ModalController.showErrorMessage(viewController: self, message: NO_FRAMES)
        }
    }
    
    private func setup() {
        viewModel = StoryViewModel()
        viewModel.removeCurrentStory()
    }
}
