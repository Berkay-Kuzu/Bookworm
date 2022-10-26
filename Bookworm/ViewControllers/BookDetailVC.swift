//
//  BookDetailVC.swift
//  Bookworm
//
//  Created by Berkay Kuzu on 25.10.2022.
//

import UIKit
import Parse

class BookDetailVC: UIViewController {

    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var detailNameLabel: UILabel!
    
    @IBOutlet weak var detailCommentLabel: UILabel!
    
    @IBOutlet weak var bookReaderLabel: UILabel!
    
    
    var chosenBookId = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getDataFromParse()
    }
    
    
    //MARK: - getDataFromParse
    
    
    
    func getDataFromParse () {
        let query = PFQuery(className: "Books")
        query.whereKey("objectId", equalTo: chosenBookId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                
            } else {
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenBookObject = objects![0]
                        
                        if let bookName = chosenBookObject.object(forKey: "name") as? String {
                            self.detailNameLabel.text = bookName
                        }
                        
                        if let bookComment = chosenBookObject.object(forKey: "comment") as? String {
                            self.detailCommentLabel.text = bookComment
                        }
                        
                        if let bookReader = chosenBookObject.object(forKey: "bookreader") as? String {
                            self.bookReaderLabel.text = bookReader
                        }
                        
                        
                        if let imageData = chosenBookObject.object(forKey: "image") as? PFFileObject {
                            imageData.getDataInBackground { data, error in
                                if error == nil {
                                    if data != nil {
                                        self.detailImageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    

}
