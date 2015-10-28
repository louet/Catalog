//
//  CartCell.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 27..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit

protocol CartCellDelegate : class {
    func add()
    func remove()
}
class CartCell: UITableViewCell {
    
    weak var delegate : CartCellDelegate!

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func ClickedAddBtn(sender: AnyObject) {
        Log().p(self, message: "ClickedAddBtn")
        delegate.add()
    }
    @IBAction func ClickedRemoveBtn(sender: AnyObject) {
        Log().p(self, message: "ClickedRemoveBtn")
        delegate.remove()
    }

}
