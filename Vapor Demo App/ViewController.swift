//
//  ViewController.swift
//  Vapor Demo App
//
//  Created by Timothy Barraclough on 17/11/16.
//
//

import UIKit
import Alamofire
import Vapor

class ViewController: UITableViewController {

    var myLocations : [Location]?
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try Location.requestAllLocations {
                
                locations in
                
                self.myLocations = locations
                self.tableView.reloadData()
                print(self.myLocations ?? "No locations found")
            }
            
        } catch {}
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let location = myLocations?[indexPath.row]
        cell.textLabel?.text = "Longitude : \(location?.longitude)"
        cell.detailTextLabel?.text = "Latitude : \(location?.longitude)"
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLocations?.count ?? 0
    }


}

