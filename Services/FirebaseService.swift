//
//  FirebaseService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/18/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseService {
    
    func crearCuentaFirebase(email : String, password : String) -> String {
        
        print("---> Creando cuenta en firebase")
        var regreso :  String = ""
        
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            
            if error == nil {
                
                print("el user id es: \(user?.user.uid)")
                regreso = (user?.user.uid)!
                
            } else {
                regreso = "error"
            }
            
            
            
        })
        
        
        return regreso
        
    }
    
}
