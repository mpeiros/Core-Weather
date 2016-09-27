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
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") {
            
            let city = DataService.instance.cities[indexPath.row]
            
            cell.textLabel!.text = city.cityName
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let city = DataService.instance.cities[indexPath.row]
        
        performSegueWithIdentifier(SEGUE_SHOW_DETAIL, sender: city)
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

}

