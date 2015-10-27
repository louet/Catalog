//
//  DetailViewController.swift
//  Catalog
//
//  Created by 권영각 on 2015. 10. 26..
//  Copyright © 2015년 LTCompany. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var webView: UIWebView!
    
    var name : String!
    var url : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        label.text = name
        showWebViewWithUrl(url)
    }
    
    func showWebViewWithUrl(url: String){
        let url = NSURL(string: url)
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
    }
}
