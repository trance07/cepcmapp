//
//  MateriaBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct MateriaBean : Codable {
    var id : Int
    var modulo : Int
    var descripcion : String
    var clave : String
    var seriacion : Int
    var curricular : Bool
    var creditos : Double
    var str_curricular : String
    var materia_terminada : Bool
}
