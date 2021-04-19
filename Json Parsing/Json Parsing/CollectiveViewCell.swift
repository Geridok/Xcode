//
//  CollectiveViewCell.swift
//  Json Parsing
//
//  Created by Vladimir Mustafin on 27.03.2021.
//

import Foundation
import UIKit
import Spring

class CollectiveViewCell:  UICollectionViewCell{
    static let identifier = "CollectiveViewCell"
    
    private let weatherIcon: SpringImageView = {
        let icon = SpringImageView()
        return icon
    }()
    private let tempLabel: SpringLabel = {
       let label = SpringLabel()
        return label
    }()
    private let timeLabel: SpringLabel = {
        let label = SpringLabel()
         return label
    }()
    
    public func configure(info: HourlyWeather){
        contentView.addSubview(weatherIcon)
        contentView.addSubview(tempLabel)
        contentView.addSubview(timeLabel)
        weatherIcon.image = info.weatherIcon
        tempLabel.text = info.tempText
        timeLabel.text = info.timeText
        for label in [timeLabel,tempLabel] {
            label.textAlignment = .center
        }
        weatherIcon.contentMode = .scaleAspectFill
        self.backgroundColor = UIColor(hex: "AAFEFF")
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true

//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 0.5
//        self.layer.masksToBounds = false
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        weatherIcon.frame = CGRect(x: contentView.frame.width/2 - 25, y: 30, width: 50, height: 50)
        tempLabel.frame = CGRect(x: contentView.frame.width/2 - contentView.frame.width/4, y: 90, width: contentView.bounds.width/2, height: 20)
        timeLabel.frame = CGRect(x: 0, y: 5, width: contentView.bounds.width, height: 20)
        
    }
}
