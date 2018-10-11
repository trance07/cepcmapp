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
        static let noServiceAvailable = "Servicio no disponible.\nPor favor intenta de nuevo más tarde.";
        static let noInternetAvailable = "Verifica tu conexión a internet e intenta nuevamente";
    }
    
    struct ERRORCODE {
        static let timeOut                  = "001";
        static let noInternetAvailable      = "002";
        static let errorDesconocido         = "003";
        static let invalidURL               = "004";
        static let parameterEncodingFailed  = "005";
        static let multipartEncodingFailed  = "006";
        static let responseValidationFailed = "007";
        static let localizedDescription     = "008";
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
