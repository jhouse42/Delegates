//
//  WebViewController.swift
//  PlantFavs
//
//  Created by Jeanie House on 4/23/15.
//  Copyright (c) 2015 Jeanie House. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    
    
    @IBOutlet var webView: UIWebView!
    
    var url: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
}
