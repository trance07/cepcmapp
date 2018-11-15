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
    
    func procesarCalificacionesEnSesion(callback: @escaping (Bool, AnyObject) -> ()) -> Void {
        
        print("---> Procesando lista de calificaciones en sesion")
        
        let userUid = Auth.auth().currentUser?.uid
        
        let database = Database.database().reference().child(Constants.FIREBASE_FIELD.ALUMNOS).child(userUid!).child(Constants.FIREBASE_CONFIGURACION.MODULOS + Constants.FIREBASE_CONFIGURACION.CALIFICACIONES)
        
        self.obtenerCalificacionesBackend() { (bandera, respuesta) in
            
            if bandera == false {
                
                print("---> Solicitud erronea")
                callback(false, respuesta as AnyObject)
                
            } else {
                
                let promedioBean = respuesta as! PromedioBean
                
                let lista = ListaCalificaciones()
                lista.listaCalificaciones = promedioBean.calificaciones
                Session.shared.listaCalificaciones! = lista
                
                callback(true, promedioBean.calificaciones as AnyObject)
                database.child("bandera_actualizar").setValue(false)
                
            }
            
        }
        
    }
    
    func obtenerCalificacionesFirebase(callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        
        print("---> Obteniendo Calificaciones")
        
        let userUid = Auth.auth().currentUser?.uid
        
        print("---> Id usuario: \(userUid)")
        let database = Database.database().reference().child(Constants.FIREBASE_FIELD.ALUMNOS).child(userUid!).child(Constants.FIREBASE_CONFIGURACION.MODULOS + Constants.FIREBASE_CONFIGURACION.CALIFICACIONES)
        
        database.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let bandera_actualizar = value?["bandera_actualizar"] as? Bool
            let bloquear_acceso = value?["bloquear_acceso"] as? Bool
            let mensaje = value?["mensaje"] as? String
            
            print("---> bandera_actualizar \(bandera_actualizar) bloquear acceso \(bloquear_acceso) mensaje \(mensaje)")
            
            if bloquear_acceso == false {

                if bandera_actualizar == true {
                    
                    if Session.shared.listaCalificaciones == nil {
                        
                        self.procesarCalificacionesEnSesion() { (bandera, respuesta) in
                            
                            callback(bandera, respuesta as AnyObject)
                            
                        }
                        
                        
                    } else {/// fin lista calificaciones
                    
                        if Session.shared.listaCalificaciones!.listaCalificaciones?.count == 0 || Session.shared.listaCalificaciones!.listaCalificaciones == nil {
                            
                            self.procesarCalificacionesEnSesion() { (bandera, respuesta) in
                                
                                callback(bandera, respuesta as AnyObject)
                                
                            }
                            
                        } else {
                            
                            callback(true, Session.shared.listaCalificaciones! as AnyObject)
                        }
                        
                    }
                    
                } else {/// fin lista calificaciones
                    
                    if  (Session.shared.listaCalificaciones!.listaCalificaciones == nil ||    Session.shared.listaCalificaciones!.listaCalificaciones?.count == 0) {
                        self.procesarCalificacionesEnSesion() { (bandera, respuesta) in
                            
                            callback(bandera, respuesta as AnyObject)
                            
                        }
                        
                    } else {
                        callback(true, Session.shared.listaCalificaciones!.listaCalificaciones as AnyObject)
                    }
                    
                }
                
            } else {
                
                print("---> NO puede actualizar calificaciones")
                callback(false, mensaje as AnyObject)
                
                
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
