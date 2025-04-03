//
//  CouponController.swift
//  App
//
//  Created by 海野 颯汰   on 2024/09/12.
//

import UIKit
import WebKit

class CouponController: UIViewController {

    private var couponUrl: String?
    
    @IBOutlet weak var webView: WKWebView!
    
    func setup(couponUrl: String) {
        self.couponUrl = couponUrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 閉じるボタン
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(onTapCloseButton(_:)))
        self.navigationItem.rightBarButtonItem = closeButton
        
        self.navigationItem.hidesBackButton = true
        
        // WebViewのセットアップ
        webView.navigationDelegate = self
        
        guard let couponUrl, let url = URL(string: couponUrl) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc func onTapCloseButton (_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension CouponController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        guard navigationAction.navigationType != .linkActivated || (couponUrl ?? "") == url.absoluteString else {
            decisionHandler(.cancel)
            UIApplication.shared.open(url)
            return
        }
        
        decisionHandler(.allow)
    }
}
