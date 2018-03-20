//
//  viewModelController.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

protocol ViewModelProtocol {
    var stories: [Story]! { get }
    var storiesDidChange: (() -> ())? { get set }
    
    func updateStories()
    func saveStories()
    mutating func removeStory(at index: Int)
}

final class ViewModel: ViewModelProtocol {
    // Variables
    var stories: [Story]! {
        didSet {
            storiesDidChange?()
        }
    }
    
    // Closures
    var storiesDidChange: (() -> ())?
    
    required init() {
        updateStories()
    }
    
    func updateStories() {
        if let stories = RemoteDataBase.loadStories() {
            self.stories = stories
        } else {
            self.stories = []
        }
    }
    
    func saveStories() {
        RemoteDataBase.saveStories(stories: stories)
    }
    
    func removeStory(at index: Int) {
        stories.remove(at: index)
    }
}
