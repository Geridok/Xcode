//
//  CollectiveTableViewCell.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 27.03.2021.
//

import UIKit
import Spring
import RealmSwift


class HourlyWeather: Object {
    @objc dynamic var tempText: String = ""
    @objc dynamic var timeText: String = ""
    @objc dynamic var imageName:String = ""
    
    var weatherIcon: UIImage?
    
    func ini(data: NSDictionary, timeZoneOffset: Double)->Self? {
        guard let timeUnix = data["dt"] as? Double, let temp = data["temp"] as? Double, let weatherInfo = data["weather"] as? NSArray else {
            return nil
        }
        
        let zoneTimeUnix = timeUnix + timeZoneOffset
        
        let date = Date(timeIntervalSince1970: zoneTimeUnix)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "ddMMM HH:mm"
        dayTimePeriodFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let dateString = dayTimePeriodFormatter.string(from: date)
        
        self.timeText = dateString
        
        self.tempText = Double( temp - 273.15 ).string(maximumFractionDigits: 1) + "º"
        guard let weatherDict = weatherInfo[0] as? NSDictionary else {
            return nil
        }
        
        guard let iconName = weatherDict["icon"] as? String else {
            return nil
        }
        
        imageName = iconName
        
        let iconRequest = WeatherRequests.icon + iconName + RequestParam.iconEnd
        
        if let url = URL(string: iconRequest){
        if let data = try? Data(contentsOf: url) {
            self.weatherIcon = UIImage(data: data) ?? UIImage(named: "sun")!
        }else{ return nil }
        }else{ return nil}
        return self
    }
    
    
}

class CollectiveTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourForecastCollectiveView.dequeueReusableCell(withReuseIdentifier: CollectiveViewCell.identifier, for: indexPath) as! CollectiveViewCell
        cell.configure(info: self.hourlyWeatherArr[indexPath.row])
        return cell
    }
    
    var hourlyWeatherArr:[HourlyWeather] = []
    
    private var hourForecastCollectiveView: UICollectionView!
    
    static let identifier = "CollectiveTableViewCell"
    
    
    public func configure(weatherInfo: [HourlyWeather]){
        hourlyWeatherArr = weatherInfo
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 110, height: 110)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 3;
        
        let collView = UICollectionView(frame: contentView.bounds,collectionViewLayout: flowLayout)
        
        collView.register(CollectiveViewCell.self, forCellWithReuseIdentifier: CollectiveViewCell.identifier)
        collView.isScrollEnabled = true
        collView.showsVerticalScrollIndicator = false
        collView.backgroundColor = UIColor.init(hex: "C9FEFF")
       hourForecastCollectiveView = collView
        
        
        addSubview(hourForecastCollectiveView)
        hourForecastCollectiveView.dataSource = self
        hourForecastCollectiveView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hourForecastCollectiveView.frame = contentView.bounds
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
