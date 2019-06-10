import Foundation

let BASE_URL = "https://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid=b6907d289e10d714a6e88b30761fae22"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)25\(LONGITUDE)125\(APP_ID)"
let CURRENT_FORECAST_URL = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=b6907d289e10d714a6e88b30761fae22"
