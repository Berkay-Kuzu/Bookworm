//
//  BookModel.swift
//  Bookworm
//
//  Created by Berkay Kuzu on 25.10.2022.
//

import Foundation
import UIKit


class BookModel {
    static let sharedInstance = BookModel()
    
    var bookName = ""
    var bookComment = ""
    var bookImage = UIImage()
    var bookReaderName = ""
    
    private init () {
        
    }
}
