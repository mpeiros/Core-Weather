//
//  City.swift
//  
//
//  Created by Max Peiros on 9/27/16.
//
//

import Foundation
import CoreData
import Alamofire

class City: NSManagedObject {
    
    func downloadWeather(completed: DownloadComplete) {
        
        let url = NSURL(string: WEATHER_URL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let mainDict = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let temp = mainDict["temp"] as? Double {
                        self.temperature = "\(temp)"
                    }
                    
                    if let humid = mainDict["humidity"] as? Double {
                        self.humidity = "\(humid)"
                    }
                }
                
                if let windDict = dict["wind"] as? Dictionary<String, AnyObject> {
                    
                    if let windSpd = windDict["speed"] as? Double {
                        self.windSpeed = "\(windSpd)"
                    }
                }
                
                if let weatherDictArray = dict["weather"] as? [Dictionary<String, AnyObject>] where weatherDictArray.count > 0 {
                    
                    if let desc = weatherDictArray[0]["description"] as? String {
                        self.weatherDescription = desc.capitalizedString
                    }
                    
                    if let icon = weatherDictArray[0]["icon"] as? String {
                        self.imageName = icon
                    }
                }
            }
            
            completed()
        }
    }
    
}
