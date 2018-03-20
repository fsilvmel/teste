//
//  ReadStoryViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/30/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

final class ReadStoryViewController: BaseMVVMViewController, BaseMVVMViewControllerProtocol {
    
    // Statics
    let STORY_CELL = "storyCell"
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // ViewModel
    var viewModel: ReadStoryViewModel!
    
    // Variables
    var frame = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func prevClicked(_ sender: UIButton) {
        if frame > 0 {
            frame -= 1
        }
        
        self.scrollAt()
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        if frame < viewModel.story.count - 1 {
            frame += 1
        }
        
        self.scrollAt()
    }
    
    private func setup() {
        setupCollectionView()
    }
    
    func setup(with story: [Frame]) {
        viewModel = ReadStoryViewModel(with: story)
    }
    
    func scrollAt() {
        let indexPath = IndexPath(item: frame, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension ReadStoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.story.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STORY_CELL, for: indexPath) as! ReadStoryCell
        
        let story = viewModel.story[indexPath.row]
        cell.storyImage.image = story.image
        cell.storyText.text = story.text
        
        return cell
    }
}
