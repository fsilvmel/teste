//
//  PermissionViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/30/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit
import AVKit

final class PermissionViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func givePermissionClicked(_ sender: UIButton) {
        AVCaptureDevice.requestAccess(for: .video) { (response) in
            if response {
                self.presentStartView()
            } else {
                self.showAlertMessage()
            }
        }
    }
    
    func presentStartView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StartApp")
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlertMessage() {
        let alert = UIAlertController(title: "Alert", message: "To use Party Story Builder app, you must give permission to use your camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
