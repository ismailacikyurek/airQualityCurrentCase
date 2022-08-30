//
//  ServiceManager.swift
//  AirQualityCurrent
//
//  Created by İSMAİL AÇIKYÜREK on 22.08.2022.
//

import Foundation
import Alamofire

struct ServiceManager {
    let urlCity = "https://api.ambeedata.com/latest/by-city?city="
    let urlAllCity = "https://api.ambeedata.com/latest/by-country-code?countryCode=US"
    let headers : HTTPHeaders = ["x-api-key" : "ff9ce01042fe6b09c1293215262d8ef40764888ba1fc4444a61f83cd95afaa53","Content-type" : "application/json"]
}
