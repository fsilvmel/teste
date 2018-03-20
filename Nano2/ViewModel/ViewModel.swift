//
//  viewModelController.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit
import SimpleTwoWayBinding

final class ViewModel {
    // Variables
    var stories: Observable<[Story]> = Observable()
    
    required init() {
        updateStories()
    }
    
    func updateStories() {
        if let stories = RemoteDataBase.loadStories() {
            self.stories.value = stories
        } else {
            self.stories.value = []
        }
    }
    
    func saveStories() {
        RemoteDataBase.saveStories(stories: stories.value!)
    }
    
    func removeStory(at index: Int) {
        stories.value!.remove(at: index)
    }
}
