//
//  currentWhetherInfoView.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 27.03.2021.
//

import Foundation
import UIKit
import Spring

class CurrentWeather {
    var wind: String
    var pressure:String
    var humidity:String
    var currentTemp: String
    var weatherDescription: String
    var weatherFeelLike: String
    var weatherIcon: UIImage
    
    init?(data: NSDictionary) {
        guard let tempDict = data["main"] as? NSDictionary, let weatherInfo = data["weather"] as? NSArray else {
            return nil
        }
        
        guard let temp = tempDict["temp"] as? Double, let feelsLikeTemp = tempDict["feels_like"] as? Double, let pressure = tempDict["pressure"] as? Double, let humidity = tempDict["humidity"] as? Double, let weatherDict = weatherInfo[0] as? NSDictionary, let windInfo = data["wind"] as? NSDictionary else {
            return nil
        }
        
        currentTemp = Double(temp - 273.15).string(maximumFractionDigits: 1) + "º"
        weatherFeelLike = "Feels like: " + Double(feelsLikeTemp - 273.15).string(maximumFractionDigits: 1) + "º"
        self.pressure = Double(pressure).string() + " mmHg"
        self.humidity = Double(humidity).string() + "%"
        
        guard let description = weatherDict["description"] as? String, let iconName = weatherDict["icon"] as? String, let windSpeed = windInfo["speed"] as? Double else {
            return nil
        }
        
        weatherDescription = description
        wind = Double(windSpeed).string() + " m/s"
        
        let iconRequest = WeatherRequests.icon + iconName + RequestParam.iconEnd
        
        if let url = URL(string: iconRequest){
        if let data = try? Data(contentsOf: url) {
            self.weatherIcon = UIImage(data: data) ?? UIImage(named: "sun")!
        }else{ return nil }
        }else{ return nil }
    }
}

protocol CurrentWeatherInfoDelegate: AnyObject {
    func setNewCity(newCity: String)
    func changeParseType()
}

class CurrentWeatherInfoView: SpringView{
    
    static let identifier = "CurrentWeatherInfoView"
    
    var cities: [String] = []
    
    
    @IBOutlet weak var otherInfoStackView: UIStackView!
    @IBOutlet weak var mainInfoStackView: UIStackView!
    @IBOutlet weak var placePicker: UIPickerView!
    @IBOutlet weak var changeParseTypeButton: SpringButton!
    
    weak var delegate: CurrentWeatherInfoDelegate?

    
    static func loadFromXib() -> CurrentWeatherInfoView {
        let xib = UINib(nibName: "CurrentWeatherInfoView", bundle: nil)
        return xib.instantiate(withOwner: self, options: nil).first as! CurrentWeatherInfoView
    }
    
    @IBAction func changeParseType(_ sender: SpringButton) {
        delegate?.changeParseType()
    }
    
    func configure(cities: [String],currentWeather: CurrentWeather){
        
        
        placePicker.delegate = self
        placePicker.dataSource = self
        self.cities = cities
        //constraints and the like
        let stackConstraints = [
            otherInfoStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -self.frame.height/6),
            otherInfoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.bounds.width/4),
            mainInfoStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -self.frame.height/6),
            mainInfoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: self.bounds.width/4)
        ]
        NSLayoutConstraint.activate(stackConstraints)
        let placePickerY = (mainInfoStackView.frame.origin.y + mainInfoStackView.frame.height)
        placePicker.frame = CGRect(x: 0, y: placePickerY - 50, width: self.frame.width, height: 100)
        
        placePicker.reloadAllComponents()
        
        let window = UIApplication.shared.windows[0]
        
        changeParseTypeButton.frame = CGRect(x: self.frame.width - 130, y: 5, width: 120, height: 20)
        
        changeParseTypeButton.backgroundColor = .clear
        changeParseTypeButton.layer.cornerRadius = 5
        changeParseTypeButton.layer.borderWidth = 1
        changeParseTypeButton.layer.borderColor = UIColor.black.cgColor
        
        //data
        var stackView = mainInfoStackView.arrangedSubviews[0] as! UIStackView
        
        var label = stackView.arrangedSubviews[0] as! SpringLabel
        label.text = currentWeather.currentTemp
        
        label = mainInfoStackView.arrangedSubviews[1] as! SpringLabel
        label.text = currentWeather.weatherDescription
        
        label = mainInfoStackView.arrangedSubviews[2] as! SpringLabel
        label.text = currentWeather.weatherFeelLike
        
        let icon = stackView.arrangedSubviews[1] as! SpringImageView
        icon.image = currentWeather.weatherIcon
        
        stackView = otherInfoStackView.arrangedSubviews[1] as! UIStackView
        
        label = stackView.arrangedSubviews[0] as! SpringLabel
        label.text = currentWeather.wind
        
        label = stackView.arrangedSubviews[1] as! SpringLabel
        label.text = currentWeather.pressure
        
        label = stackView.arrangedSubviews[2] as! SpringLabel
        label.text = currentWeather.humidity
        
    }
    
}

extension CurrentWeatherInfoView: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.setNewCity(newCity: cities[row])
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }

}


