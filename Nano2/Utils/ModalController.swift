//
//  ModalController.swift
//  Nano2
//
//  Created by Felipe Melo on 2/2/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class ModalController {
    
    static func showSaveStory(viewController view: StoryViewController, message: String, currentStory: [Frame]) {
        let alert = UIAlertController(
            title: "Save Story",
            message: "Give a name to your story",
            preferredStyle: .alert
        )
        
        alert.addTextField(configurationHandler: { (textField) in
            
        })
        alert.addAction(
            UIAlertAction(
                title: "Save",
                style: .default,
                handler: { [weak alert] (_) in
                    if let storyName = alert?.textFields![0].text {
                        guard storyName != "" else {
                            ModalController.showErrorMessage(viewController: view, message: view.EMPTY_NAME)
                            return
                        }
                        
                        RemoteDataBase.addStory(name: storyName, story: currentStory)
                        RemoteDataBase.removeCurrentStory()
                        
                        let vc = view.storyboard?.instantiateViewController(withIdentifier: view.READ_STORY) as! ReadStoryViewController
                        vc.setup(with: currentStory)
                        view.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            )
        )
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .destructive,
                handler: nil
            )
        )
        
        view.present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    static func showErrorMessage(viewController view: UIViewController, message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: nil
            )
        )
        
        view.present(
            alert,
            animated: true,
            completion: nil
        )
    }
}
