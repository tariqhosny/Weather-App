//
//  downloadData.swift
//  Weather App
//
//  Created by Tariq M.fathy on 6/1/19.
//  Copyright © 2019 Tariq M.fathy. All rights reserved.
//

import UIKit
import Alamofire

class downloadData{

    var _cityName: String!
    var _date: String!
    var _weatherStatus: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    var weatherStatus: String {
        if _weatherStatus == nil {
            _weatherStatus = ""
        }
        return _weatherStatus
    }
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }

func downloadWeatherDetails (completed: @escaping DownloadComplete){
    let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
    Alamofire.request(currentWeatherURL).responseJSON{ response in
        let result = response.result
        
        if let dict = result.value as? Dictionary<String, AnyObject>{
            if let name = dict["name"] as? String{
                self._cityName = name.capitalized
                print(self._cityName ?? "")
            }
            if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                if let main = weather[0]["main"] as? String {
                    self._weatherStatus = main.capitalized
                    print(self._weatherStatus ?? "")
                }
            }
            if let main = dict["main"] as? Dictionary<String, AnyObject>{
                if let temp = main["temp"] as? Double {
                    let kelvenToFerenheit = Double (round (10 * (temp * (9 / 5) - 459.67) / 10))
                    self._currentTemp = kelvenToFerenheit
                    print(self._currentTemp ?? 0.0)
                }
            }
        }
        completed()
    }
}
  

//func downloadForecastDetails (completed: @escaping DownloadComplete){
//    let curruntForecastURL = URL(string: CURRENT_FORECAST_URL)!
//    Alamofire.request(curruntForecastURL) .responseJSON{ response in
//        let result = response.result
//
//        if let dict = result.value as? Dictionary<String, AnyObject>{
//            if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
//                if let dt = list["dt"] as? Double{
//
//                }
//            }
//        };completed()
//    }
//}
}
