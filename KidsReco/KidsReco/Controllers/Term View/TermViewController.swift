//
//  TermViewController.swift
//  KidsReco
//
//  Created by Khanh Vu on 28/07/5 Reiwa.
//

import UIKit

class TermViewController: BaseViewController {

    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false // Set to true if you want it to be editable
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = view.bounds
    }
    
    override func setUpUI() {
        self.title = "Terms and Conditions"
        self.view.addSubview(textView)
        let htmlText = "<p>This is an <b>HTML</b> formatted <i>text</i> in a UITextView.</p>"
        textView.attributedText = htmlText.htmlAttributedString(size: 18, color: .black)
    }

    override func setUpTap() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
    }
   
    @objc private func didTapDone(_ sender: UIButton) {
        sender.dimButton()
        self.dismiss(animated: true, completion: nil)
    }
}
