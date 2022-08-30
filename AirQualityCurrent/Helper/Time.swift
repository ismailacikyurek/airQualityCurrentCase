//
//  saatdeneme.swift
//  AirQualityCurrent
//
//  Created by İSMAİL AÇIKYÜREK on 25.08.2022.
//

import Foundation
import UIKit

class TimeAndDate {
    var time = Date()
    var date = String()
    var hour = String()
    func dateTime() {
        let formatterHour = DateFormatter()
        formatterHour.dateFormat = "HH a"
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "MMM dd, yyyy"
        date = formatterDay.string(from: time)
        hour = formatterHour.string(from: time)
        }
}

