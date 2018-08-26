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
    
    let app_cepcm_host : String = "http://187.190.149.140:8083/accesoController/validarCuentaAlumno"
    
    let app_cepcm_domain_name : String = "cepcm.domain"
    
    
    func validarDatos(request : RequestUsuario) -> Bool {
        print("---> Validador Service")
        
        
        let encoder = JSONEncoder()
        do {
            
            let jsonData = try encoder.encode(request)
            
            print("jsonData: \(jsonData)")
            let url = URL(string: app_cepcm_host)
            var req = URLRequest(url: url!)
            req.httpMethod = HTTPMethod.post.rawValue
            req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            req.httpBody = jsonData
            
            Alamofire.request(req).responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("\n Success: \(response)")
                    
                    // Do your code here...
                    
                case .failure(let error):
                    print("\n Failure: \(error.localizedDescription)")
                    
                    // Do your code here...
                    
                }
            
            }
            
        } catch {
            
        }
        
        return true
    }
    
}
