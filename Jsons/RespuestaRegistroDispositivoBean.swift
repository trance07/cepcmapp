//
//  RespuestaRegistroDispositivoBean.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 15/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct RespuestaRegistroDispositivoBean : Codable {
    var valido : Bool = false
    var mensaje : String? = nil
    var alumno : AlumnoBean? = nil
    var grupo : GrupoBean? = nil
}
