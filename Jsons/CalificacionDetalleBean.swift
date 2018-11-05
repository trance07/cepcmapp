//
//  CalificacionDetalleBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct CalificacionDetalleBean : Codable {
    var sesiones : String?
    var fecha_inicio : String?
    var fecha_termino : String?
    var hora_inicio : String?
    var hora_termino : String?
    var no_sesiones : Int = 0
    var conceptos_asistencias : [ConceptoAsistenciaBean]? = nil
    var docente  : DocenteBean?
}
