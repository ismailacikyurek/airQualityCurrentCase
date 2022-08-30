//
//  Service.swift
//  theMoviePopularMVVM
//
//  Created by İSMAİL AÇIKYÜREK on 16.08.2022.
//


import Foundation
import UIKit
import Alamofire


//MARK: Protocol
protocol AirQualityDataServiceProtocol {
    func fethAllPostsAir(url:String,header : HTTPHeaders,onSuccess: @escaping (AirQualityModel) -> Void, onFail: @escaping (String?) -> Void)
}

//MARK: Get Datas
struct AirQualityDataService: AirQualityDataServiceProtocol {
    func fethAllPostsAir(url: String, header: HTTPHeaders, onSuccess: @escaping (AirQualityModel) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of:AirQualityModel.self) { (response) in
            guard let items =  response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(items)
        }
    }
}

