//
//  Post.swift
//  Lab_2
//
//  Created by Владислав Якубец on 28.11.2020.
//

import Foundation
import UIKit

struct Post {
    
    public var title: String = ""
    public var link: String = ""
    public var date: String = ""
    public var imageURL: String = ""
    
    init(title: String, link: String, date: String, imageURL: String) {
        
        self.title = title
        self.link = link
        self.date = date
        self.imageURL = imageURL
    }
}
