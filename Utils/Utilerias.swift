//
//  Utilerias.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import SystemConfiguration

class Utilerias {
    
    let titulo : String = "CEPCM"
    
    class func validarEmail(email : String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print("el email test es: \(emailTest.evaluate(with: email))")
        return emailTest.evaluate(with: email)
        
    }
    
    
}

