//
//  Frame.swift
//  Nano2
//
//  Created by Felipe Melo on 1/30/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class Frame: NSObject, NSCoding {
    
    var image: UIImage
    var text: String
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.image, forKey: "image")
        aCoder.encode(self.text, forKey: "text")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.image = aDecoder.decodeObject(forKey: "image") as! UIImage
        self.text = aDecoder.decodeObject(forKey: "text") as! String
    }
}
