//
//  PagoBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//
import Foundation

struct PagoBean : Codable {
    var noRecibo : String
    var monto : Float = 0
    var fechaRecibo : Date
    var conceptos : [ConceptoPagoBean]
}
