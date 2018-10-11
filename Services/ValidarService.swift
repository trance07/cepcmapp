//
//  ValidarService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import Alamofire

class ValidarService {
    
    func validarDatos(request : RequestUsuario, callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        print("---> Validador Service")
        
        //Cargando la url de validacion de la cuenta del alumno
        let url = URLHandler.getUrl(urlName: URLHandler.VALIDA_CUENTA_ALUMNO)
        
          do {

            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(request)
            
            ServiciosUtil.postRequest(urlString: url, jsonData: jsonData, headers: nil) { (exito, response) in
                
                if exito {
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseValidaCuentaAlumnoBean.self, from: response as! Data)
                        if json.respuesta?.valido == true {
                            callback(true,json.respuesta as AnyObject)
                        } else {
                            //No en todos los servicios se debe de mostrar el error que regresa el back
                            //Para este servicio de validar datos del alumno si aplica pintar el msg
                            callback(false,json.respuesta?.mensaje as AnyObject)
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
