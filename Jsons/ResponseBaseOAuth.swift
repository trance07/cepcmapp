//
//  ResponseBaseOAuth.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 16/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct ResponseBaseOauth : Codable {
    var access_token : String? = nil
    var expires_in : UInt64 = 0
    var refresh_token : String? = nil
}
