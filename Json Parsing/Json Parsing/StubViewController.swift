//
//  StubViewController.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 30.03.2021.
//

import UIKit
import SVProgressHUD
class StubViewController: UIViewController {

    var weatherLoaderAlamFire: WeatherLoader?
    var weatherLoaderStandart: WeatherLoaderStandart?
    
    var isHourlyWeatherLoaded = false
    var isDailyWheatherLoaded = false
    var isCurrentWeatherLoaded = false
    
    var currentPlaceName = "Moscow"
    
    // false - alamFire, true - standart method
    var parseType = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SVProgressHUD.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if(parseType){
            weatherLoaderStandart = WeatherLoaderStandart()
            weatherLoaderStandart?.delegat = self
            weatherLoaderStandart?.UpdateDataForPlace(place: currentPlaceName)
        }else{
            weatherLoaderAlamFire = WeatherLoader()
            weatherLoaderAlamFire?.delegat = self
            weatherLoaderAlamFire?.updateDataForPlace(place: currentPlaceName)
        }
    }

    func segue(){
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationViewController = mainStoryBoard.instantiateViewController(identifier: "StandartWeatherViewController") as? WeatherViewController else{
            print("Can't load view controller")
            return
        }
        
        isHourlyWeatherLoaded.toggle()
        isDailyWheatherLoaded.toggle()
        isCurrentWeatherLoaded.toggle()
        
        destinationViewController.modalTransitionStyle = .crossDissolve
        destinationViewController.modalPresentationStyle = .fullScreen
        destinationViewController.stubDelegate = self
        destinationViewController.currentPlaceName = currentPlaceName
        if(parseType){
            destinationViewController.currentWeather = weatherLoaderStandart!.currentWeather
            destinationViewController.hourlyWeather = weatherLoaderStandart!.hourlyWeather
            destinationViewController.dayInfo = weatherLoaderStandart!.dayInfo
        } else{
            destinationViewController.currentWeather = weatherLoaderAlamFire!.currentWeather
            destinationViewController.hourlyWeather = weatherLoaderAlamFire!.hourlyWeather
            destinationViewController.dayInfo = weatherLoaderAlamFire!.dayInfo
            
        }
        SVProgressHUD.dismiss()
        present(destinationViewController, animated: true, completion: nil)
    }
}

extension StubViewController: WeatherLoaderDelegate{
    func loadedCurrentWeather() {
        isCurrentWeatherLoaded.toggle()
        if(isCurrentWeatherLoaded && isDailyWheatherLoaded && isHourlyWeatherLoaded){
            self.segue()
        }
    }
    
    func loadedDailyWheather() {
        isDailyWheatherLoaded.toggle()
        if(isCurrentWeatherLoaded && isDailyWheatherLoaded && isHourlyWeatherLoaded){
            self.segue()
        }
    }
    
    func loadedHourlyWeather() {
        isHourlyWeatherLoaded.toggle()
        if(isCurrentWeatherLoaded && isDailyWheatherLoaded && isHourlyWeatherLoaded){
            self.segue()
        }
    }
    

        
}


extension StubViewController: StubDelegate{
    func changeParseType() {
        parseType.toggle()
    }
    
    func changePlaceName(place: String) {
        currentPlaceName = place
    }
    
    
}

extension Double {
    func string(maximumFractionDigits: Int = 2) -> String {
        let s = String(format: "%.\(maximumFractionDigits)f", self)
        for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
            if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
                return String(s[..<s.index(s.endIndex, offsetBy: i)])
            }
        }
        return String(s[..<s.index(s.endIndex, offsetBy: -maximumFractionDigits - 1)])
    }
}
