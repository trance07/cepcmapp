//
//  BannerService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 11/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class BannerService {
    
    func obtenerImagenesFirebase(callback: @escaping (Bool, AnyObject) -> ()) -> Void {
        
        print("---> Obteniendo imagenes de banner desde firebase")
        
        let database = Database.database().reference().child(Constants.FIREBASE_CONFIGURACION.APP_ALUMNOS).child(Constants.FIREBASE_FIELD.CONFIGURACION)
        
        database.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            print("---> value de banner \(value)")
            let bannerTop = value?["bannerTop"] as? ConfiguracionBannerBean
            
            print("---> configuracion de banner \(bannerTop)")
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
