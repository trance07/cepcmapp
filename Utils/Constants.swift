//
//  Constants.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 09/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//
import UIKit

enum AppStatus: String {
    case background = "app.background"
    case foreground = "app.foreground"
}

struct Constants {
    
    static let appName = "CEPCM Móvil"
    static let appAviso = "Aviso"
    
    struct ERROR {
        static let noServiceAvailable = "Conexión no disponible.\nPor favor, verifica la conexión a internet o intenta de nuevo más tarde.";
    }
    
    struct Segue {
        static let enter = "segue.enter"
        static let register = "segue.register"
        static let registerWeb = "segue.register.web"
        static let recover = "segue.recover"
        static let assisted = "segue.assisted"
        
        static let profileData = "segue.profile.data"
      
    }
    
}
