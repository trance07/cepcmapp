//
//  SessionBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/5/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct SessionBean : Codable {
    var requestUsuario : RequestUsuario? = nil
    var tokenOaut: ResponseTokenBean? = nil
    var listaMaterias : [MateriaCarreraBean]? = nil
    var listaCalificaciones : [CalificacionesBean]? = nil
    var listaMensajes : [NotificacionBean] = [NotificacionBean]()
    var listaHorarios : [CalendarioMateriaBean] = [CalendarioMateriaBean]()
    var pagosUsuario: PagosBean? = PagosBean()
    var adeudosUsuario : PagosBean? = PagosBean()
    var flagNotificacion : Bool = false
    var minutesBefore : Int = 10
    var bannerHome : ConfiguracionBannerBean? = nil
    var backendConf : ConfiguracionBackEndBean? = ConfiguracionBackEndBean()
    var configuracionmodulos : ConfiguracionFirebase? = ConfiguracionFirebase()
    var alumnoBean : AlumnoBean? = nil
}
