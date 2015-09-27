//
//  InstaTableViewController.swift
//  Instagram
//
//  Created by Boran Liu on 9/26/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import UIKit

class InstaTableViewController: UITableViewController {

    var medias:[InstagramModel.Media] = []
    
    func refresh(sender:AnyObject)
    {
        InstagramModel().fetchPopularMediaDetails{(media: [InstagramModel.Media]) -> Void in
            self.medias = media
            self.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        InstagramModel().fetchPopularMediaDetails{(media: [InstagramModel.Media]) -> Void in
            self.medias = media
            self.tableView.reloadData()
        }
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return medias.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return medias[section].comments.count + 1
    }

    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserInfoCell") as! UserInfoCell
        let current = medias[section]
        cell.header = current
        return cell
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            tableView.rowHeight = 600
            let cell = tableView.dequeueReusableCellWithIdentifier("MediaCell", forIndexPath: indexPath) as! MediaCell
            let current = medias[indexPath.section]
            cell.media = current
            return cell
        }else {
            tableView.rowHeight = 20
            tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentsCell", forIndexPath: indexPath) as! CommentsCell
            let current = medias[indexPath.section].comments[indexPath.row - 1]
            cell.comment = current
            return cell

        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
