//
//  GalaxyMarketTableViewController.swift
//  GalaxyMarket
//
//  Created by Ozan Asan on 25/05/15.
//  Copyright (c) 2015 OzanAsan. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class GalaxyMarketTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    
    // For the locations...
    let beaconUUID = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
    let major :CLBeaconMajorValue = 47811
    let regionidentifier = "one"
    let mylocationmanager = CLLocationManager()
    let regionOne = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), major: 47811, identifier: "one")
    
    var GalaxyItems : [GalaxyItem] = []
    
    var immediateEntranceCount = 0 {
        didSet {
            didSetThisEntrance = true
            if(immediateEntranceCount == 3){
                immediateEntranceCount = 0
                rangeCountInImmediate = 0
                takeActionForRange()
            }
        }
    }
    
    var didSetThisEntrance = false
    
    var rangeCountInImmediate = 0 {
        didSet {
            
        }
    }
    
    func resetRanging(){
        immediateEntranceCount = 0
        rangeCountInImmediate = 0
        self.mylocationmanager.stopRangingBeaconsInRegion(regionOne)
        
    }
    
    func takeActionForRange() {
        if(UIApplication.sharedApplication().applicationState == UIApplicationState.Background) {
            println("you are in the background and you have to fire an notification!!!")
            fireNotification()
        }
        
        else if(UIApplication.sharedApplication().applicationState == UIApplicationState.Active) {
            println("you are in foregorund and you have to segue!!!")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        
        
        
        self.GalaxyItems = GetGalaxyItems()
        
        
    }
    
    func configureLocationManager() {
        self.mylocationmanager.delegate = self
        regionOne.notifyEntryStateOnDisplay = true
        mylocationmanager.requestAlwaysAuthorization()
        
        if(CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways){
            mylocationmanager.requestWhenInUseAuthorization()
        }
        
        mylocationmanager.requestStateForRegion(regionOne)
    }
    
    func updateUI() {
        self.tableView.reloadData()
    }

    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        println("did range for beacons?")
        
        if(beacons.count > 0){
            var beacon = beacons[0] as! CLBeacon
            
            if(region.identifier == regionidentifier && beacon.major == NSNumber(unsignedShort : major)){
                if(self.checkProximity(beacon.proximity)){
                    println("beacon.proximity == .Immediate")
                    if(!didSetThisEntrance) {
                        rangeCountInImmediate++
                        println("count is: \(rangeCountInImmediate)")
                        if(rangeCountInImmediate > 1){
                            
                            immediateEntranceCount++
                            
                            println("------level up... immediate entrance count is: \(immediateEntranceCount)")
                        }
                    }
                }
                else {
                    rangeCountInImmediate = 0
                }
            }
        }
    }
    
    private func checkProximity(proximity: CLProximity ) -> Bool {
        if(proximity == .Immediate){
            return true
        }
        else {
            return false;
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, forRegion region: CLRegion!) {
        println("didDetermineState")
        if(region.identifier == regionidentifier) {
            if(state == CLRegionState.Inside){
                println("**in didDetermineState: state == CLRegionState.Inside")
                didSetThisEntrance = false
                self.mylocationmanager.startRangingBeaconsInRegion(regionOne)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.GalaxyItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("galaxycell", forIndexPath: indexPath) as! GalaxyItemCell
        let thisItem = self.GalaxyItems[indexPath.row]

        
        cell.GalaxyItemImageView.image = thisItem.ItemImage
        cell.GalaxyItemTextView.text = thisItem.ItemDescription
        cell.GalaxyItemPriceLabel.text = "\(thisItem.ItemPrice)$"
        

        return cell
    }
    
    let detailSegue = "detailSegue"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == detailSegue) {
            let destinationViewController = segue.destinationViewController as! DetailViewController
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let detail = self.GalaxyItems[indexPath.row] as GalaxyItem
                destinationViewController.DetailItem = detail
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.mylocationmanager.stopRangingBeaconsInRegion(regionOne)
        performSegueWithIdentifier(detailSegue, sender: self)
    }
    
    func fireNotification() {
        let notification = UILocalNotification()
        notification.alertBody = "Are you interested in some Galaxy Items?"
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
}
