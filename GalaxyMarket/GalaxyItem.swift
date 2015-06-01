//
//  GalaxyItem.swift
//  GalaxyMarket
//
//  Created by Ozan Asan on 25/05/15.
//  Copyright (c) 2015 OzanAsan. All rights reserved.
//

import UIKit

class GalaxyItem {
    let ItemName : String
    let ItemPrice : Int
    let ItemImage : UIImage?
    let ItemDescription : String
    
    init(name: String, price : Int, image : UIImage?, description: String) {
        self.ItemName = name
        self.ItemPrice = price
        self.ItemImage = image
        self.ItemDescription = description
    }
}
