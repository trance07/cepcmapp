//
//  URLHandler.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class URLHandler: NSObject {
    
    
    
    static let APIKEY_OTHER = "APIKEY_OTHER"
    static let APIKEY_NOTIFICADOR = "APIKEY_NOTIFICADOR"
    static let PROJECT_ID = "PROJECT_ID"
    
    static let FIREBASE_CONTRATO_MEDIOS = "FIREBASE_CONTRATO_MEDIOS"
    static let FIREBASE = "FIREBASE"
    static let REFRESH_TOKEN = "REFRESH_TOKEN"
    static let APP_VERSION = "APP_VERSION"
    static let CONSULTA_LOGIN = "CONSULTA_LOGIN"
    static let LOGIN = "LOGIN"
    static let ID_USUARIO = "ID_USUARIO"
    static let PUSH = "PUSH"
    
    static let FUNCTION_SESSION = "FUNCTION_SESSION"
    static let UPDATE_DEVICETOKEN = "UPDATE_DEVICETOKEN"
    
    
    class func getUrl(urlName:String) -> String {
        let filePath = Bundle.main.path(forResource: "Config", ofType: "plist")
        let configPlist = NSDictionary(contentsOfFile: filePath!)
        let ambiente = configPlist?["Ambiente"] as! String
        
        let requests = configPlist?["Requests"] as! NSDictionary
        let allURLS = requests[ambiente] as! NSDictionary
        if let url = allURLS[urlName] as? String{
            return url
        }else{
            return ""
        }
    }
    
    
    class func googleKey(name:String) -> String {
        let filePath = Bundle.main.path(forResource: "Config", ofType: "plist")
        let configPlist = NSDictionary(contentsOfFile: filePath!)
        let google = configPlist?["Google"] as! NSDictionary
        let ambiente = configPlist?["Ambiente"] as! String
        let maps = google["Maps"] as! NSDictionary
        if let keysDict = maps[ambiente] as? NSDictionary{
            return keysDict[name] as! String
        }else{
            return ""
        }
    }
    
    class func getKey(base: String, name: String) -> String {
        let filePath = Bundle.main.path(forResource: "Config", ofType: "plist")
        let configPlist = NSDictionary(contentsOfFile: filePath!)
        let requests = configPlist?["Requests"] as! NSDictionary
        let ambiente = configPlist?["Ambiente"] as! String
        let keysDict = requests[ambiente] as! NSDictionary
        let allURLS = requests["URLS"] as! NSDictionary
        
        let baseURL = keysDict[base] as! String
        let url = allURLS[name] as! String
        
        let fullURL = String(format: "%@%@", baseURL, url)
        return fullURL
    }
    
    
    
    class func forKey(name: String) -> String {
        let configFile = RUtil.valueForKey_(key: "config") as! NSDictionary
        let wsDic = configFile["WS"] as! NSDictionary
        
        let env = wsDic["Ambiente"] as! String
        let urlsDic = (wsDic["URLS"] as! NSDictionary)[env] as! NSDictionary
        
        let baseUrl = urlsDic["URL_BASE"] as! String
        let url = (wsDic["URLS"] as! NSDictionary)[name] as! String
        
        var fullURL = String(format: "%@%@", baseUrl, url)
        fullURL = fullURL.replacingOccurrences(of: "GNPAlertasWS", with: "GNPAlertasWSCM")
        
        return fullURL
    }
    
    class func forKeyPruebas(name: String) -> String {
        let configFile = RUtil.valueForKey_(key: "config") as! NSDictionary
        let wsDic = configFile["WS"] as! NSDictionary
        
        let env = wsDic["Pruebas"] as! String
        let urlsDic = (wsDic["URLS"] as! NSDictionary)[env] as! NSDictionary
        
        let baseUrl = urlsDic["URL_BASE"] as! String
        let url = (wsDic["URLS"] as! NSDictionary)[name] as! String
        
        var fullURL = String(format: "%@%@", baseUrl, url)
        fullURL = fullURL.replacingOccurrences(of: "GNPAlertasWS", with: "GNPAlertasWSCM")
        
        return fullURL
    }
}
