//
//  CartManager.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 27..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import Foundation
import RealmSwift

import SwiftyJSON
import Alamofire

class CartManager {
    static let sharedCartManager = CartManager()
    static let className = "CartManager"
    
    var cartItems : [CartItem]
//    var cartItems : Results<CartItem>
    let realm : Realm
    
    init(){
        realm = try! Realm()
        cartItems = []
//        cartItems = realm.objects(CartItem).reverse()
//        let list = Array(realm.objects(CartItem))
//        for l in list {
//            cartItems.append(l.name)
//        }
        
//        cartItems = realm.objects(CartItem)
    }
    
    func add(name: String){
        MyRequestController.sharedInstance.contains(name)
//        var item = CartItem()
//        item.name = name
        
//        if let ci = contains(item) {
//            do{
//                try realm.write({
//                    ci.count += 1
//                    item = ci
//                })
//            }catch{
//                
//            }
//        }else{
//            cartItems.insert(item, atIndex: 0)
//        }
//        
//        do{
//            try self.realm.write({
//                self.realm.add(item, update: true)
//            })
//        }catch {
//            Log().p(self, message: "Exception while add")
//        }
    }
    
    func delete(item: CartItem) {
        Log().p(self, message: "delete")
        realm.delete(item)
    }
    
    func deleteAll() {
        Log().p(self, message: "deleteAll")
        realm.deleteAll()
    }
    
    func contains(item: CartItem) -> CartItem?{
        Log().p(self, message: "contains")
        for ci in cartItems {
            if ci.name == item.name {
                return ci
            }
        }
        return nil
    }
    
}