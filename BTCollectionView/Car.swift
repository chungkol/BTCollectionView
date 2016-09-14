//
//  Car.swift
//  BTCollectionView
//
//  Created by Chung on 9/13/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import Foundation
class Car: NSObject {
    var name: String?
    var content: String?
    var images: [String] = []
    
    init(name: String, content: String , images: [String]) {
        self.name = name
        self.content = content
        self.images  = images
    }
}
