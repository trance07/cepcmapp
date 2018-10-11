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
    
    
    func recuperarPassword(email: String) {
        
        print("---> Recuperar password")
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            print("---> Enviando correo de recuperacion")
            
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
        var regreso :  String = ""
        
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
        
        
    }
    
}
