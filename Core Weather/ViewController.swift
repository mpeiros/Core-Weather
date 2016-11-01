//
//  ViewController.swift
//  Core Weather
//
//  Created by Max Peiros on 9/27/16.
//  Copyright © 2016 Max Peiros. All rights reserved.
//

import UIKit
import SCLAlertView

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Core Weather"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        DataService.instance.fetchCities()
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier(REUSE_IDENTIFIER) as? CityCell {
            
            let city = DataService.instance.cities[indexPath.row]
            cell.configureCell(city)
            return cell
            
        } else {
            return CityCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let city = DataService.instance.cities[indexPath.row]
        
        performSegueWithIdentifier(SEGUE_SHOW_DETAIL, sender: city)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            let city = DataService.instance.cities[indexPath.row]
            DataService.instance.deleteCity(city)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_SHOW_DETAIL {
            if let detailVC = segue.destinationViewController as? DetailVC {
                if let city = sender as? City {
                    detailVC.city = city
                    
                    let backItem = UIBarButtonItem()
                    backItem.title = ""
                    navigationItem.backBarButtonItem = backItem
                }
            }
        }
    }
    
    @IBAction func addCity(sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 18)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 12)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 12)!,
            showCloseButton: false
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let textField = alert.addTextField("Enter a city")
        
        alert.addButton("Save") {
            if let text = textField.text {
                DataService.instance.checkValidCity(text, completion: { (valid) in
                    if valid {
                        DataService.instance.saveCity(text)
                        self.tableView.reloadData()
                        SCLAlertView().showSuccess("Success", subTitle: "New city added")
                    } else {
                        SCLAlertView().showError("Error adding new city", subTitle: "Invalid city entered. Please try again.")
                    }
                })
            }
        }
        
        alert.addButton("Cancel") {
            alert.hideView()
        }
        
        alert.showEdit("New City", subTitle: "Add a new city")
    }

    @IBAction func helpPressed(sender: AnyObject) {
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 18)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 12)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 12)!
        )
        
        let alert = SCLAlertView(appearance: appearance)
        alert.showInfo("Welcome to Core Weather!", subTitle: "Press the + button to add a new city. Swipe left on a row to delete it.")
    }
    
}

