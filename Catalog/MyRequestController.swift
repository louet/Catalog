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
                self.initLocalCartItems(self.json!["results"])
        }
    }
    
    func initLocalCartItems(results : JSON) {
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
    
    func createObject(name: String) {
        Log().p(self, message: "creatingObject")
        
        let parameter = [
            "name" : name,
            "count" : 1
        ]
        
        Alamofire.request(.POST, "https://api.parse.com/1/classes/CartItem", parameters: parameter as! [String : AnyObject],encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                if nil == response.result.error {
                    print(response.result.error)
                }
                // update local data
                let result = JSON(response.result.value!)
                self.appendLocalCartItem(result["objectId"].stringValue, name: name)
        }
    }
    
    func updateObject(item: CartItem) {
        Log().p(self, message: "updateObject")
        let count = item.count + 1
        let parameter = [
            "name" : item.name,
            "count" : count
        ]
        
        Alamofire.request(.PUT, "https://api.parse.com/1/classes/CartItem/\(item.objectId)", parameters: parameter as! [String : AnyObject],encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                if nil == response.result.error {
                    print(response.result.error)
                }
                // update local data
                self.updateLocalCartItem(item, count: count)
                
        }
    }
    
    func appendLocalCartItem(objectId: String, name: String){
        let ci = CartItem()
        ci.name = name
        ci.count = 1
        ci.objectId = objectId
        self.cm.cartItems.append(ci)
    }
    
    func updateLocalCartItem(item : CartItem, count: Int){
        for ci in self.cm.cartItems {
            if item.objectId == ci.objectId {
                item.count = count
            }
        }
    }
}
