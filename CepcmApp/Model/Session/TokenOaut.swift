//
//  TokenOaut.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 15/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class TokenOaut: NSObject, NSCoding {
    
    var refresh_token: String? { didSet{valueChanged()} }
    var fecha_generacion: String? = nil { didSet{valueChanged()} }
    var access_token: String? = nil { didSet{valueChanged()} }
    var expires_in: UInt64? = nil { didSet{valueChanged()} }
    
    override init() {
        super.init()
    }
    
    func valueChanged() {
        let tokenOaut = Session.shared.tokenOaut!
        let data = NSKeyedArchiver.archivedData(withRootObject: tokenOaut)
        RUtil.persistValue(value: data as AnyObject, key: "TOKEN_OAUT_")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.refresh_token = aDecoder.decodeObject(forKey: "refresh_token") as? String
        self.fecha_generacion = aDecoder.decodeObject(forKey: "fecha_generacion") as? String
        self.access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        self.expires_in = aDecoder.decodeObject(forKey: "expires_in") as? UInt64
      
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(refresh_token, forKey: "refresh_token")
        aCoder.encode(fecha_generacion, forKey: "fecha_generacion")
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(expires_in, forKey: "expires_in")
    }
    
}
