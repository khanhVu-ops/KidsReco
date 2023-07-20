//
//  WebViewViewController.swift
//  KidsReco
//
//  Created by Khanh Vu on 20/07/5 Reiwa.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    private let webView: WKWebView = {
        let preference = WKWebpagePreferences()
        preference.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    private let url: URL
    
    init(url: URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
        configButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    private func configButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
    }
    
    @objc private func didTapDone() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRefresh() {
        webView.load(URLRequest(url: url))
    }
}
