//
//  PagosPorAlumnoBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct PagosPorAlumnoBean : Codable {
    var pagosColegiaturas : [PagoBean]? = nil
    var pagosDocumentosAdicionales : [PagoBean]? = nil
    var pagoscedulasCertificados : [PagoBean]? = nil
    var pagosTitulaciones : [PagoBean]? = nil
    var pagosEventosEspeciales : [PagoBean]? = nil
    var pagosLibrosEditados : [PagoBean]? = nil
}
