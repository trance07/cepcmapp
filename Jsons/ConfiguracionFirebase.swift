//
//  ConfiguracionFirebase.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct ConfiguracionFirebase : Codable {
    var configuracionMaterias : ConfiguracionModuloFirebase? = ConfiguracionModuloFirebase()
    var configuracionCalificaciones : ConfiguracionModuloFirebase? = ConfiguracionModuloFirebase()
    var configuracionSesiones : ConfiguracionModuloFirebase? = ConfiguracionModuloFirebase()
    var configuracionPagos : ConfiguracionModuloFirebase? = ConfiguracionModuloFirebase()
    var configuracionAdeudos : ConfiguracionModuloFirebase? = ConfiguracionModuloFirebase()
}
