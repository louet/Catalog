//
//  ViewController.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 22..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ProductCellDelegate {
    
    @IBOutlet weak var tableProduct: UITableView!
    let items = Product().items
    var addedItems : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCart(productCode : String) {
        print(productCode)
        addedItems.append(productCode)
        tableProduct.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PRODUCT_CELL") as! ProductCell
            
            let row = indexPath.row
            let name = items[row].name
            let price = items[row].price
            let code = items[row].code
            
            cell.imgProductImage.image = UIImage(named: "\(name).png")
            cell.btnBuy.setImage(UIImage(named: "cart.png"), forState: .Normal)
            cell.productCode = code
            cell.txtProductName.text = name
            cell.txtProductPrice.text = price
            
            cell.delegate = self
            return cell
        }
        else {
            let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "aa")
            let row = indexPath.row
            cell.textLabel?.text = addedItems[row]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return items.count
        case 1:
            return addedItems.count
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
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
    
}

