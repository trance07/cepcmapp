//
//  ResponseConfiguracionAppBean.swift
//  CepcmApp
//
//  Created by marco polo navarrete on 8/4/18.
//  Copyright © 2018 marco polo navarrete. All rights reserved.
//

struct ResponseConfiguracionAppBean : Codable {
    var backend : ConfiguracionBackEndBean? = ConfiguracionBackEndBean()
    var version : ConfiguracionVersionBean? = ConfiguracionVersionBean()
    var bannerTop : ConfiguracionBannerBean? = ConfiguracionBannerBean()
}
