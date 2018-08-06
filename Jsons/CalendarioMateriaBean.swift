//
//  CalendarioMateriaBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//
import Foundation

struct CalendarioMateriaBean : Codable {
    var materia : String
    var horara_inicio : String
    var horara_fin : String
    var sesiones : [Date]?
    var color : Int
}
