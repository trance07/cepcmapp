//
//  User.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    var idUsuario: String? { didSet{valueChanged()} }
    var matricula: String? { didSet{valueChanged()} }
    var nombres: String? { didSet{valueChanged()} }
    var apaterno: String? { didSet{valueChanged()} }
    var amaterno: String? { didSet{valueChanged()} }
    var email: String? { didSet{valueChanged()} }
    
  
    var firstLoad: String? { didSet{valueChanged()} }
    var idAplicacion: String? { didSet{valueChanged()} }
   
   
 
    
    override init() {
        super.init()
    }
    
    func valueChanged() {
        let session = Session.shared.user!
        let data = NSKeyedArchiver.archivedData(withRootObject: session)
        RUtil.persistValue(value: data as AnyObject, key: "SESSION")
    }
    
    required init(coder aDecoder: NSCoder) {
        
        self.idUsuario = aDecoder.decodeObject(forKey: "idUsuario") as? String
        self.matricula = aDecoder.decodeObject(forKey: "matricula") as? String
        self.apaterno = aDecoder.decodeObject(forKey: "apaterno") as? String
        self.amaterno = aDecoder.decodeObject(forKey: "amaterno") as? String
        self.nombres = aDecoder.decodeObject(forKey: "nombres") as? String
        self.email = aDecoder.decodeObject(forKey: "email") as? String
      
//        self.firstLoad = aDecoder.decodeObject(forKey: "firstLoad") as? String
//        self.idAplicacion = aDecoder.decodeObject(forKey: "idAplicacion") as? String
//        self.idUsuario = aDecoder.decodeObject(forKey: "idUsuario") as? String
  
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(idUsuario, forKey: "idUsuario")
        aCoder.encode(matricula, forKey: "matricula")
        aCoder.encode(apaterno, forKey: "apaterno")
        aCoder.encode(amaterno, forKey: "matamaternoricula")
        aCoder.encode(nombres, forKey: "nombres")
        aCoder.encode(email, forKey: "email")
        //aCoder.encode(firstLoad, forKey: "firstLoad")
        //aCoder.encode(idAplicacion, forKey: "idAplicacion")
        
       
        
    }
}
