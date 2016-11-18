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

class ViewController: UIViewController {

    var myLocations : [Location]?
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try Location.requestAllLocations {
                locations in
                
                self.myLocations = locations
                print(self.myLocations ?? "No locations found")
            }
            
        } catch {}
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

