//
//  NotificacionBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct NotificacionBean : Codable {
    var id : Int = 0
    var titulo : String? = nil
    var mensaje : String? = nil
    var accion : String? = nil
    var imagen : String? = ""
    var leido : Bool = false
    var fecha : String = ""
}
