//
//  URLHandler.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import Alamofire
import JavaScriptCore

class URLHandler: NSObject {
    
    
    //
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
    
    static let VALIDA_CUENTA_ALUMNO = "VALIDA_CUENTA_ALUMNO"
    static let PERSISTIR_ID_FIREBASE_POR_USUARIO = "PERSISTIR_ID_FIREBASE_POR_USUARIO"

    
    
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
    
    
}
