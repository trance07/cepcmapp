//
//  DeviceToken.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class DeviceToken: NSObject, NSCoding {
    
    var deviceToken: String? { didSet{valueChanged()} } // Rutil persist
    
    override init() {
        super.init()
    }
    
    func valueChanged() {
        let token = Session.shared.token!
        let data = NSKeyedArchiver.archivedData(withRootObject: token)
        RUtil.persistValue(value: data as AnyObject, key: "TOKEN_")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.deviceToken = aDecoder.decodeObject(forKey: "deviceToken") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(deviceToken, forKey: "deviceToken")
    }
    
}
