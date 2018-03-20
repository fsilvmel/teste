//
//  Story.swift
//  Nano2
//
//  Created by Felipe Melo on 2/2/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class Story: NSObject, NSCoding {
    
    // Private
    private var name: String!
    private var frames: [Frame]!
    
    init(name: String, frames: [Frame]) {
        self.name = name
        self.frames = frames
    }
    
    init(name: String, frame: Frame) {
        self.name = name
        self.frames = [frame]
    }
    
    func getName() -> String {
        return self.name
    }
    
    func getFrames() -> [Frame] {
        return self.frames
    }
    
    func getFirstImage() -> UIImage {
        return frames.first!.image
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.frames, forKey: "frames")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.frames = aDecoder.decodeObject(forKey: "frames") as! [Frame]
    }
}
