//
//  ListaImagenes.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 11/19/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class ListaImagenes: NSObject, NSCoding {
    
    var fechaActualizacion: Int16? { didSet{valueChanged()} }
    var listaImagenes : [ImagenBannerBean]? { didSet{valueChanged()} }
    
    override init() {
        super.init()
    }
    
    func valueChanged() {
        let lista = Session.shared.listaImagenes!
        let data = NSKeyedArchiver.archivedData(withRootObject: lista)
        print("---> tratando de persistir")
        RUtil.persistValue(value: data as AnyObject, key: "IMAGENES")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(listaImagenes, forKey : "listaImagenes")
    }
    
    required init(coder aDecoder: NSCoder) {
        self.listaImagenes = aDecoder.decodeObject(forKey: "listaImagenes") as? [ImagenBannerBean]
    }
    
}
