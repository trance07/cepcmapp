//
//  RespuestaValidaCuentaAlumnoBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct RespuestaValidaCuentaAlumnoBean : Codable {
    var valido : Bool = false
    var mensaje : String? = nil
    var alumno : AlumnoBean? = nil
    var grupo : GrupoBean? = nil
}
