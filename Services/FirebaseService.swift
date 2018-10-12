//
//  FirebaseService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/18/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FirebaseService {
    
    let userDefaults = UserDefaults.standard
    
    let firebase_field_alumnos : String = "alumnos"
    
    
    func recuperarPassword(email: String, callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        
        print("---> Recuperar password")
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            if error != nil {
                
                ServiciosUtil.validaResponseErrorFirebase(error: (error?._code)!, callback: { (response) in
                    
                    let errorBean = response as! ErrorBean
                    callback(false,errorBean.mensaje! as AnyObject)
                    
                })
                
            } else {
                
                callback(true,"ok" as AnyObject)
            }
            
            
        }
        
    }
    
    func persistirDatosAlumnoFirebase() {
        
        print("---> Persistir datos en firebase")
        var userFirebase = userDefaults.object(forKey: "userFirebase")
        var database = Database.database().reference(withPath: self.firebase_field_alumnos)
        
       /* userFirebase.currentUser?.sendEmailVerification { (error) in
            // falta contenido aqui
        }*/
        
    }
    
    func crearCuentaFirebase(email : String, password : String, callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        
        print("---> Creando cuenta en firebase")
        
        let userFirebase = Auth.auth()
        
        userFirebase.createUser(withEmail: email, password: password, completion: {
            (user, error) in
            
            if error != nil {
                
                ServiciosUtil.validaResponseErrorFirebase(error: (error?._code)!, callback: { (response) in
                    
                    let errorBean = response as! ErrorBean
                    callback(false,errorBean.mensaje! as AnyObject)
                    
                })
                
            } else {
                
                
                print("el user es: \(user)")
                print("el user id es: \(user?.user.uid)")
                
                self.userDefaults.set(email, forKey: "emailAlumno")
                self.userDefaults.set((user?.user.uid)!, forKey: "uidAlumno")
              
                
                var uid = (user?.user.uid)!
                
                callback(true,uid as AnyObject)
            }
            
            
            
        })
        
        
    }//Fin crearCuentaFirebase
    
    func enviarEmailVerificacion(email : String, callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        
        print("---> Enviando Email de Verificacion")
       
        let userFirebase = Auth.auth()
        
        let actionCodeSettings = ActionCodeSettings.init()
        actionCodeSettings.url = URL.init(string: "https://<redacted>/applinks/firebaseprovider/signin")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        userFirebase.sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings,  completion: {
            (error) in
            
            if error != nil {
                
                ServiciosUtil.validaResponseErrorFirebase(error: (error?._code)!, callback: { (response) in
                    
                    let errorBean = response as! ErrorBean
                    callback(false,errorBean.mensaje! as AnyObject)
                    
                })
                
            } else {
            
                callback(true,Constants.INFO.validateRegisterEmailVerification as AnyObject)
            }
                
        })// fin sendSignInLink
        
    }//Fin crear enviarEmailVerificacion
    
    func loguearCuentaFirebase(email : String, password : String, callback: @escaping (Bool,AnyObject) -> ()) -> Void {
        
        print("---> Creando cuenta en firebase")
        
        let userFirebase = Auth.auth()
        
        userFirebase.signIn(withEmail: email, password: password, completion: {
            (user, error) in
            
            if error != nil {
                
                ServiciosUtil.validaResponseErrorFirebase(error: (error?._code)!, callback: { (response) in
                    
                    let errorBean = response as! ErrorBean
                    callback(false,errorBean.mensaje! as AnyObject)
                    
                })
                
            } else {
                
                
                callback(true,Auth.auth().currentUser?.uid as AnyObject)
            }
            
            
            
        })
        
        
    }//Fin crearCuentaFirebase
    
    
    
}
