//
//  ValidarService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class ValidarService {
    
    let app_cepcm_host : String = "187.190.149.140:8083"
    
    let app_cepcm_domain_name : String = "cepcm.domain"
    
    let scheme : String = "http"
    
    let path : String = "accesoController/validarCuentaAlumno"
    
    func validarDatos(request : RequestUsuario) -> Bool {
        print("---> Validador Service")
        /*var urlComponents = URLComponents()
        urlComponents.scheme = self.scheme
        urlComponents.host = self.app_cepcm_host
        urlComponents.path = self.path
        
        guard let url = urlComponents.url else { fatalError("Error al crear url de validacion de usuario") }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        
        var headers = req.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        req.allHTTPHeaderFields = headers*/
        
        let encoder = JSONEncoder()
        do {
            
            let jsonData = try encoder.encode(request)
            //req.httpBody = jsonData
            print("jsonData: \(jsonData)")
            
        } catch {
            
        }
        
        return true
    }
    
}
