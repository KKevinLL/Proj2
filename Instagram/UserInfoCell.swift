//
//  UserInfoCell.swift
//  Instagram
//
//  Created by Boran Liu on 9/26/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    var header: InstagramModel.Media? {
        didSet {
            if let setHeader = header {
                userName.text = setHeader.username

                // try to convert the unix timestamp to actual time but seems not work properly...
//                let doubleTime = Double(setHeader.date)
//                postDate.text = String(NSDate(timeIntervalSince1970:doubleTime!))
                postDate.text = setHeader.date
                
                if let url = NSURL(string: setHeader.avatarURL) {
                    if let data = NSData(contentsOfURL: url) {
                        if let avatarSquare = UIImage(data:data) {
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
