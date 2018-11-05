//
//  DetalleCalificacionesService.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 11/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

import Foundation

class DetalleCalificacionesService {
    
    func obtenerDetalleCalificacion(idMateria : Int?, callback: @escaping(Bool, AnyObject) -> ()) {
        
        print("---> Obteniendo detalle de calificaciones")
        
        let url = URLHandler.getUrl(urlName: URLHandler.DETALLE_CALIFICACIONES)
        
        do {
            
            var parametros = [String: String]()
            parametros["id_materia"] = String(idMateria!)
            
            ServiciosUtil.getRequestWhitToken(urlString: url, parameters: parametros, headers: nil) { (exito, response) in
                
                if exito == true {
                    
                    do {
                        
                        let json = try JSONDecoder().decode(ResponseObtenerDetalleMateriaBean.self, from: response as! Data)
                        
                        if json.codigo == 0 {
                            callback(true, json.respuesta as AnyObject)
                        } else {
                            callback(false, json.mensaje as AnyObject)
                        }
                        
                    } catch let errorJson {
                        
                        print("=====> JSON ERROR DETALLE CALIFICACION \(errorJson)")
                        
                        callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
                        
                    }
                    
                }
                
            }
            
        } catch {
            
            callback(false, Constants.ERROR.noServiceAvailable as AnyObject)
            
        }
        
    }
    
}
