//
//  DetailVC.swift
//  Core Weather
//
//  Created by Max Peiros on 9/27/16.
//  Copyright © 2016 Max Peiros. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var city: City!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = city.cityName
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        city.downloadWeather {
            self.updateUI()
        }
    }
    
    func updateUI() {
        weatherImageView.image = UIImage(named: city.imageName!)
        weatherDescriptionLabel.text = city.weatherDescription
        temperatureLabel.text = city.temperature
        humidityLabel.text = city.humidity
        windSpeedLabel.text = city.windSpeed
    }
    
}
