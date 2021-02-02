//
//  Sources.swift
//  Lab_2
//
//  Created by Владислав Якубец on 28.11.2020.
//

import Foundation
import UIKit

struct Source {
    
    var sourceName: String!
    var sourceRssLink: String!

    
    init(sourceName: String, sourceRssLink: String) {
        
        self.sourceName = sourceName
        self.sourceRssLink = sourceRssLink
    }
}
