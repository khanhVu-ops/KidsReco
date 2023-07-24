//
//  WebViewViewController.swift
//  KidsReco
//
//  Created by Khanh Vu on 20/07/5 Reiwa.
//

import UIKit
import WebKit

class WikiWebViewViewController: UIViewController {
    private let webView: WKWebView = {
        let preference = WKWebpagePreferences()
        preference.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preference
        let webView = WKWebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    private var url: URL?
    private var domainWiki = "https://en.wikipedia.org/wiki/"
    
    init(title: String) {
        self.domainWiki += title
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.url = URL(string: self.domainWiki)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        guard let url = url else {
            return
        }
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
    
    @objc private func didTapDone(_ sender: UIButton) {
        sender.dimButton()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRefresh(_ sender: UIButton) {
        sender.dimButton()
        guard let url = url else {
            return
        }
        webView.load(URLRequest(url: url))
    }
}
