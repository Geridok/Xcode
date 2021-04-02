//
//  ViewController.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 23.03.2021.
//

import UIKit
import Spring


protocol StubDelegate {
    func changePlaceName(place: String)
    func changeParseType()
}

class WeatherViewController: UIViewController {
    
    //View & stackView	
    private let topView: CurrentWeatherInfoView = {
        let view = CurrentWeatherInfoView.loadFromXib()
        return view
    }()
    var currentWeather: CurrentWeather!
    
    var hourlyWeather: [HourlyWeather] = []
    
    var dayInfo: [DayInfo] = []
    
    
    var stubDelegate: StubDelegate?
    var currentPlaceName: String?
    
    //table
    private let tableView: UITableView = {
       let table = UITableView()
        
        table.register(CollectiveTableViewCell.self, forCellReuseIdentifier: CollectiveTableViewCell.identifier)
        table.register(DailyTableViewCell.nib(), forCellReuseIdentifier: DailyTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let instance = Singleton.placesInfo
        
        let window = UIApplication.shared.windows[0]
        topView.frame = CGRect(x: 0, y: window.safeAreaInsets.top, width: view.frame.width, height: 250)
        topView.delegate = self
        
        topView.configure(cities: instance.getMostPopularCountries(),currentWeather: currentWeather)
        if let index = instance.getMostPopularCountries().firstIndex(of: currentPlaceName ?? "Moscow"){
            topView.placePicker.selectRow(index, inComponent: 0, animated: true)
        }
        
        view.addSubview(topView)
        

        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = CGRect(x: view.bounds.origin.x, y: window.safeAreaInsets.top + 250, width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.frame.height - (window.safeAreaInsets.top + 250))
        
        
        view.addSubview(tableView)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
         let tabBarIndex = tabBarController.selectedIndex
         if tabBarIndex == 0 {
             print(" Selected 0")
         }else{
            print(" selected 1")
         }
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + dayInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectiveTableViewCell.identifier, for: indexPath) as! CollectiveTableViewCell
            
            cell.configure(weatherInfo: hourlyWeather)
            
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
            cell.configure(dayWheatherInfo: dayInfo[indexPath.row - 1] )
            cell.selectionStyle = . none
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110
        } else {
            return 50
        }
    }
    
    
}

extension WeatherViewController: CurrentWeatherInfoDelegate{
    func changeParseType() {
        stubDelegate?.changeParseType()
        
        dismiss(animated: true, completion: nil)
    }
    
    func setNewCity(newCity: String) {
        stubDelegate?.changePlaceName(place: newCity)
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
