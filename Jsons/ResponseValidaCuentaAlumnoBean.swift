//
//  ResponseValidaCuentaAlumnoBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct ResponseValidaCuentaAlumnoBean : Codable {
    var codigo : Int = 0
    var mensaje : String? = nil
    var respuesta : RespuestaValidaCuentaAlumnoBean? = nil
}
