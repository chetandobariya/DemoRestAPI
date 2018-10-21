//
//  WebViewController.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private (set) lazy var webView: WKWebView = {
       
        let webViewConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: self.view.frame, configuration: webViewConfiguration)
        
        webView.autoresizesSubviews = true
        webView.scrollView.bounces = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.decelerationRate = UIScrollView.DecelerationRate.normal
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.contentMode = .scaleToFill
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        return webView
        
    }()
    
    var progressView: UIProgressView {
        
        return (self.navigationController?.navigationBar.subviews.findFirst(ofType: UIProgressView.self) ?? self.createAndAddProgressView())
    }
    
    var repositoryItems: Repositories?
   
    override func viewDidLoad() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.title = self.repositoryItems?.name
        self.webView.frame = self.view.frame
        self.view.addSubview(self.webView)
        self.startLoading()
        
        super.viewDidLoad()
        
    }
    
    @objc func closeWebScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func startLoading() {
        
        guard let url = self.repositoryItems?.owner?.htmlUrl else {
            return
        }
        
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    private func createAndAddProgressView() -> UIProgressView {
        
        let progressBar: UIProgressView = {
            
            let progressBar = UIProgressView(progressViewStyle: .default)
            progressBar.alpha = 0.0
            progressBar.tintColor = UIColor(named: .loadingBarColor)
            //progressBar.tintColor = UIColor.blue
            progressBar.trackTintColor = UIColor.clear
            progressBar.progress = 0.0
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            
            return progressBar
        }()
        
        if let navigationBar = self.navigationController?.navigationBar {
            
            navigationBar.addSubview(progressBar)
            progressBar.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor).isActive = true
            progressBar.topAnchor.constraint(equalTo: navigationBar.topAnchor).isActive = true
            navigationBar.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor).isActive = true
        }
        
        return progressBar
    }
    
    fileprivate func updateProgressBar(usingProgress progress: Float) {
        
        DispatchQueue.main.async {
            
            self.progressView.alpha = 1.0
            self.progressView.setProgress(progress, animated: true)
            
            if progress >= 1.0 {
                
                delay(0.5, completion: {
                    
                    UIView.animate(withDuration: Constants.defaultAnimationDuration, animations: {
                        
                        self.progressView.alpha = 0.0
                        
                    }, completion: { (finished) in
                        
                        self.progressView.setProgress(0.0, animated: false)
                        
                    })
                })
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let observedWebview = (object as? WKWebView), observedWebview == self.webView, keyPath == #keyPath(WKWebView.estimatedProgress),
            self.navigationController?.topViewController == self {
            
            self.updateProgressBar(usingProgress: Float(observedWebview.estimatedProgress))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(#function) \(error.localizedDescription)")
        
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("\(#function) \(error.localizedDescription)")
    }
}
