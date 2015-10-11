//
//  UserInfoCell.swift
//  Instagram
//
//  Created by Boran Liu on 9/26/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import UIKit
import DateTools

class UserInfoCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    var Date: NSDate = NSDate()
    
    var header: InstagramModel.Media? {
        didSet {
            if let setHeader = header {
                let name = "  " + setHeader.username
                let attributedString = NSMutableAttributedString(string:name)
                let range = (name as NSString).rangeOfString(name)
                let color = UIColor(red: 0.07, green: 0.34, blue: 0.53, alpha: 1.0)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
                userName.attributedText = attributedString

                // try to convert the unix timestamp to actual time but seems not work properly...
                let doubleTime = Double(setHeader.date)
                let date = NSDate(timeIntervalSince1970: doubleTime!)
                let timePassed = Date.shortTimeAgoSinceDate(date)
               // let format = NSDateFormatter()
                //format.dateFormat = "yyyy-MM-dd hh:MM:ss"
                //postDate.text = format.stringFromDate(NSDate(timeIntervalSince1970:doubleTime!))
//                postDate.text = setHeader.date
                postDate.text = timePassed
                
                if let url = NSURL(string: setHeader.avatarURL) {
                    if let data = NSData(contentsOfURL: url) {
                        if let avatarSquare = UIImage(data:data) {
                            userPhoto.layer.cornerRadius = userPhoto.frame.size.width / 2
                            userPhoto.clipsToBounds = true
                            userPhoto.image = avatarSquare
                        }
                    }
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
}
