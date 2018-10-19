//
//  RequestGeneraToken.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 15/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct RequestGeneraTokenBean : Codable {
    var grant_type : String? = nil
    var username : String? = nil
    var password : String? = nil
    var refresh_token : String? = nil
}
