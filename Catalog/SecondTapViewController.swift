//
//  SecondTapViewController.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 26..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SecondTapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CartCellDelegate{
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    var cartManager = CartManager.sharedCartManager
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        indicatorView.stopAnimating()
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleModelChange:", name: "ModelChange", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        tableView.reloadData()
    }
    
    func handleModelChange(notification: NSNotification){
        tableView.reloadData()
//        print("handleModelChange")
//        if let info = notification.userInfo {
//            if let name = info["name"] as? String {
//                insertData(name)
//            }
//        }
    }
    
//    func insertData(name: String){
//        Log().p(self, message: "insertData")
//        cartManager.add(name)
//    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView count \(cartManager.cartItems.count)")
        return cartManager.cartItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        Log().p(self, message: "create cell")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CART_CELL") as! CartCell
        
        let item = cartManager.cartItems[indexPath.row]
        cell.name.text = item.name
        cell.productCode = item.name
        cell.count.text = String(item.count)
        
        cell.delegate = self
        
        return cell
    }
    func add(productCode: String) {
        cartManager.add(productCode)
    }
    
    func remove(productCode: String) {
        cartManager.delete(productCode)
    }
}
