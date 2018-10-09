//
//  LoadingController.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import WebKit

class LoadingController: UIViewController {
    
    var bgView: UIImageView?
    var spinner: UIActivityIndicatorView?
    var circleView: UIImageView?
    
    static var lblText: UILabel? = UILabel()
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        self.view.frame = CGRect(x: 0, y: 0, width: RUtil.screenBoundsInOrientation().width, height: RUtil.screenBoundsInOrientation().height)
        self.view.alpha = 0
        
        
        
        bgView = UIImageView.init(frame: self.view.bounds)
        bgView?.image = UIImage(named: "image.load.bg")
        bgView?.alpha = 0.7
        self.view.addSubview(bgView!)
        
        LoadingController.lblText = UILabel.init(frame: CGRect(x: 10, y: ((RUtil.screenBoundsInOrientation().height) / 2) + 80, width: (RUtil.screenBoundsInOrientation().width - 20), height: 70))
        LoadingController.lblText?.font = UIFont.boldSystemFont(ofSize: 14)
        LoadingController.lblText?.textAlignment = .center
        LoadingController.lblText?.numberOfLines = 3
        LoadingController.lblText?.textColor = UIColor.white
        self.view.addSubview(LoadingController.lblText!)
        
        
        let webView = WKWebView()
        webView.backgroundColor = UIColor.clear
        webView.frame = self.view.bounds
        webView.isOpaque = false
        webView.backgroundColor = UIColor.clear
        webView.scrollView.backgroundColor = UIColor.clear
        webView.scrollView.isScrollEnabled = false
        self.view.addSubview(webView)
        
        var request:URLRequest
        let path = Bundle.main.path(forResource:"loader",ofType:"html",inDirectory:"loader")
        request = URLRequest(url: URL(fileURLWithPath:path!))
        request.cachePolicy = .returnCacheDataElseLoad
        webView.load(request)
     
        
    }
    
    func showWithText(text: String) {
        self.view.tag = 1111
        
        RUtil.addViewToWindow(view: self.view)
        LoadingController.lblText?.text = "Validando información"
        
        UIView.animate(withDuration: 0.2) {
            self.view.alpha = 1
        }
    }
    
    class func updateText(text: String) {
        LoadingController.lblText?.text = text
    }
    
    class func stop() {
        let window = UIApplication.shared.delegate?.window
        var view = window!!.viewWithTag(1111)
        
        UIView.animate(withDuration: 0.2, animations: {
            view?.alpha = 0
        }) { (bool) in
            view?.removeFromSuperview()
            view = nil
        }
    }
}
