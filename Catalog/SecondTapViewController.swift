//
//  SecondTapViewController.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 26..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit

class SecondTapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var items = CartManager.sharedCartManager.cartItems
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleModelChange:", name: "ModelChange", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleModelChange(notification: NSNotification){
        print("handleModelChange")
        if let info = notification.userInfo {
            if let name = info["name"] as? String {
                insertData(name)
                tableView.reloadData()
            }
        }
    }
    
    func insertData(name: String){
        items.insert(name, atIndex: 0)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView count \(items.count)")
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ADD_CELL")!
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}
