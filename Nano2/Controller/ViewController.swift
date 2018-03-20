//
//  ViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/29/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Static
    let LIBRARY_CELL = "libraryCell"
    let CELL_HEIGHT: CGFloat = 150
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    private var stories = [Story]()
    private var tableHeight: CGFloat!
    private var tableWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.tableHeight = self.tableView.bounds.size.height
        self.tableWidth = self.tableView.bounds.size.width
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let stories = UserStorage.loadStories() {
            self.stories = stories
            self.tableView.reloadData()
            self.animateView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func animateView() {
        for cell in self.tableView.visibleCells {
            let libraryCell = cell as! LibraryCell
            libraryCell.transform = CGAffineTransform(translationX: -self.tableWidth, y: 0)
        }
        
        var index = 0
        for cell in self.tableView.visibleCells {
            let libraryCell = cell as! LibraryCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                libraryCell.transform = CGAffineTransform.identity
            }, completion: nil)
            
            index += 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LIBRARY_CELL {
            let cell = sender as! LibraryCell
            if let indexPath = tableView.indexPath(for: cell) {
                let vc = segue.destination as! ReadStoryViewController
                vc.story = self.stories[indexPath.row].getFrames()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIBRARY_CELL, for: indexPath) as! LibraryCell
        
        cell.descriptionLabel.text = stories[indexPath.row].getName()
        cell.storyImage.image = stories[indexPath.row].getFirstImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.LIBRARY_CELL, for: indexPath)
            self.slideOff(cell, index: indexPath.row)
            
            UserStorage.saveStories(stories: self.stories)
        }
        
        return [delete]
    }
    
    private func slideOff(_ cell: UITableViewCell, index: Int) {
        
        UIView.animate(withDuration: 0.5, animations: {
            cell.transform = CGAffineTransform(translationX: -100, y: 0)
            cell.alpha = 0
        })
        
        self.stories.remove(at: index)
        self.tableView.reloadData()
        
        var cellIndex = 0
        for libraryCell in self.tableView.visibleCells {
            if cellIndex >= index {
                libraryCell.transform = CGAffineTransform(translationX: 0, y: libraryCell.bounds.size.height)
                
                UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
                    libraryCell.transform = CGAffineTransform.identity
                })
            }
            
            cellIndex += 1
        }
    }
}
