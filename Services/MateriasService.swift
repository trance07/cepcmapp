//
//  ValidarService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import Alamofire

class MateriasService {
    
    let userDefaults = UserDefaults.standard
    
    func obtenerMaterias(callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        print("---> Obteniendo Materias")
        
        let url = URLHandler.getUrl(urlName: URLHandler.MATERIAS_POR_ALUMNO)
        
        do {
            
            ServiciosUtil.getRequestWhitToken(urlString: url, parameters: nil, headers: nil) { (exito, response) in
                
                if exito {
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseMateriasPorCarreraBean.self, from: response as! Data)
                        
                        if json.codigo == 0 {
                            callback(true, json.respuesta as AnyObject)
                        } else {
                            //No en todos los servicios se debe de mostrar el error que regresa el back
                            //Para este servicio de validar datos del alumno si aplica pintar el msg
                            callback(false,json.mensaje as AnyObject)
                        }
                        
                    } catch let errorJson {
                        print(errorJson)
                        callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
                    }
                    
                }else{ //error al realizar la peticion
                    
                    let errorBean = response as! ErrorBean
                    callback(false,errorBean.mensaje! as AnyObject)
                    
                }
                
            }// fin postRequest
            
        } catch {
            
            callback(false,Constants.ERROR.noServiceAvailable as AnyObject)
            
        }
        
    }
    
}
