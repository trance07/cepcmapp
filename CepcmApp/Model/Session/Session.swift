//
//  Session.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

class Session: NSObject {
    
    static let shared = Session()
    private override init() {}
    
    var user: User?
    var grupo: Grupo?
    var token: DeviceToken?
    var tokenOaut: TokenOaut?
    
    class func clean() {
        shared.user = nil
        //shared.grupo = nil
    }
    
    class func add(token: DeviceToken){
        Session.shared.token = token
        
        if RUtil.valueForKey_(key: "TOKEN_") != nil {
            let reportData = RUtil.valueForKey_(key: "TOKEN_") as! Data
            if let token = NSKeyedUnarchiver.unarchiveObject(with: reportData) as? DeviceToken{
                Session.shared.token = token
            }
        }
    }
    
    class func add(session: User) {
        Session.shared.user = session
        
        if RUtil.valueForKey_(key: "SESSION") != nil {
            let sessionData = RUtil.valueForKey_(key: "SESSION") as! Data
            if let session = NSKeyedUnarchiver.unarchiveObject(with: sessionData) as? User{
                Session.shared.user = session
            }
        }
        
    }
    
    class func add(grupo: Grupo) {
        Session.shared.grupo = grupo
        
        if RUtil.valueForKey_(key: "GRUPO") != nil {
            let grupoData = RUtil.valueForKey_(key: "GRUPO") as! Data
            if let grupo = NSKeyedUnarchiver.unarchiveObject(with: grupoData) as? Grupo{
                Session.shared.grupo = grupo
            }
        }
        
    }
    
    class func add(tokenOaut: TokenOaut){
        Session.shared.tokenOaut = tokenOaut
        
        if RUtil.valueForKey_(key: "TOKEN_OAUT_") != nil {
            let reportData = RUtil.valueForKey_(key: "TOKEN_OAUT_") as! Data
            if let tokenOaut = NSKeyedUnarchiver.unarchiveObject(with: reportData) as? TokenOaut{
                Session.shared.tokenOaut = tokenOaut
            }
        }
    }
    
    
}

