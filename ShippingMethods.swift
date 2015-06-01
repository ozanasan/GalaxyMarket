//
//  ShippingMethods.swift
//  GalaxyMarket
//
//  Created by Ozan Asan on 27/05/15.
//  Copyright (c) 2015 OzanAsan. All rights reserved.
//

import UIKit

struct ShippingWays {
    let shippingCost : NSDecimalNumber
    let shippingTitle : String
    
    init(price : NSDecimalNumber, title : String) {
        self.shippingCost = price
        self.shippingTitle = title
    }
    
}
