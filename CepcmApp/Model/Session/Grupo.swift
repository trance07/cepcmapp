//
//  Grupo.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 18/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class Grupo: NSObject, NSCoding {
    
    var id: Int? { didSet{valueChanged()} }
    var descripcion: String? { didSet{valueChanged()} }
    
    override init() {
        super.init()
    }
    
    func valueChanged() {
        let grupo = Session.shared.grupo!
        let data = NSKeyedArchiver.archivedData(withRootObject: grupo)
        RUtil.persistValue(value: data as AnyObject, key: "GRUPO")
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.descripcion = aDecoder.decodeObject(forKey: "descripcion") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey: "id")
        aCoder.encode(descripcion, forKey: "descripcion")
        
    }
}
