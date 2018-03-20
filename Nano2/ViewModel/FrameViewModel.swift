//
//  FrameViewModel.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

protocol FrameViewModelProtocol {
    var frame: Frame! { get }
    init(image: UIImage, text: String)
    func saveFrame()
    mutating func setFrameImage(image: UIImage)
    mutating func setFrameText(text: String)
}

final class FrameViewModel: FrameViewModelProtocol {
    var frame: Frame!
    
    init(image: UIImage, text: String) {
        frame = Frame(image: image, text: text)
    }
    
    func saveFrame() {
        RemoteDataBase.saveFrame(frame: frame)
    }
    
    func setFrameImage(image: UIImage) {
        frame.image = image
    }
    
    func setFrameText(text: String) {
        frame.text = text
    }
}
