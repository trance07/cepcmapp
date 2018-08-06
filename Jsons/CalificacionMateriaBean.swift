//
//  CalificacionMateriaBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//
import Foundation

struct CalificacionMateriaBean : Codable {
    var idMateria : Int?
    var materia : String?
    var claveMateria : String?
    var calificacion : Double?
    var fechaAaignacion : Date?
    var detalle : String?
}
