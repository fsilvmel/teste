//
//  HomeViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 2/5/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.animateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func animateView() {
        self.animateButton()
        self.animateLabel()
    }
    
    private func animateButton() {
        self.animateObject(object: self.startButton, duration: 2, delay: 0)
    }
    
    private func animateLabel() {
        self.animateObject(object: self.authorLabel, duration: 2, delay: 1)
    }
    
    private func animateObject(object: UIView, duration: TimeInterval, delay: TimeInterval) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            object.frame.origin.x += 1000
        }, completion: nil)
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
