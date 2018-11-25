//
//  BannerService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 11/19/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class BannerService {
    
    func obtenerImagenesFirebase(callback: @escaping (Bool, AnyObject) -> ()) -> Void {
        
        print("---> Obteniendo imagenes de banner desde firebase")
        
        let database = Database.database().reference().child(Constants.FIREBASE_CONFIGURACION.APP_ALUMNOS).child(Constants.FIREBASE_FIELD.CONFIGURACION)
        
        database.observe(DataEventType.value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            print("---> value de banner \(value)")
            let bannerTop = value?["bannerTop"] as? NSDictionary
            
            print("---> configuracion de banner \(bannerTop)")
            let banners = bannerTop?["banners"] as? NSDictionary
            print("---> array de banner \(banners)")
            
            var imagenes = [ImagenBannerBean]()
            
            if banners != nil {
                
                let llaves = banners?.allKeys as? [String]
                llaves?.forEach {llave in
                    print("llave \(llave)")
                    let item = banners?[llave] as? NSDictionary
                    
                    var imagen = ImagenBannerBean()
                    imagen.name = item?["name"] as? String
                    imagen.redirect = item?["redirect"] as? String
                    imagen.url = item?["url"] as? String
                    
                    imagenes.append(imagen)
                    
                }
                
            }
            
            print("el tamanio de las imagenes es \(imagenes.count)")
            
            var lista = ListaImagenes()
            lista.listaImagenes = imagenes
            Session.shared.listaImagenes! = lista
            callback(true, imagenes as AnyObject)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
