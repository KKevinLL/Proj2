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
    
    var tapped = false
    var id = ""

    @IBOutlet var userphoto: UIImageView!
    @IBOutlet var Following: UILabel!
    @IBOutlet var Followers: UILabel!
    @IBOutlet var Posts: UILabel!
    @IBOutlet var UserView: UIView!
    
    func refresh(sender:AnyObject)
    {
        if tapped == true {
            fetchUserInterface()
        }
        else {
            fetchPopularMediaInterface()
        }
        self.refreshControl?.endRefreshing()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleHeader()
        if tapped == true {
            fetchUserInterface()
        }
        else {
            fetchPopularMediaInterface()
        }
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
    }

    func fetchUserInterface()
    {
        InstagramModel().fetchUserDetails(self.id, callback:
            {user in
                self.title = user.username
                self.Posts.text = user.posts
                self.Followers.text = user.followers
                self.Following.text = user.follows
                if let url = NSURL(string: user.avatarURL) {
                    if let data = NSData(contentsOfURL: url) {
                        if let avatarSquare = UIImage(data:data) {
                            self.userphoto.layer.cornerRadius = self.userphoto.frame.size.width / 2
                            self.userphoto.clipsToBounds = true
                            self.userphoto.image = avatarSquare
                        }
                    }
                }
        })
        InstagramModel().fetchUserMediaDetails(self.id, callback:
            {(media: [InstagramModel.Media]) -> Void in
                self.medias = media
                self.tableView.reloadData()
        })
    }
    
    func fetchPopularMediaInterface()
    {
        InstagramModel().fetchPopularMediaDetails{(media: [InstagramModel.Media]) -> Void in
            self.medias = media
            self.tableView.reloadData()
        }
    }
    
    func toggleHeader()
    {
        if self.tapped == true
        { tableView.tableHeaderView = self.UserView }
        else
        { tableView.tableHeaderView = nil }
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
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("MediaCell", forIndexPath: indexPath) as! MediaCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let current = medias[indexPath.section]
            cell.media = current
            return cell
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CommentsCell", forIndexPath: indexPath) as! CommentsCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let current = medias[indexPath.section].comments[indexPath.row - 1]
            cell.comment = current
            return cell

        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UserView"{
            let dest = segue.destinationViewController as! InstaTableViewController
            dest.tapped = true
            let currentCell = sender?.view as? UserInfoCell
            let selectedUser = currentCell?.header
            dest.id = (selectedUser?.user_id)!
        }
    }
    

}
