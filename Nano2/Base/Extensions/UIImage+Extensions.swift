//
//  UIImage+Extensions.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit
import SimpleTwoWayBinding

extension UIImageView: Bindable {
    public typealias BindingType = UIImage
    
    public func observingValue() -> UIImage? {
        return self.image
    }
    
    public func updateValue(with value: UIImage) {
        self.image = value
    }
}
