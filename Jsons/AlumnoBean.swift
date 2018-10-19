//
//  AlumnoBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct AlumnoBean: Codable {
    var id : Int?
    var nombres : String?
    var apaterno : String?
    var amaterno : String?
    var matricula : String?
    
    func getArrayObj() -> [String : Any] {
        return [ "id":id,
                 "matricula":matricula,
                 "nombres":nombres,
                 "apaterno":apaterno,
                 "amaterno":amaterno
               ] as [String : Any]
    }
}
