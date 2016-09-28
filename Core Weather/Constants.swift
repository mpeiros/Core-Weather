//
//  Constants.swift
//  Core Weather
//
//  Created by Max Peiros on 9/27/16.
//  Copyright © 2016 Max Peiros. All rights reserved.
//

import Foundation

// API URL's
let WEATHER_URL_START = "http://api.openweathermap.org/data/2.5/weather?q="
let WEATHER_URL_END = "&units=imperial&appid=3d6f679b377e4b4c9ded52dc4d1f046f"

// CoreData Entity
let CITY_ENTITY = "City"

// Segues
let SEGUE_SHOW_DETAIL = "showDetail"

// Reuse Identifier
let REUSE_IDENTIFIER = "CityCell"

// Download helper
typealias DownloadComplete = () -> ()
