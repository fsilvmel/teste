//
//  BaseMVVMViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

protocol BaseMVVMViewControllerProtocol {
    associatedtype MVVMProtocol
    var viewModel: MVVMProtocol! { get set }
}

class BaseMVVMViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
