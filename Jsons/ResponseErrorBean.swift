//
//  ResponseErrorBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct ResponseErrorBean : Codable {
    var code : Int = 0
    var error : String? = nil
    var error_description : String? = nil
}
