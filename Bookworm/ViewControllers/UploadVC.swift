//
//  UploadVC.swift
//  Bookworm
//
//  Created by Berkay Kuzu on 25.10.2022.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    
    @IBOutlet weak var bookNameText: UITextField!
    
    @IBOutlet weak var bookCommentText: UITextField!
    
    @IBOutlet weak var bookReaderText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uploadImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        uploadImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func choosePicture() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        //Parse
        
        if bookNameText.text != "" && bookCommentText.text != "" && bookReaderText.text != "" {
            if let chosenImage = uploadImageView.image {
                let bookModel = BookModel.sharedInstance
                bookModel.bookName = bookNameText.text!
                bookModel.bookComment = bookCommentText.text!
                bookModel.bookReaderName = bookReaderText.text!
                bookModel.bookImage = chosenImage
            }
        
        let bookModel = BookModel.sharedInstance
        
        let object = PFObject(className: "Books")
        object["name"]  = bookModel.bookName
        object["comment"] = bookModel.bookComment
        object["bookreader"] = bookModel.bookReaderName
        
        if let imageData = bookModel.bookImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
        }
        object.saveInBackground { (success, error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                self.performSegue(withIdentifier: "fromUploadVCtoBookVC", sender: nil)
            }
        }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Book Name/Comment/Reader ???")
        }
}
    
    func makeAlert (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
