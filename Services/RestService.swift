//
//  RestService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/18/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import Alamofire

class RestService {
    
    
    func persistirIdFirebaseEnBackend(request : RequestPersistirIdFirebaseBean, callback: @escaping (Bool,AnyObject?) -> ()) -> Void {
        print("---> Validador Service")
       
        let url = URLHandler.getUrl(urlName: URLHandler.PERSISTIR_ID_FIREBASE_POR_USUARIO)
        
        do {
            
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(request)
            
            ServiciosUtil.postRequest(urlString: url, jsonData: jsonData, headers: nil) { (exito, response) in
                
                if exito {
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponsePersistirIdFirebaseBean.self, from: response as! Data)
                        if json.respuesta?.codigo == 0 {
                            callback(true, nil)
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
