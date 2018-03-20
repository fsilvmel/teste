//
//  UserStorage.swift
//  Nano2
//
//  Created by Felipe Melo on 2/2/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class UserStorage {
    
    // Statics
    static let storage = UserDefaults.standard
    static let CURRENT_STORY = "currentStory"
    static let STORIES = "stories"
    
    static func saveFrame(frame: Frame) {
        if var currentStory = self.loadCurrentStory() {
            currentStory.append(frame)
            
            let data  = NSKeyedArchiver.archivedData(withRootObject: currentStory)
            storage.set(data, forKey: CURRENT_STORY)
        } else {
            let currentStory = [frame]
            
            let data  = NSKeyedArchiver.archivedData(withRootObject: currentStory)
            storage.set(data, forKey: CURRENT_STORY)
        }
    }
    
    static func setCurrentStory(story: Story) {
        let data = NSKeyedArchiver.archivedData(withRootObject: story.getFrames())
        storage.set(data, forKey: CURRENT_STORY)
    }
    
    static func loadCurrentStory() -> [Frame]? {
        if let data = storage.object(forKey: CURRENT_STORY) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Frame]
        }
        
        return nil
    }
    
    static func removeCurrentStory() {
        storage.removeObject(forKey: CURRENT_STORY)
    }
    
    static func addStory(name: String, story frames: [Frame]) {
        let story = Story(name: name, frames: frames)
        
        if var stories = self.loadStories() {
            stories.append(story)
            
            self.saveStories(stories: stories)
        } else {
            let stories = [story]
            
            self.saveStories(stories: stories)
        }
    }
    
    static func saveStories(stories: [Story]) {
        let data  = NSKeyedArchiver.archivedData(withRootObject: stories)
        storage.set(data, forKey: STORIES)
    }
    
    static func loadStories() -> [Story]? {
        if let data = storage.object(forKey: STORIES) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [Story]
        }
        
        return nil
    }
}
