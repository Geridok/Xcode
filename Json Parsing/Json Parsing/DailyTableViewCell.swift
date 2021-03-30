//
//  DailyTableViewCell.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 27.03.2021.
//

import UIKit
import Spring

struct DayInfo {
    var dayName: String
    var date: String
    var weatherIcon: UIImage
    var maxTemp: String
    var minTemp: String
    
    init?(data: NSDictionary, timeZoneOffset: Double) {
        guard let timeUnix = data["dt"] as? Double, let tempDict = data["temp"] as? NSDictionary, let weatherInfo = data["weather"] as? NSArray else {
            return nil
        }
        
        let zoneTimeUnix = timeUnix + timeZoneOffset
        
        let date = Date(timeIntervalSince1970: zoneTimeUnix)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd"
        
        let dateString = dayTimePeriodFormatter.string(from: date)
        
        let weekday = dayTimePeriodFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]

        dayName = weekday
        self.date = dateString
        
        guard let maxTemp = tempDict["max"] as? Double, let minTemp = tempDict["min"] as? Double, let weatherDict = weatherInfo[0] as? NSDictionary else {
            return nil
        }
        
        self.maxTemp = Double(maxTemp - 273.15).string(maximumFractionDigits: 1)
        self.minTemp = Double(minTemp - 273.15).string(maximumFractionDigits: 1)
        guard let iconName = weatherDict["icon"] as? String else {
            return nil
        }
        
        let iconRequest = WeatherRequests.icon + iconName + RequestParam.iconEnd
        
        if let url = URL(string: iconRequest){
        if let data = try? Data(contentsOf: url) {
            self.weatherIcon = UIImage(data: data) ?? UIImage(named: "sun")!
        }else{ return nil }
        }else{ return nil}
    }
}

class DailyTableViewCell: UITableViewCell {

    static var identifier = "DailyTableViewCell"
    
    @IBOutlet weak var dayNameLabel: SpringLabel!
    @IBOutlet weak var dateLabel: SpringLabel!
    
    @IBOutlet weak var weatherIcon: SpringImageView!
    @IBOutlet weak var maxTemperatureLabel: SpringLabel!
    @IBOutlet weak var minTemperatureLabel: SpringLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {

        return UINib(nibName: "DailyTableViewCell", bundle: nil)
    }
    
    func configure(dayWheatherInfo: DayInfo) {
        dayNameLabel.text = dayWheatherInfo.dayName
        dateLabel.text = dayWheatherInfo.date
        weatherIcon.image = dayWheatherInfo.weatherIcon
        maxTemperatureLabel.text = dayWheatherInfo.maxTemp
        minTemperatureLabel.text = dayWheatherInfo.minTemp
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
