//
//  UserInfoCell.swift
//  Instagram
//
//  Created by Boran Liu on 9/26/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import UIKit
import DateTools
protocol UserInfoCellDelegate{
    func cellDidGetTapped(cell:UserInfoCell)
}

class UserInfoCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    var Date: NSDate = NSDate()
    var delegate: UserInfoCellDelegate?
    
    var header: InstagramModel.Media? {
        didSet {
            if let setHeader = header {
                let name = "  " + setHeader.user.username
                let attributedString = NSMutableAttributedString(string:name)
                let range = (name as NSString).rangeOfString(name)
                let color = UIColor(red: 0.07, green: 0.34, blue: 0.53, alpha: 1.0)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
                userName.attributedText = attributedString

                let doubleTime = Double(setHeader.date)
                let date = NSDate(timeIntervalSince1970: doubleTime!)
                let timePassed = Date.shortTimeAgoSinceDate(date)
                postDate.text = timePassed
                self.userPhoto.setImageWithURL(NSURL(string: setHeader.user.avatarURL)!)
                userPhoto.layer.cornerRadius = userPhoto.frame.size.width / 2
                userPhoto.clipsToBounds = true
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let recognizer = UITapGestureRecognizer(target: self, action: "onTap")
        self.addGestureRecognizer(recognizer)
    }
    
    func onTap() {
        delegate?.cellDidGetTapped(self)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        // Configure the view for the selected state
    }
    
}
