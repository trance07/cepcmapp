//
//  TokenOautBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import  Foundation

struct TokenOautBean : Codable {
    var token : String? = nil
    var token_refresh : String? = nil
    var tiempo_vida : Int64? = 0
    var fecha_generacion : Date? = nil
}
