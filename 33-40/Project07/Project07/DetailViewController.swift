//
//  DetailViewController.swift
//  Project07
//
//  Created by Rafael Dias on 15/05/20.
//  Copyright © 2020 Rafael Dias. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style> body>p { font-size: 150% } </style>
            </head>
            <body>
                <h1>\(detailItem.title)</h1>
                <p>\(detailItem.body)</p>
            </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
    
}
