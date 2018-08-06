//
//  CalificacionesBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct CalificacionesBean : Codable {
    var id : Int
    var calificacion : Int
    var str_calificacion : String
    var regularizo : Bool
    var tiene_adeudo : Bool
    var calificacion_liberada : Bool
    var fecha : String
    var reprobada : Bool
    var detalle_reprobada : String
    var materia : MateriaBean
}
