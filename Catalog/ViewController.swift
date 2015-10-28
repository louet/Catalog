//
//  ViewController.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 22..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, ProductCellDelegate {
    
    @IBOutlet weak var tableProduct: UITableView!
    let items = Product().items
    let cartManager = CartManager.sharedCartManager

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        MyRequestController.sharedInstance.sendRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCart(productCode : String) {
        print(productCode)
        cartManager.add(productCode)
        NSNotificationCenter.defaultCenter().postNotificationName("ModelChange", object: nil, userInfo: ["name": productCode])
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PRODUCT_CELL") as! ProductCell
        
        let row = indexPath.row
        let name = items[row].name
        let price = items[row].price
        
        cell.imgProductImage.image = UIImage(named: "\(name).png")
        cell.btnBuy.setImage(UIImage(named: "cart.png"), forState: .Normal)
        cell.productCode = name
        cell.txtProductName.text = name
        cell.txtProductPrice.text = price
        
        cell.delegate = self
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section){
        case 0:
            return "Product"
        case 1:
            return "Cart"
        default:
            return "default"
        }
    }
    
    override func performSegueWithIdentifier(identifier: String, sender: AnyObject?) {
        if "SEGUE1" == identifier{
            showDetailViewController(self, sender: sender)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if "SEGUE1" == segue.identifier {
            let cell = sender as! UITableViewCell
            
            let index = tableProduct.indexPathForCell(cell)!
            let name = items[index.row].name
            
            let detailVC = segue.destinationViewController as! DetailViewController
            detailVC.name = name
            detailVC.url = "https://en.wikipedia.org/wiki/\(name)"
            
            print(name)
        }
    }
}

