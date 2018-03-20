//
//  FrameViewController.swift
//  Nano2
//
//  Created by Felipe Melo on 1/30/18.
//  Copyright © 2018 Felipe Melo. All rights reserved.
//

import UIKit

class FrameViewController: UIViewController, UINavigationControllerDelegate {

    // Statics
    let LIMIT_LENGTH = 30
    let KEYBOARD_SIZE: CGFloat = 200
    
    // Outlets
    @IBOutlet weak var pictureImage: UIImageView!
    @IBOutlet weak var pictureText: UITextField!
    
    // Variables
    private var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePictureClicked(_ sender: Any) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .camera
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func finishFrameClicked(_ sender: Any) {
        self.saveFrame()
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveFrame() {
        let frame = Frame(image: pictureImage.image!, text: pictureText.text!)
        
        UserStorage.saveFrame(frame: frame)
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

extension FrameViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imagePicker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pictureImage.image = image
        }
    }
    
}

extension FrameViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(FrameViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            self.view.frame.origin.y -= KEYBOARD_SIZE
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += KEYBOARD_SIZE
    }
}

extension FrameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
            
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= LIMIT_LENGTH
    }
}
