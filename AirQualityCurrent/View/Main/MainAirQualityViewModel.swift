//
//  MainAirQualityViewModel.swift
//  AirQualityCurrent
//
//  Created by İSMAİL AÇIKYÜREK on 25.08.2022.
//

import Foundation
import Alamofire
// MARK: Protokols
protocol MainAirQualityViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: MainAirQualityViewController)
    func search(searctext : String)
     var city : [String] {get set}
     var filterCityArray : [String]{get set}
}

class MainAirQualityViewModel:NSObject, MainAirQualityViewModelProtocol {
    var filterCityArray = [String]()
    var city = [String]()
    private let service: AirQualityDataServiceProtocol = AirQualityDataService()
    private let serviceManager = ServiceManager()
    func search(searctext: String) {
        filterCityArray = searctext.isEmpty ? city : city.filter { $0.contains(searctext) }
    }
    
    func setUpDelegate(_ viewController: MainAirQualityViewController) {}
    
    func initialize() {
        AirQualityService()
    }
    
    func AirQualityService() {
        service.fethAllPostsAir(url: serviceManager.urlAllCity, header: serviceManager.headers) { [weak self] model in
            self?.cityNameSave(content: model)
        } onFail: { error in
            print(error?.description ?? "An error occured")
        }
    }
    
    func cityNameSave(content : AirQualityModel) {
        guard let data = content.stations else {return}
        for i in 0...(data.count-1) {
            guard let cityName = content.stations?[i].placeName else {return}
            city.append(cityName)
        }
    }
}
