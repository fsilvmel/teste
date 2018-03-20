//
//  FrameViewModel.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit
import SimpleTwoWayBinding

final class FrameViewModel {
    let image: Observable<UIImage> = Observable()
    let text: Observable<String> = Observable()
    
    func setImage(image: UIImage) {
        self.image.value = image
    }
    
    func saveFrame() {
        let frame = Frame(image: image.value!, text: text.value!)
        RemoteDataBase.saveFrame(frame: frame)
    }
}
