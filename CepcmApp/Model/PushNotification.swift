//
//  PushNotification.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class PushNotification: NSObject, NSCoding {
    
    var correlationId: Int64?
    var title: String?
    var campaign: String?
    var sentDate: Int64?
    var readDate: String?
    var content: String?
    var isDeleteMode = false
    var isSelected = false
    var isRead = false
    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        self.correlationId = aDecoder.decodeObject(forKey: "correlationId") as? Int64 ?? 0
        self.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        self.campaign = aDecoder.decodeObject(forKey: "campaign") as? String ?? ""
        self.sentDate = aDecoder.decodeObject(forKey: "sentDate") as? Int64
        self.readDate = aDecoder.decodeObject(forKey: "readDate") as? String ?? ""
        self.content = aDecoder.decodeObject(forKey: "content") as? String ?? ""
        self.isDeleteMode = aDecoder.decodeBool(forKey: "isDeleteMode")
        self.isSelected = aDecoder.decodeBool(forKey: "isSelected")
        self.isRead = aDecoder.decodeBool(forKey: "isRead")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(correlationId, forKey: "correlationId")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(campaign, forKey: "campaign")
        aCoder.encode(sentDate, forKey: "sentDate")
        aCoder.encode(readDate, forKey: "readDate")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(isDeleteMode, forKey: "isDeleteMode")
        aCoder.encode(isSelected, forKey: "isSelected")
        aCoder.encode(isRead, forKey: "isRead")
    }
    
    
}
