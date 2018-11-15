//
//  CityTableViewCell.swift
//  Weather Application
//
//  Created by Michael Liu on 2018-01-25.
//  Copyright © 2018 cs2680. All rights reserved.
//

import Foundation
import UIKit

class CityTableViewCell: UITableViewCell
{
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var tempLabel: UILabel!

	@IBOutlet weak var weatherImageView: UIImageView!
	
	func setCity(city: String)
	{
		cityLabel.text = city
        
        if let weatherURL = WeatherURLManager.getCityWeatherURL(city: city)
        {
            let session = URLSession.shared
            
            let task = session.dataTask(with: weatherURL)
            { (data, response, error)  in
                
                if data != nil
                {
                    // Load Temperature
                    let weatherData = JSON(data: data!)
                    
                    let tempValue = weatherData["main"]["temp"].intValue
                    
                    self.loadIcon(weatherData: weatherData)
                    
                    print(tempValue)
                    
                    DispatchQueue.main.async
                        {    self.tempLabel.text = "\(tempValue)º"
                    }
                }
                
            }
            
            task.resume()
        }
	}
    func loadIcon(weatherData: JSON)
    {
        let weatherArray = weatherData["weather"].arrayValue
        let iconCode = weatherArray[0]["icon"].stringValue
        
        print(iconCode)
        
        if let iconURL = WeatherURLManager.getWeatherIconURL(iconCode: iconCode)
        {
            let session = URLSession.shared
            
            let task = session.dataTask(with: iconURL)
            { (data, response, error) -> Void in
                
                if data != nil
                {
                    DispatchQueue.main.async
                        {    self.weatherImageView.image = UIImage(data: data!)
                    }
                }
            }
            
            task.resume()
        }
    }
    
}
