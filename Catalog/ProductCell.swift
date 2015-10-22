//
//  ProductCell.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 22..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit
protocol ProductCellDelegate : class {
    func addCart(productCode: String)
}
class ProductCell: UITableViewCell {
    
    weak var delegate : ProductCellDelegate!
    var productCode : String!

    @IBOutlet weak var imgProductImage: UIImageView!
    @IBOutlet weak var txtProductName: UILabel!
    @IBOutlet weak var txtProductPrice: UILabel!
    @IBOutlet weak var btnBuy: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addButtonClicked(sender: AnyObject) {
        delegate.addCart(productCode)
    }
}
