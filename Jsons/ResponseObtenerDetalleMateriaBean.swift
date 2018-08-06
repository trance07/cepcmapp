//
//  ResponseObtenerDetalleMateriaBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct ResponseObtenerDetalleMateriaBean : Codable {
    var codigo : Int = 0
    var mensaje : String? = nil
    var respuesta : CalificacionDetalleBean? = nil
}
