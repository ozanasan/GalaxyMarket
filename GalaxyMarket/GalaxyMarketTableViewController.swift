//
//  GalaxyMarketTableViewController.swift
//  GalaxyMarket
//
//  Created by Ozan Asan on 25/05/15.
//  Copyright (c) 2015 OzanAsan. All rights reserved.
//

import UIKit

class GalaxyMarketTableViewController: UITableViewController {
    
    var GalaxyItems : [GalaxyItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.GalaxyItems = GetGalaxyItems()
        
    }
    
    func updateUI() {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
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
        performSegueWithIdentifier(detailSegue, sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
