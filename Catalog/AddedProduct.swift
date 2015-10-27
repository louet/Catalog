//
//  AddedProduct.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 26..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import Foundation
import RealmSwift

class AddedProduct {
    static let sharedAddedProduct = AddedProduct()
    
    var addedItems : [String] = []
    let realm : Realm
    
    init(){
        realm = try! Realm()
        
        let list = Array(realm.objects(CartItem))
        for l in list {
            addedItems.append(l.name)
        }
    }
    
    func add(name: String){
        addedItems.insert(name, atIndex: 0)
        
        let item = CartItem()
        item.name = name
        do{
            try self.realm.write({
                self.realm.add(item)
            })
        }catch {
            print("Exception")
        }
    }
}

class CartItem: Object {
    dynamic var name : String = ""
}