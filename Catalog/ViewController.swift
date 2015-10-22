//
//  ViewController.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 22..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let names = Product().names
    let prices = Product().prices

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PRODUCT_CELL") as! ProductCell
//        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        
        let row = indexPath.row
        let name = names[row]
        
        cell.imgProductImage.image = UIImage(named: "\(name).png")
        cell.txtProductName.text = name
        cell.txtProductPrice.text = prices[name]
        cell.btnBuy.setImage(UIImage(named: "cart.png"), forState: .Normal)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
}

