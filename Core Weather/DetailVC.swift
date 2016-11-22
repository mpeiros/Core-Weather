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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var city: City!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = city.cityName
        
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        city.downloadWeather {
            self.updateUI()
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetUI()
    }
    
    func updateUI() {
        if let imgName = city.imageName {
            weatherImageView.image = UIImage(named: imgName)
            weatherImageView.hidden = false
        }
        
        weatherDescriptionLabel.text = city.weatherDescription
        weatherDescriptionLabel.hidden = false
        temperatureLabel.text = city.temperature
        temperatureLabel.hidden = false
        humidityLabel.text = city.humidity
        humidityLabel.hidden = false
        windSpeedLabel.text = city.windSpeed
        windSpeedLabel.hidden = false
    }
    
    func resetUI() {
        weatherImageView.hidden = true
        weatherDescriptionLabel.hidden = true
        temperatureLabel.hidden = true
        humidityLabel.hidden = true
        windSpeedLabel.hidden = true
    }
    
}
