//
//  DetailsViewModel.swift
//  AirQualityCurrent
//
//  Created by İSMAİL AÇIKYÜREK on 21.08.2022.
//

import Foundation
import UIKit
import Alamofire
import CoreData

protocol DetailsViewModelProtocol {
    func initialize()
    func setUpDelegate(_ viewController: DetailsViewController)
    func ListPreviousRecords(postalCode : String)
     var cityName : String?  {get set}
     var list : [AirQuality]? {get set}
}

protocol DetailsViewModelOutputProtocol {
    func showDataAir(content: AirQualityModel)
    func dataNotFound()
}

class DetailsViewModel:NSObject, DetailsViewModelProtocol {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context:NSManagedObjectContext
    var list: [AirQuality]?
    private let service: AirQualityDataServiceProtocol
    private let serviceManager = ServiceManager()
    var delegate: DetailsViewModelOutputProtocol?
    var cityName : String?
    private let time = TimeAndDate()
    
    override init() {
        self.context = self.appDelegate.persistentContainer.viewContext
        self.service = AirQualityDataService()
    }

   func coreDataAdd(data: AirQualityModel) {
        let air = AirQuality(context: context)
        air.placeName = data.stations?[0].placeName
        air.so2 = (data.stations?[0].so2)!
        air.pm25 = (data.stations?[0].pm25)!
        air.pm10 = (data.stations?[0].pm10)!
        air.ozone = (data.stations?[0].ozone)!
        air.no2 = (data.stations?[0].no2)!
        air.co = (data.stations?[0].co)!
        air.category = data.stations?[0].aqiInfo?.category
        air.pollutant = data.stations?[0].aqiInfo?.pollutant
        air.postalCode = data.stations?[0].postalCode
        time.dateTime()
        air.hour = time.hour
        air.day = time.date
        appDelegate.saveContext()
    }
    
    func ListPreviousRecords(postalCode : String) {
        do  {
            let request = AirQuality.fetchRequest() as NSFetchRequest<AirQuality>
            let pred = NSPredicate(format: "postalCode CONTAINS '\(postalCode)'")
            request.predicate = pred
            list = try context.fetch(request)
        } catch {
            print(error)
        }
    }
     
    func setUpDelegate(_ viewController: DetailsViewController) {
        delegate = viewController as DetailsViewModelOutputProtocol
    }
  
    func initialize() {
        AirQualityService()
    }
    
    func AirQualityService() {
     guard let cityName = cityName else {return}
      service.fethAllPostsAir(url: serviceManager.urlCity+cityName, header: serviceManager.headers) { [weak self] model in
         self?.delegate?.showDataAir(content: model)
         self?.coreDataAdd(data: model)
        } onFail: { error in
            self.delegate?.dataNotFound()
            print(error?.description ?? "An error occured")
        }
    }
}
