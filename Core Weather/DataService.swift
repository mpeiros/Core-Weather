//
//  DataService.swift
//  Core Weather
//
//  Created by Max Peiros on 9/27/16.
//  Copyright © 2016 Max Peiros. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Alamofire

class DataService {
    
    static let instance = DataService()
    
    private var _cities = [City]()
    
    var cities: [City] {
        return _cities
    }
    
    func checkValidCity(name: String, completion: Bool -> ()) {
        let nameString = name.stringByReplacingOccurrencesOfString(" ", withString: "")
        let urlString = WEATHER_URL_START + nameString + WEATHER_URL_END
        
        let url = NSURL(string: urlString)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let statusCode = dict["cod"] as? String {
                    
                    if statusCode == "404" || statusCode == "502" {
                        completion(false)
                    }
                    
                } else {
                    completion(true)
                }
            }
        }
    }
    
    func saveCity(name: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName(CITY_ENTITY, inManagedObjectContext: managedObjectContext)
        let city = City(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        city.cityName = name
        
        managedObjectContext.insertObject(city)
        
        do {
            try managedObjectContext.save()
            _cities.append(city)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func deleteCity(city: City) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        managedObjectContext.deleteObject(city)
        
        do {
            try managedObjectContext.save()
            
            if let index = _cities.indexOf(city) {
                _cities.removeAtIndex(index)
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func fetchCities() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: CITY_ENTITY)
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            _cities = results as! [City]
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
}
