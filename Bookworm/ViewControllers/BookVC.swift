//
//  BookVC.swift
//  Bookworm
//
//  Created by Berkay Kuzu on 25.10.2022.
//

import UIKit
import Parse

class BookVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var bookNameArray = [String]()
    var bookIdArray = [String]()
    var selectedBookId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromParse()
    }
    
    //MARK: - getDataFromParse
    
    func getDataFromParse () {
        
        let query = PFQuery(className: "Books")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                if objects != nil {
                    
                    self.bookNameArray.removeAll(keepingCapacity: false)
                    self.bookIdArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let bookName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId {
                                self.bookNameArray.append(bookName)
                                self.bookIdArray.append(placeId)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookDetailVC" {
            let destinationVC = segue.destination as! BookDetailVC
            destinationVC.chosenBookId = selectedBookId
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBookId = bookIdArray[indexPath.row]
        self.performSegue(withIdentifier: "toBookDetailVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = UITableViewCell()
        cell.textLabel?.text = bookNameArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return bookNameArray.count
    }
    
   // func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     //   if editingStyle == .delete {
       //     self.bookNameArray.remove(at: indexPath.row)
         //   tableView.deleteRows(at: [indexPath], with: .automatic)
       // }
        
        
   // }
    
    func makeAlert (titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
