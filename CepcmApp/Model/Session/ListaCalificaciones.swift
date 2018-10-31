//
//  ListaCalificaciones.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 10/27/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class ListaCalificaciones: NSObject, NSCoding {
    
    var listaCalificaciones : [CalificacionesBean]? { didSet{valueChanged()} }
    
    override init() {
        super.init()
    }
    
    func valueChanged() {
        print("---> Valor ha cambiado")
        let lista = Session.shared.listaCalificaciones!
        let data = NSKeyedArchiver.archivedData(withRootObject: lista)
        print("---> tratando de persistir")
        RUtil.persistValue(value: data as AnyObject, key: "CALIFICACIONES")
    }
    
    func encode(with aCoder: NSCoder) {
        print("---> tratando de codificar")
        aCoder.encode(listaCalificaciones, forKey: "listaCalificaciones")
        print("---> terminando de codificar")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.listaCalificaciones = aDecoder.decodeObject(forKey: "listaCalificaciones") as? [CalificacionesBean]
    }
    
}
