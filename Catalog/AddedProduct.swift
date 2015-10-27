//
//  AddedProduct.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 26..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import Foundation

class AddedProduct {
    static let sharedAddedProduct = AddedProduct()
    
    var addedItems : [String] = []
}