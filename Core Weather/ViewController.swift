//
//  ViewController.swift
//  Core Weather
//
//  Created by Max Peiros on 9/27/16.
//  Copyright © 2016 Max Peiros. All rights reserved.
//

import UIKit

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
                }
            }
        }
    }
    
    @IBAction func addCity(sender: AnyObject) {
        let alert = UIAlertController(title: "New City", message: "Add a new city", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler(nil)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action) in
            if let text = alert.textFields!.first!.text {
                DataService.instance.saveCity(text)
                self.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func helpPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Welcome to Core Weather!", message: "Press the + button to add a new city. Swipe left on a row to delete.", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
}

