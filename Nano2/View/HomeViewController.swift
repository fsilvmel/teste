//
//  HomeViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 2/5/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func animateView() {
        animateButton()
        animateLabel()
    }
    
    private func animateButton() {
        animateObject(object: self.startButton, duration: 2, delay: 0)
    }
    
    private func animateLabel() {
        animateObject(object: self.authorLabel, duration: 2, delay: 1)
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
