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
        let instance = MyRequestController.sharedInstance
        let ret = instance.contains(name)
        
        if ret.0 {
            let item = ret.1 as! CartItem
            let count = item.count + 1
            instance.updateObject(item, count: count)
        }
        else {
            let n = ret.1 as! String
            instance.createObject(n)
        }
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
    
    func delete(productCode: String) {
        Log().p(self, message: "delete")
        let instance = MyRequestController.sharedInstance
        
        let ret = instance.contains(productCode)
        let item = ret.1 as! CartItem
        
        if instance.checkCountOne(item.count) {
            instance.deleteObject(item)
        }
        else {
            let count = item.count - 1
            instance.updateObject(item, count: count)
        }
//        realm.delete(item)
    }
    
//    func deleteAll() {
//        Log().p(self, message: "deleteAll")
//        realm.deleteAll()
//    }
//    
//    func contains(item: CartItem) -> CartItem?{
//        Log().p(self, message: "contains")
//        for ci in cartItems {
//            if ci.name == item.name {
//                return ci
//            }
//        }
//        return nil
//    }
}