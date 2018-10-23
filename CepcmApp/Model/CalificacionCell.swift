//
//  CalificacionCell.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 10/21/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import UIKit

class CalificacionCell: UITableViewCell {

    @IBOutlet weak var imgCalificacion: UIImageView!
    
    @IBOutlet weak var lblCalificacion: UILabel!
    
    @IBOutlet weak var lblMateria: UILabel!
    
    @IBOutlet weak var lblFecha: UILabel!
    
    @IBOutlet weak var lblClave: UILabel!
    
    func setClave(clave: String) {
        lblClave.text = clave
    }
    
    func setFecha(fecha: String) {
        lblFecha.text = fecha
    }
    
    func setMateria(materia: String) {
        lblMateria.text = materia
    }
    
    func setCalificacion(calificacion: String) {
        lblCalificacion.text = calificacion
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
