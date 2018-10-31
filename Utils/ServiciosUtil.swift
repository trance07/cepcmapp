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
            if(headers != nil){
                headers?.forEach({ (key, value) in
                      req.setValue(value, forHTTPHeaderField: key)
                })
              
            }
            
            Alamofire.request(req).responseJSON { response in
                
                 print(response)
                
                switch response.result {
                case .success( _):
                    
                    ///Se valida si no trono la peticion
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseBase.self, from: response.data! )
                        if json.codigo == 0 {
                            
                            let json = response.data! as AnyObject
                            callback(true, json)
                         
                        } else {
                            //Error 500
                            var errorBean = ErrorBean()
                            errorBean.codigo = Constants.ERRORCODE.internalError
                            errorBean.mensaje = Constants.ERROR.noServiceAvailable
                            callback(false, errorBean as AnyObject)
                        }
                        
                    } catch let errorJson {
                        print(errorJson)
                       
                        //Verificando si es un error de OATU
                        do {
                            
                            let json = try JSONDecoder().decode(ResponseErrorOauthBean.self, from: response.data! )
                            
                            var errorBean = ErrorBean()
                            
                            switch json.error {
                            case "unauthorized":
                                
                                errorBean.codigo = Constants.ERRORCODE.unauthorized
                                errorBean.mensaje = Constants.ERROR.unauthorized
                                
                            default:
                                
                                errorBean.codigo = Constants.ERRORCODE.errorDesconocido
                                errorBean.mensaje = Constants.ERROR.noServiceAvailable
                                
                            }//fin switch
                            
                              callback(false, errorBean as AnyObject)
                                
                        } catch let errorJsonOAut {
                             print(errorJsonOAut)
                        }
                    
                        var errorBean = ErrorBean()
                        errorBean.codigo = Constants.ERRORCODE.parserError
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        callback(false, errorBean as AnyObject)
                    
                      
                    }
                    ///
                    
                  
                    
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
    
    class func getRequest(urlString:String, parameters:[String:String]? = nil, headers: [String:String]? = nil, callback: @escaping (_ exito:Bool,  _ result: AnyObject?) -> Void ){
        //print("postRequest URL: \(url)")
        
        
        if ConnectionService.isConnectedToNetwork() {
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 3
            
            
            let url = URL(string: urlString)
            var req = URLRequest(url: url!)
            
           // req.httpMethod = HTTPMethod.get.rawValue
            //req.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
         
            if(headers != nil){
                headers?.forEach({ (key, value) in
                    req.setValue(value, forHTTPHeaderField: key)
                })
                
            }
            
            Alamofire.request(urlString,  method: .get, parameters: parameters, headers: headers).responseJSON { response in
                
                print(response)
                
                switch response.result {
                case .success( _):
                    
                    ///Se valida si no trono la peticion
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseBase.self, from: response.data! )
                        if json.codigo == 0 {
                            
                            let json = response.data! as AnyObject
                            callback(true, json)
                            
                        } else {
                            //Error 500
                            var errorBean = ErrorBean()
                            errorBean.codigo = Constants.ERRORCODE.internalError
                            errorBean.mensaje = Constants.ERROR.noServiceAvailable
                            callback(false, errorBean as AnyObject)
                        }
                        
                    } catch let errorJson {
                        print(errorJson)
                        
                        //Verificando si es un error de OATU
                        do {
                            
                            let json = try JSONDecoder().decode(ResponseErrorOauthBean.self, from: response.data! )
                            
                            var errorBean = ErrorBean()
                            
                            switch json.error {
                            case "unauthorized":
                                
                                errorBean.codigo = Constants.ERRORCODE.unauthorized
                                errorBean.mensaje = Constants.ERROR.unauthorized
                                
                            default:
                                
                                errorBean.codigo = Constants.ERRORCODE.errorDesconocido
                                errorBean.mensaje = Constants.ERROR.noServiceAvailable
                                
                            }//fin switch
                            
                            callback(false, errorBean as AnyObject)
                            
                        } catch let errorJsonOAut {
                            print(errorJsonOAut)
                        }
                        
                        var errorBean = ErrorBean()
                        errorBean.codigo = Constants.ERRORCODE.parserError
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        callback(false, errorBean as AnyObject)
                        
                        
                    }
                    ///
                    
                    
                    
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
    
    class func postRequestWhitToken(urlString:String, jsonData:Data?, headers: [String:String]? = nil, callback: @escaping (_ exito:Bool,  _ result: AnyObject?) -> Void ){
       
        self.obtenerToken { (token) in
            
            let headers = [
                "Authorization": "Bearer "+token
            ]
            
            self.postRequest(urlString: urlString, jsonData: jsonData,headers: headers, callback: { (exito, response) in
                
                callback(exito,response)
                
            })
            
        }
        
    }
    
    class func getRequestWhitToken(urlString:String, parameters: [String : String]? = nil, headers: [String:String]? = nil, callback: @escaping (_ exito:Bool,  _ result: AnyObject?) -> Void ){
        
        self.obtenerToken { (token) in
            
            let headers = [
                "Authorization": "Bearer "+token
            ]
            
           
            
            self.getRequest(urlString: urlString, parameters: parameters ,headers: headers, callback: { (exito, response) in
                
                callback(exito,response)
                
            })
            
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
    
    class func obtenerToken( callback: @escaping (_ token:String) -> Void ){
        
        if(Session.shared.tokenOaut == nil  || Session.shared.tokenOaut?.refresh_token == nil ){
            
            self.generarToken { (exito, token) in
                if(exito){
                    
                    callback(token as! String)
                    
                }else{
                    callback("")
                }
            }
            
        }else{
             //si el token no es nulo se valida el tiempo de vida de este
            let fechaGeneracion = NSString(string: (Session.shared.tokenOaut?.fecha_generacion)!).doubleValue
            let ahora = Date().timeIntervalSince1970 * 1000
            var expires_in = Session.shared.tokenOaut?.expires_in
            
            if(expires_in == nil){
                expires_in = 0
            }
            
            let doubleExpire: Double = (Double(expires_in!) * 1000) - 2000
            
            if((ahora - fechaGeneracion) > doubleExpire ){
                  //se regenera el token
                self.generarToken { (exito, token) in
                    if(exito){
                        
                        callback(token as! String)
                        
                    }else{
                        callback("")
                    }
                }
           }else{
                callback((Session.shared.tokenOaut?.access_token)!)
            }
            
            
        }
       
        
    }
    
    class func generarToken( callback: @escaping (_ exito:Bool,  _ result: AnyObject?) -> Void ){
        print("---> generarToken")
        
        
        
        
        let url = URLHandler.getUrl(urlName: URLHandler.OAUTH_TOKEN)
        
        do {
            
            /*var request = RequestGeneraTokenBean()
            request.grant_type = "password"
            request.username = Session.shared.user?.email
            request.password = Session.shared.user?.uuid*/
            
            let headers = [
                "Authorization": Constants.AUTHORIZATION_REST,
                "Content-Type":"application/x-www-form-urlencoded;charset=UTF-8"
            ]
            
            let parameters = [
                "grant_type": "password",
                "username": Session.shared.user?.email,
                "password": Session.shared.user?.uuid
            ]
            
            ServiciosUtil.postFormRequest(urlString: url, parameters: parameters as! [String : String], headers: headers) { (exito, response) in
                
                if exito {
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseBaseOauth.self, from: response as! Data)
                        
                     
                        Session.shared.tokenOaut?.access_token = json.access_token
                        Session.shared.tokenOaut?.expires_in = json.expires_in
                        Session.shared.tokenOaut?.refresh_token = json.refresh_token
                        Session.shared.tokenOaut?.fecha_generacion = String(Date().timeIntervalSince1970 * 1000)
                        
                     
                        
                        callback(true, json.access_token as AnyObject)
                    
                        
                    } catch let errorJson {
                        print(errorJson)
                        var errorBean = ErrorBean()
                        errorBean.codigo = Constants.ERRORCODE.internalError
                        errorBean.mensaje = Constants.ERROR.noServiceAvailable
                        callback(false, errorBean as AnyObject)
                        
                        //callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
                    }
                    
                }else{ //error al realizar la peticion
                    
                    //let errorBean = response as! ErrorBean
                    callback(false,response as AnyObject)
                    
                }
                
            }// fin postRequest
            
        } catch {
            var errorBean = ErrorBean()
            errorBean.codigo = Constants.ERRORCODE.internalError
            errorBean.mensaje = Constants.ERROR.noServiceAvailable
            callback(false, errorBean as AnyObject)
            //callback(false,Constants.ERROR.noServiceAvailable as AnyObject)
            
        }
        
    }
    
    
    class func postFormRequest(urlString:String, parameters:[String:String]? = nil, headers: [String:String]? = nil, callback: @escaping (_ exito:Bool,  _ result: AnyObject?) -> Void ){
        //print("postRequest URL: \(url)")
        
        
        if ConnectionService.isConnectedToNetwork() {
            
            let manager = Alamofire.SessionManager.default
            manager.session.configuration.timeoutIntervalForRequest = 3
            
            Alamofire.request(urlString,  method: .post, parameters: parameters, encoding: URLEncoding.httpBody, headers: headers).responseJSON { response in
                
                print(response)
                
                switch response.result {
                case .success( _):
                    
                    var banErrorParse = false
                    
                    ///Se valida si es un response del back
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseBase.self, from: response.data! )
                        if json.codigo == 0 {
                            
                            let json = response.data! as AnyObject
                            callback(true, json)
                            
                        } else {
                            //Error 500
                            callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
                        }
                        
                    } catch let errorJson {
                        print(errorJson)
                        //callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
                    }
                    ///
                    
                    ///Se regresa el response directo en caso de no se ResponseBase
                   
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
