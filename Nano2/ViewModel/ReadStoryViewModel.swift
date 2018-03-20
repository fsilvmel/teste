//
//  ReadStoryViewModel.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import Foundation

protocol ReadStoryViewModelProtocol {
    var story: [Frame]! { get }
}

final class ReadStoryViewModel: ReadStoryViewModelProtocol {
    var story: [Frame]!
    
    init() {
        story = [Frame]()
    }

    init(with story: [Frame]) {
        self.story = story
    }
}