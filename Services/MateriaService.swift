//
//  MateriaService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 10/7/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class MateriaService {
    
    var fireAuth = Auth.auth()
    
    var fireBase = Database.database().reference(withPath: "alumnos")
    
}
