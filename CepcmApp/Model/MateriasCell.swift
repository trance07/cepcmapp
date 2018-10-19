//
//  TableViewCellMateriasTableViewCell.swift
//  CepcmApp
//
//  Created by Juan Carlos Castro Martinez on 18/10/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class MateriasCell: UITableViewCell {

    @IBOutlet weak var lblMateria: UILabel!
    
    func setMateria(materia: String) {
        lblMateria.text = materia
    }
}
