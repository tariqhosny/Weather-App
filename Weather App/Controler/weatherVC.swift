

import UIKit
import Alamofire

class weatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var currentWeatherStatus: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var DownloadData = downloadData()
    var Forecasts = [forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DownloadData.downloadWeatherDetails {
            self.DownloadForecastData {
                self.updateUI()
            }
        //print(self.CurrentWeather.cityName)
            
        }

    }
    
    func DownloadForecastData(completed: @escaping DownloadComplete){
        let forecastURL = URL(string: CURRENT_FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for obj in list{
                        let Forecast = forecast(weatherDict: obj)
                        self.Forecasts.append(Forecast)
                        
                        print(obj)
                    }
                }
            }
        completed()}
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        return cell
    }
   
    func updateUI() {
        dateLabel.text = DownloadData.date
        currentTempLabel.text = "\(DownloadData.currentTemp)"
        locationLable.text = DownloadData.cityName
        currentWeatherStatus.text = DownloadData.weatherStatus
        currentWeatherImage.image = UIImage(named: DownloadData.weatherStatus)
    }
}


