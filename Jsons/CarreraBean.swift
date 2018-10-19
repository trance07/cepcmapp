//
//  CarreraBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct CarreraBean : Codable {
    var id : Int? = 0
    var descripcion : String? = nil
    var nivel : ItemBean? = nil
    
    func getArrayObj() -> [String : Any] {
        return [ "id":id,
                 "descripcion":descripcion,
                 "nivel":nivel?.getArrayObj()
            ] as [String : Any]
    }
}
