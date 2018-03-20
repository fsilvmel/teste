//
//  StoryViewModel.swift
//  Nano2
//
//  Created by Felipe Melo on 20/03/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import Foundation

protocol StoryViewModelProtocol {
    func removeCurrentStory()
    func loadCurrentStory() -> [Frame]?
}

final class StoryViewModel: StoryViewModelProtocol {
    func removeCurrentStory() {
        RemoteDataBase.removeCurrentStory()
    }
    
    func loadCurrentStory() -> [Frame]? {
        return RemoteDataBase.loadCurrentStory()
    }
}
