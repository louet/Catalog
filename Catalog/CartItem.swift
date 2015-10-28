//
//  AddedProduct.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 26..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import Foundation
import RealmSwift

class CartItem: Object {
    dynamic var objectId : String = ""
    dynamic var name : String = ""
    dynamic var count : Int = 1
    
    override static func primaryKey() -> String? {
        return "objectId"
    }
}