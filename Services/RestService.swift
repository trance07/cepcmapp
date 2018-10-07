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
    
    let app_cepcm_host_registrar : String = "http://187.190.149.140:8083/CEPCM_MOVIL/accesoController/persistirIdFirebasePorUsuario"
    
    func persistirIdFirebaseEnBackend(request : RequestPersistirIdFirebaseBean, resultado: @escaping (ResponsePersistirIdFirebaseBean) -> ()) -> Void {
        
        let encoder = JSONEncoder()
        do {
            
            let jsonData = try encoder.encode(request)
            let url = URL(string: app_cepcm_host_registrar)
            var req = URLRequest(url: url!)
            req.httpMethod = HTTPMethod.post.rawValue
            req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            req.httpBody = jsonData
            
            Alamofire.request(req).responseJSON { response in
                print("---> Registrando datos de usuario en backend")
                switch response.result {
                    
                    case .success(let data):
                        print("\n Success en backend: \(response)")
                    
                        do {
                            
                            let json = try JSONDecoder().decode(ResponsePersistirIdFirebaseBean.self, from: response.data!)
                            resultado(json)
                            
                        } catch let errorJson {
                        
                            print(errorJson)
                            
                        }
                    
                    case .failure(let error):
                        print("\n Failure: \(error.localizedDescription)")
                    
                        // Do your code here...
                    
                }
                
            }
            
            
        } catch let errorGeneral {
            print(errorGeneral)
        }
        
    }
    
}
