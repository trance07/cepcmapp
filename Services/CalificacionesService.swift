//
//  CalificacionesService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 10/20/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Alamofire
import Foundation
import FirebaseAuth
import FirebaseDatabase

class CalificacionesService {
    
    func obtenerCalificacionesFirebase() -> Void {
        
        print("---> Obteniendo Calificaciones desde firebase")
        
        let userUid = Auth.auth().currentUser?.uid
        let database = Database.database().reference().child(Constants.FIREBASE_FIELD.ALUMNOS).child(userUid!).child(Constants.FIREBASE_CONFIGURACION.MODULOS + Constants.FIREBASE_CONFIGURACION.CALIFICACIONES)
        
        database.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let bandera_actualizar = value?["bandera_actualizar"] as? Bool
            let bloquear_acceso = value?["bloquear_acceso"] as? Bool
            let mensaje = value?["mensaje"] as? String
            
            if bandera_actualizar == true && bloquear_acceso == false {
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func obtenerCalificacionesBackend(callback: @escaping (Bool, AnyObject) -> ()) -> Void {
        
        print("---> Obteniendo Calificaciones")
        
        let url = URLHandler.getUrl(urlName: URLHandler.CALIFICACIONES_POR_ALUMNO)
        
        do {
            
            ServiciosUtil.getRequestWhitToken(urlString: url, parameters: nil, headers: nil) { (exito, response) in
                
                if exito == true {
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseCalificacionesPorAlumnoGrupoBean.self, from: response as! Data)
                        
                        if json.codigo == 0 {
                            callback(true, json.respuesta as AnyObject)
                        } else {
                            callback(false, json.mensaje as AnyObject)
                        }
                        
                        
                    } catch let errorJson {
                        
                        print("=====> JSON ERROR CALIFICACIONES: \(errorJson)")
                        callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
                        
                    }
                    
                } else {
                    
                }
                
            }
            
        } catch {
            
            callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
            
        }
        
    }
    
}
