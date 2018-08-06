//
//  TabPagoBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct TabPagoBean : Codable {
    var name : String? = nil
    var hex : String? = nil
    var color : Int? = nil
    var pagos : [PagoBean]? = nil
    var identificador : String? = nil
}
