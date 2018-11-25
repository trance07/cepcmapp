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
    
    static let AUTHORIZATION_REST = "Basic Y2xpZW50YXBwOjEyMzQ1Ng=="
    
    struct INFO {
        static let validateRegisterEmailVerification = "n mensaje será enviado a la dirección de correo electrónico especificada. Este correo contiene un enlace para completar el proceso de verificación."
        
    }
    
    struct ERROR {
        static let noServiceAvailable = "Servicio no disponible.\nPor favor intenta de nuevo más tarde.";
        static let noInternetAvailable = "Verifica tu conexión a internet e intenta nuevamente";
        static let emailAlreadyInUse = "Este correo ya ha sido registrado.";
        static let userNotFound             = "No existe una cuenta asociada al correo electrónico especificado, favor de registrarse.";
        static let userDisabled             = "Usuario bloqueado.";
        static let invalidEmail             = "El correo electronico es invalido, favor de verificar";
        static let weakPassword             = "La contraseña debe contener al menos 6 caracteres.";
        static let wrongPassword            = "La contraseña proporcionada no es válida.";
        static let unauthorized             = "unauthorized"
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
        static let emailAlreadyInUse        = "009";
        static let userNotFound             = "010";
        static let userDisabled             = "011";
        static let invalidEmail             = "012";
        static let networkError             = "013";
        static let weakPassword             = "014";
        static let wrongPassword            = "015";
        static let parserError              = "016";
        static let internalError            = "017";
        static let unauthorized             = "018";
        
        
    }
    
    struct Segue {
        static let enter = "segue.enter"
        static let register = "segue.register"
        static let registerWeb = "segue.register.web"
        static let recover = "segue.recover"
        static let assisted = "segue.assisted"
        
        static let profileData = "segue.profile.data"
        
    }
    
    struct FIREBASE_FIELD {
        static let ALUMNOS = "alumnos"
        static let CONFIGURACION = "configuracion"
    }
    
    struct FIREBASE_CONFIGURACION {
        static let MODULOS = "configuracion/modulos"
        static let CALIFICACIONES = "/calificaciones"
        static let APP_ALUMNOS = "configuracion/aplicacionAlumnos"
    }
    
}
