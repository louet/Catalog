//
//  MyRequestController.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 28..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MyRequestController {
    
    static let sharedInstance = MyRequestController()
    var json : JSON?
    
    let cm = CartManager.sharedCartManager
    
    let headers = [
        "X-Parse-REST-API-Key":"3v0eyAnbo4xiUzjWAstXzHvoUJdjpeFShIbQZmT0",
        "X-Parse-Application-Id":"AtyvEMidsSTXs2Ej7brlVqwKfzLcEGxtB8ZrMHZi",
        "Content-Type":"application/json"
    ]
    
    let encoding = Alamofire.ParameterEncoding.JSON
    
    func sendRequest() {
        
        // My API (2) (GET https://api.parse.com/1/classes/CartItem)
        
        // Create manager
        let manager = Manager.sharedInstance
        
        // Add Headers
        manager.session.configuration.HTTPAdditionalHeaders = [
            "X-Parse-REST-API-Key":"3v0eyAnbo4xiUzjWAstXzHvoUJdjpeFShIbQZmT0",
            "X-Parse-Application-Id":"AtyvEMidsSTXs2Ej7brlVqwKfzLcEGxtB8ZrMHZi",
            "Content-Type":"application/json",
        ]
        
        
        
        // Fetch Request
        Alamofire.request(.GET, "https://api.parse.com/1/classes/CartItem", encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                self.json = JSON(response.result.value!)
                self.initLocalData(self.json!["results"])
        }
    }
    
    func initLocalData(results : JSON) {
        let cm = CartManager.sharedCartManager
        for (_, item):(String,JSON) in results {
            let ci = CartItem()
            ci.objectId = item["objectId"].stringValue
            ci.name = item["name"].stringValue
            ci.count = item["count"].intValue
            
            cm.cartItems.append(ci)
        }
        print(cm.cartItems)
    }
    
    func contains(name: String) -> (Bool, AnyObject?){
        Log().p(self, message: "contains")
        
        for ci in cm.cartItems {
            if name == ci.name {
                return (true, ci)
            }
        }
        return (false, name)
    }
    
    
    func checkCountOne(count: Int) -> Bool {
        return (count == 1) ? true : false
    }
    
    func createObject(name: String) {
        Log().p(self, message: "creatingObject")
        
        let parameter : [String:AnyObject]! = [
            "name" : name,
            "count" : 1
        ]
        
        Alamofire.request(.POST, "https://api.parse.com/1/classes/CartItem", parameters: parameter,encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                if nil == response.result.error {
                    print(response.result.error)
                }
                // update local data
                let result = JSON(response.result.value!)
                self.appendLocalData(result["objectId"].stringValue, name: name)
        }
    }
    
    func updateObject(item: CartItem, count: Int) {
        Log().p(self, message: "updateObject")
        let parameter : [String:AnyObject]! = [
            "name" : item.name,
            "count" : count
        ]
        
        Alamofire.request(.PUT, "https://api.parse.com/1/classes/CartItem/\(item.objectId)", parameters: parameter ,encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                if nil == response.result.error {
                    print(response.result.error)
                }
                // update local data
                self.updateLocalData(item, count: count)
                
        }
    }
    
    func deleteObject(item: CartItem) {
        Alamofire.request(.DELETE, "https://api.parse.com/1/classes/CartItem/\(item.objectId)",encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                if nil == response.result.error {
                    print(response.result.error)
                }
                // update local data
                self.deleteLocalData(item)
        }
    }
    
    func appendLocalData(objectId: String, name: String){
        let ci = CartItem()
        ci.name = name
        ci.count = 1
        ci.objectId = objectId
        self.cm.cartItems.append(ci)
        
        callDataChangeNotificationToCartTap()
    }
    
    func updateLocalData(item : CartItem, count: Int){
        for ci in self.cm.cartItems {
            if item.objectId == ci.objectId {
                item.count = count
            }
        }
        
        callDataChangeNotificationToCartTap()
    }
    
    func deleteLocalData(item : CartItem) {
        var index = 0
        for ci in self.cm.cartItems {
            if item.objectId == ci.objectId {
                cm.cartItems.removeAtIndex(index)
                break
            }
            index++
        }
        callDataChangeNotificationToCartTap()
    }
    
    func callDataChangeNotificationToCartTap(){
        NSNotificationCenter.defaultCenter().postNotificationName("ModelChange", object: nil, userInfo: nil)
    }
}
