//
//  ServiciosUtil.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 10/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

//
//  URLHandler.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit
import Alamofire
import JavaScriptCore

class ServiciosUtil: NSObject {
    
    
   
  
    class func postRequest(urlString:String, jsonData:Data?, headers: [String:String]? = nil, callback: @escaping (_ exito:Bool,  _ result: AnyObject?) -> Void ){
        //print("postRequest URL: \(url)")
        
        
         if ConnectionService.isConnectedToNetwork() {
        
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 3
       
            
            let url = URL(string: urlString)
            var req = URLRequest(url: url!)
            req.httpMethod = HTTPMethod.post.rawValue
            req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            req.httpBody = jsonData
            
            Alamofire.request(req).responseJSON { response in
              
                
                switch response.result {
                case .success( _):
                 
                 let json = response.data! as AnyObject
                 callback(true, json)
                 
                case .failure(let error):
                var errorBean = ErrorBean()
                    
                if let error = error as? AFError {
                    switch error {
                    case .invalidURL(let url):
                        errorBean.codigo = Constants.ERRORCODE.invalidURL
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        print("Invalid URL: \(url) - \(error.localizedDescription)")
                    case .parameterEncodingFailed(let reason):
                        errorBean.codigo = Constants.ERRORCODE.parameterEncodingFailed
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        print("Parameter encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .multipartEncodingFailed(let reason):
                        errorBean.codigo = Constants.ERRORCODE.parameterEncodingFailed
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        print("Multipart encoding failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    case .responseValidationFailed(let reason):
                        errorBean.codigo = Constants.ERRORCODE.responseValidationFailed
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        print("Response validation failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                        
                        switch reason {
                        case .dataFileNil, .dataFileReadFailed:
                            print("Downloaded file could not be read")
                        case .missingContentType(let acceptableContentTypes):
                            print("Content Type Missing: \(acceptableContentTypes)")
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                        }
                    case .responseSerializationFailed(let reason):
                        errorBean.codigo = Constants.ERRORCODE.localizedDescription
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    }
                    
                    print("Underlying error: \(String(describing: error.underlyingError))")
                    
                } else if let error = error as? URLError {
                    
                        if error._code == NSURLErrorTimedOut {
                            print("URLError occurred: \(error)")
                            errorBean.codigo = Constants.ERRORCODE.timeOut
                            errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        }else{
                            switch error {
                            case URLError.notConnectedToInternet:
                                print("Sin conexion a internet")
                                errorBean.codigo = Constants.ERRORCODE.noInternetAvailable
                                errorBean.mensaje = Constants.ERROR.noInternetAvailable
                               
                            default:
                                print("Error desconocido")
                                print(error)
                                errorBean.codigo = Constants.ERRORCODE.errorDesconocido
                                errorBean.mensaje = Constants.ERROR.noServiceAvailable
                               
                            }
                        }
                    }// else URLError
                
                     callback(false, errorBean as AnyObject)
                   
                }// fin switch
                
            }// fin request
                
         }else{
            //Sin conexion a internet
            print("Sin conexion a internet")
            var errorBean = ErrorBean()
            errorBean.codigo = Constants.ERRORCODE.noInternetAvailable
            errorBean.mensaje = Constants.ERROR.noInternetAvailable
            callback(false, errorBean as AnyObject)
        }
        
        
    }
  
    
}
