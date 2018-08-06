//
//  PagosBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct  PagosBean : Codable {
    var listPagosColegiaturas : [PagoBean]?
    var listPagosDocumentos : [PagoBean]?
    var listPagosCedulas : [PagoBean]?
    var listPagosTitulaciones : [PagoBean]?
    var listPagosEventos : [PagoBean]?
    var listPagosLibrosEditados : [PagoBean]?
}
