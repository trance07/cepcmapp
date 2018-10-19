//
//  ResponseTokenBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct ResponseTokenBean : Codable {
    var refresh_token : String? = nil
    var token_type : String? = nil
    var scope : String? = nil
    var fecha_generacion : String? = nil
    var access_token : String? = nil
    var expires_in : UInt64? = nil
}
