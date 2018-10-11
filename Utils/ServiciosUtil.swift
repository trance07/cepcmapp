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
import FirebaseAuth

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
    
    class func validaResponseErrorFirebase(error: Int, callback: @escaping ( _ result: AnyObject?) -> Void ){
        
         var errorBean = ErrorBean()
        
        if let errorCode = AuthErrorCode(rawValue: error) {
            
            switch errorCode {
            case .emailAlreadyInUse:
                errorBean.codigo = Constants.ERRORCODE.emailAlreadyInUse
                errorBean.mensaje = Constants.ERROR.emailAlreadyInUse
                print( "The email is already in use with another account")
            case .userNotFound:
                errorBean.codigo = Constants.ERRORCODE.userNotFound
                errorBean.mensaje = Constants.ERROR.userNotFound
                print(  "Account not found for the specified user. Please check and try again")
            case .userDisabled:
                errorBean.codigo = Constants.ERRORCODE.userDisabled
                errorBean.mensaje = Constants.ERROR.userDisabled
                print(  "Your account has been disabled. Please contact support.")
            case .invalidEmail, .invalidSender, .invalidRecipientEmail:
                errorBean.codigo = Constants.ERRORCODE.invalidEmail
                errorBean.mensaje = Constants.ERROR.invalidEmail
                print(  "Please enter a valid email")
            case .networkError:
                errorBean.codigo = Constants.ERRORCODE.networkError
                errorBean.mensaje = Constants.ERROR.noInternetAvailable
                print(  "Network error. Please try again.")
            case .weakPassword:
                errorBean.codigo = Constants.ERRORCODE.weakPassword
                errorBean.mensaje = Constants.ERROR.weakPassword
                print(  "Your password is too weak. The password must be 6 characters long or more.")
            case .wrongPassword:
                errorBean.codigo = Constants.ERRORCODE.wrongPassword
                errorBean.mensaje = Constants.ERROR.wrongPassword
                print(  "Your password is incorrect. Please try again or use 'Forgot password' to reset your password")
            default:
                errorBean.codigo = Constants.ERRORCODE.errorDesconocido
                errorBean.mensaje = Constants.ERROR.noServiceAvailable
                print(  "Unknown error occurred")
            }
        
        
       
        }else{
            errorBean.codigo = Constants.ERRORCODE.errorDesconocido
            errorBean.mensaje = Constants.ERROR.noServiceAvailable
        }
        
        callback(errorBean as AnyObject)
        
    }
  
    
}
