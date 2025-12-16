//
//  RouteVC.swift
//  Patna Metro
//
//  Created by Rohit on 20/09/25.
//

import UIKit
import WebKit

class RouteVC: UIViewController {

    var webView: WKWebView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // WKWebView initialize
            webView = WKWebView(frame: self.view.bounds)
            webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(webView)
            
            webView.scrollView.isScrollEnabled = true
            webView.scrollView.bounces = false

            
            // Load local HTML
            if let path = Bundle.main.path(forResource: "index", ofType: "html") {
                let url = URL(fileURLWithPath: path)
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        }

}
