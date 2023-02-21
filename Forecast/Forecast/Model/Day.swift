//
//  Day.swift
//  Forecast
//
//  Created by Chase on 2/21/23.
//

import Foundation

class Day {
    
    let cityName: String
    let temp: Double
    let highTemp: Double
    let lowTemp: Double
    let description: String
    let iconString: String
    let validDate: String
    
    init?(dayDictionary: [String : Any], cityName: String) {
        guard let temp = dayDictionary["temp"] as? Double,
              let highTemp = dayDictionary["high_temp"] as? Double,
              let lowTemp = dayDictionary["low_temp"] as? Double,
              let validDate = dayDictionary["valid_date"] as? String,
              /// Parsing an additional level for the remaining values.
              let weatherDict = dayDictionary["weather"] as? [String:Any],
              /// Now I have access to the remaining values
              let description = weatherDict["description"] as? String,
              let iconString = weatherDict["icon"] as? String else { return nil}
        
        self.cityName = cityName
        self.temp = temp
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.description = description
        self.iconString = iconString
        self.validDate = validDate
    }
}
