//
//  ViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/29/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import Foundation
import UIKit

final class ViewController: BaseMVVMViewController, BaseMVVMViewControllerProtocol {

    // Static
    let LIBRARY_CELL = "libraryCell"
    let CELL_HEIGHT: CGFloat = 150
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // ViewModel
    typealias MVVMProtocol = ViewModelProtocol
    var viewModel: MVVMProtocol! {
        didSet {
            viewModel.storiesDidChange = {
                self.tableView.reloadData()
                self.animateView()
            }
        }
    }
    
    // Variables
    var tableHeight: CGFloat!
    var tableWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.updateStories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        viewModel = ViewModel()
        setupTableView()
    }
    
    private func animateView() {
        for cell in tableView.visibleCells {
            let libraryCell = cell as! LibraryCell
            libraryCell.transform = CGAffineTransform(translationX: -tableWidth, y: 0)
        }
        
        var index = 0
        for cell in tableView.visibleCells {
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
                let story =  viewModel.stories[indexPath.row]
                vc.setup(with: story.getFrames())
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableHeight = tableView.bounds.size.height
        tableWidth = tableView.bounds.size.width
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LIBRARY_CELL, for: indexPath) as! LibraryCell
        
        let story = viewModel.stories[indexPath.row]
        cell.descriptionLabel.text = story.getName()
        cell.storyImage.image = story.getFirstImage()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.LIBRARY_CELL, for: indexPath)
            self.slideOff(cell, index: indexPath.row)
            
            self.viewModel.saveStories()
        }
        
        return [delete]
    }
    
    private func slideOff(_ cell: UITableViewCell, index: Int) {
        
        UIView.animate(withDuration: 0.5, animations: {
            cell.transform = CGAffineTransform(translationX: -100, y: 0)
            cell.alpha = 0
        })
        
        viewModel.removeStory(at: index)
        
        var cellIndex = 0
        for libraryCell in tableView.visibleCells {
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
