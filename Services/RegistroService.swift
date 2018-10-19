//
//  ValidarService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import Alamofire

class RegistroService {
    
    let userDefaults = UserDefaults.standard
    
    func registrarDispositivo(request : RequestRegistroDispositivoBean, callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        print("---> Registra Dispositivo")
        
        let url = URLHandler.getUrl(urlName: URLHandler.PERSISTIR_DISPOSITIVO)
        
        do {
            
            let parameters = [
            "id_dispositivo": request.id_dispositivo]
            
            ServiciosUtil.getRequestWhitToken(urlString: url, parameters: parameters as! [String : String], headers: nil) { (exito, response) in
                
                if exito {
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseRegistroDispositivoBean.self, from: response as! Data)
                        
                        if (json.respuesta?.valido)! {// solo para este servicio se valida la variable valido
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
