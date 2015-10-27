//
//  CartManager.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 27..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import Foundation
import RealmSwift

class CartManager {
    static let sharedCartManager = CartManager()
    
    var cartItems : [String] = []
    let realm : Realm
    
    init(){
        realm = try! Realm()
        
        let list = Array(realm.objects(CartItem))
        for l in list {
            cartItems.append(l.name)
        }
    }
    
    func add(name: String){
        cartItems.insert(name, atIndex: 0)
        
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