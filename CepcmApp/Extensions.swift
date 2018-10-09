//
//  Extensions.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import Alamofire
import JavaScriptCore


class Extensions: NSObject {
    //CLASE PARA CREAR Y MANTENER ORDENADAS LAS EXTENSIONES
}

//extension UINavigationBar {
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.size.width, height: 70.0)
//    }
//
//}

struct Device {
    // iDevice detection code
    static let IS_IPAD             = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE           = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_RETINA           = UIScreen.main.scale >= 2.0
    
    static let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
    static let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
    static let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
    static let SCREEN_MIN_LENGTH   = Int( min(SCREEN_WIDTH, SCREEN_HEIGHT) )
    
    static let IS_IPHONE_4_OR_LESS = IS_IPHONE && SCREEN_MAX_LENGTH  < 568
    static let IS_IPHONE_5         = IS_IPHONE && SCREEN_MAX_LENGTH == 568
    static let IS_IPHONE_6         = IS_IPHONE && SCREEN_MAX_LENGTH == 667
    static let IS_IPHONE_6P        = IS_IPHONE && SCREEN_MAX_LENGTH == 736
    static let IS_IPHONE_X         = IS_IPHONE && SCREEN_MAX_LENGTH == 812
}


extension PushNotification {
    static func == (push1: PushNotification, push2: PushNotification) -> Bool {
        return push1.correlationId == push2.correlationId &&
            push1.title == push2.title &&
            push1.campaign == push2.campaign &&
            push1.content == push2.content &&
            push1.sentDate == push2.sentDate
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


extension UIColor {
    
    @nonobjc class var vcmBlack: UIColor {
        return UIColor(white: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var vcmPumpkinOrange: UIColor {
        return UIColor(red: 1.0, green: 111.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var vcmLightNavy: UIColor {
        return UIColor(red: 24.0 / 255.0, green: 61.0 / 255.0, blue: 123.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var vcmCloudyBlue: UIColor {
        return UIColor(red: 192.0 / 255.0, green: 201.0 / 255.0, blue: 217.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var vcmDark: UIColor {
        return UIColor(red: 23.0 / 255.0, green: 36.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var vcmBrownishGrey: UIColor {
        return UIColor(white: 102.0 / 255.0, alpha: 1.0)
    }
}

// Sample text styles

extension UIFont {
    class func vcmHeaderFont() -> UIFont {
        
        if #available(iOS 9,*) {
            return  UIFont.systemFont(ofSize:24.0, weight: .bold);
        } else {
            return  UIFont.systemFont(ofSize:24.0);
        }
        
    }
};


extension UIApplicationDelegate{
    
    /*func actualizacionForzada() {
        //print("ACTUALIZACION FORZADA")
        let message = "Existe una nueva versión, para seguir utilizando la aplicación es necesario actualizar."
        let alert = AlertCEPCMController(title: "CEPCM Móvil", message: message, preferredStyle: .alert)
        alert.addAction(title: "ACTUALIZAR AHORA", style: .default, handler: { action in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/idxxx"),
                UIApplication.shared.canOpenURL(url){
                UIApplication.shared.openURL(url)
            }
        })
        if !(UIApplication.topViewController() is AlertCEPCMController){
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    func actualizacionOpcional() {
        let message = "Hay una nueva versión disponible de la aplicación con la cual puedes disfrutar de más beneficios"
        let alert = AlertCEPCMController(title: "CEPCM Móvil", message: message, preferredStyle: .alert)
        alert.orientation = .vertical
        alert.addAction(title: "ACTUALIZAR AHORA", style: .cancel, handler: { action in
            if let url = URL(string: "itms-apps://itunes.apple.com/app/id54xxx"),
                UIApplication.shared.canOpenURL(url){
                UIApplication.shared.openURL(url)
            }
        })
        alert.addAction(title: "RECORDAR MÁS TARDE", style: .cancel, handler: nil)
        if !(UIApplication.topViewController() is AlertCEPCMController){
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }*/
    
    
    
   
    func postRequest(url:String, params:[String:AnyObject], headers: [String:String]? = nil, completion: @escaping (_ result: AnyObject?) -> Void ){
        //print("postRequest URL: \(url)")
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 3
        manager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            ////print("postRequest RESPONSE: \(response.result.value ?? "NO RESPONSE")")
            switch(response.result) {
            case .success(_):
                if (response.result.value) != nil {
                    let json = response.result.value as AnyObject
                    completion(json)
                }else{
                    completion(nil)
                }
                break
            case .failure(_):
                //print(response.result.error?.localizedDescription as Any)
                completion(nil)
                break
            }
        }
    }
    
    func postRequest(url:String, params:[String:AnyObject], completion: @escaping (_ result: AnyObject?) -> Void ){
        //print("postRequest URL: \(url)")
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 2
        manager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            ////print("postRequest RESPONSE: \(response.result.value ?? "NO RESPONSE")")
            switch(response.result) {
            case .success(_):
                if (response.result.value) != nil {
                    let json = response.result.value as AnyObject
                    completion(json)
                }else{
                    completion(nil)
                }
                break
            case .failure(_):
                //print(response.result.error?.localizedDescription as Any)
                completion(nil)
                break
            }
        }
    }
    
    
    func getRequest(url:String, completion: @escaping (_ result: AnyObject?) -> Void) {
        //print("getRequest URL: \(url)")
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 3
        manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {(response:DataResponse<Any>) in
            ////print("getRequest RESPONSE: \(response.result.value ?? "NO RESPONSE")")
            switch (response.result) {
            case .success(_):
                if (response.result.value) != nil {
                    let json = response.result.value as AnyObject
                    completion(json)
                }else{
                    completion(nil)
                }
                break
            case .failure(_):
                //print(response.result.error?.localizedDescription as Any)
                completion(nil)
                break
            }
        })
    }
    
}



extension UIViewController {
    
    func postRequest(url:String, params:[String:AnyObject], headers: [String:String]? = nil, completion: @escaping (_ result: AnyObject?) -> Void ){
        //print("postRequest URL: \(url)")
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 3
        manager.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            ////print("postRequest RESPONSE: \(response.result.value ?? "NO RESPONSE")")
            switch(response.result) {
            case .success(_):
                if (response.result.value) != nil {
                    let json = response.result.value as AnyObject
                    completion(json)
                }else{
                    completion(nil)
                }
                break
            case .failure(_):
                //print(response.result.error?.localizedDescription as Any)
                self.showAlert(title: "Error", message: Constants.ERROR.noServiceAvailable)
                completion(nil)
                break
            }
        }
    }
    
    
    func getRequest(url:String, completion: @escaping (_ result: AnyObject?) -> Void) {
        //print("getRequest URL: \(url)")
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 3
        manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {(response:DataResponse<Any>) in
            ////print("getRequest RESPONSE: \(response.result.value ?? "NO RESPONSE")")
            switch (response.result) {
            case .success(_):
                if (response.result.value) != nil {
                    let json = response.result.value as AnyObject
                    completion(json)
                }else{
                    completion(nil)
                }
                break
            case .failure(_):
                //print(response.result.error?.localizedDescription as Any)
                self.showAlert(title: "Error", message: Constants.ERROR.noServiceAvailable)
                completion(nil)
                break
            }
        })
    }
    
    
    func showAlert(title:String, message:String) {
        
        //        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        //        alert.addAction(UIAlertAction.init(title: "Aceptar", style: .default, handler: nil))
        //        self.present(alert, animated: true, completion: nil)
        let alert = AlertCEPCMController(title: title, message: message, preferredStyle: .alert)
        alert.modalTransitionStyle = .crossDissolve
        alert.addAction(title: "Aceptar", style: .default, handler: nil)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /*func requestnewToken(completion: @escaping (_ result: AnyObject?) -> Void) {
        let urlRefreshToken = URLHandler.getUrl(urlName: URLHandler.REFRESH_TOKEN)
        if Session.shared.user?.refreshToken != nil {
            let params = ["refreshtoken": Session.shared.user!.refreshToken!] as [String : AnyObject]
            loadURLToken(url: urlRefreshToken, params: params) { (response) in
                //print("Refresh Token \(response as? String ?? "")")
                if let responseDict = response as? NSDictionary{
                    if (responseDict["jwt"] != nil && responseDict["refreshtoken"] != nil){
                        Session.shared.user?.refreshToken =  responseDict["refreshtoken"] as? String
                        Session.shared.user?.jwtToken = responseDict["jwt"] as? String
                        completion(Session.shared.user?.jwtToken as AnyObject)
                    }else{completion(nil)}
                }else{completion(nil)}
            }
        }else{completion(nil)}
    }*/
    
    
    /*func loadURLToken(url:String, params:[String:AnyObject], completion: @escaping (_ result: AnyObject?) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            //            //print("---response: \(response.result.value)")
            switch(response.result) {
            case .success(_):
                if (response.result.value) != nil {
                    let json = response.result.value as AnyObject
                    completion(json)
                }else{
                    completion(nil)
                }
                break
            case .failure(_):
                //print("Error no hay internet o error en el servicio")
                completion(nil)
                break
            }
        }
        
    }*/
    
    
    
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
