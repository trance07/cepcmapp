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
    
    func validarDatos(request : RequestUsuario, resultado: @escaping (Bool) -> ()) -> Void {
        print("---> Validador Service")
        
        //Cargando la url de validacion de la cuenta del alumno
        let url = URLHandler.getUrl(urlName: URLHandler.VALIDA_CUENTA_ALUMNO)
        
          do {

            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(request)
            
            URLHandler.postRequest(urlString: url, jsonData: jsonData, headers: nil) { (response) in
                
                if response != nil{
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseValidaCuentaAlumnoBean.self, from: response as! Data)
                        if json.respuesta?.valido == true {
                            resultado(true)
                        } else {
                            resultado(false)
                        }
                        
                    } catch let errorJson {
                        print(errorJson)
                        resultado(false)
                    }
                    
                }else{
                    resultado(true)
                    
                }
                
            }// fin postRequest
            
          } catch {
            
            resultado(false)
            
        }
        
    }
    
}
