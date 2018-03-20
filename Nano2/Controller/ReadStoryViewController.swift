//
//  ReadStoryViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/30/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class ReadStoryViewController: UIViewController {
    
    // Statics
    let STORY_CELL = "storyCell"
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Variables
    var story = [Frame]()
    var frame = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prevClicked(_ sender: UIButton) {
        if frame > 0 {
            frame -= 1
        }
        
        self.scrollAt()
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        if frame < story.count - 1 {
            frame += 1
        }
        
        self.scrollAt()
    }
    
    func scrollAt() {
        let indexPath = IndexPath(item: frame, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ReadStoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return story.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STORY_CELL, for: indexPath) as! ReadStoryCell
        
        cell.storyImage.image = story[indexPath.row].image
        cell.storyText.text = story[indexPath.row].text
        
        return cell
    }
}
