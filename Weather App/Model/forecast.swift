//
//  forecast.swift
//  Weather App
//
//  Created by Tariq M.fathy on 6/7/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit
import Alamofire

class forecast {
    var _date: String!
    var _weatherType: String!
    var _tempMini: String!
    var _tempMax: String!
    
    var date: String {
        if _date == nil{
            _date = ""
        }
        return _date
    }
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    var tempMini: String{
        if _tempMini == nil{
            _tempMini = ""
        }
        return _tempMini
    }
    var tempMax: String{
        if _tempMax == nil{
            _tempMax = ""
        }
        return _tempMax
    }
    
    init (weatherDict: Dictionary<String, AnyObject>){
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            if let min = temp["min"] as? Double{
                let kelvenToFerenheit = Double (round (10 * (min * (9 / 5) - 459.67) / 10))
                self._tempMini = "\(kelvenToFerenheit)"
            }
            if let max = temp["max"] as? Double{
                let kelvenToFerenheit = Double (round (10 * (max * (9 / 5) - 459.67) / 10))
                self._tempMax = "\(kelvenToFerenheit)"
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weatherType = main
            }
        }
        if let dt = weatherDict["dt"] as? Double{
            let unixConverterDate = Date(timeIntervalSince1970: dt)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConverterDate.dayOfTheWeak()
        }
    }
    
}
extension Date{
    func dayOfTheWeak() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
