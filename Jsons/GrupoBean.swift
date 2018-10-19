//
//  GrupoBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct GrupoBean : Codable {
    var id : Int? = 0
    var descripcion : String? = nil
    var carrera : CarreraBean? = nil
    var localidad : ItemBean? = nil
    
    func getArrayObj() -> [String : Any] {
        return [ "id":id,
                 "descripcion":descripcion,
                 "carrera":carrera?.getArrayObj(),
                 "localidad":localidad?.getArrayObj()
            ] as [String : Any]
    }
}
