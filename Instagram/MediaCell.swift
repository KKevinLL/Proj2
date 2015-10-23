//
//  MediaCell.swift
//  Instagram
//
//  Created by Boran Liu on 9/26/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {

    
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var Caption: UILabel!
    @IBOutlet weak var Photo: UIImageView!
    
    var media: InstagramModel.Media? {
        didSet {
            if let setMedia = media {
                Caption.text = setMedia.caption
                let line = "❤️ " + String(setMedia.likes) + " likes"
                let attributedString = NSMutableAttributedString(string:line)
                let range = (line as NSString).rangeOfString(line)
                let color = UIColor(red: 0.27, green: 0.56, blue: 1.0, alpha: 1.0)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
                likes.attributedText = attributedString
                self.Photo.setImageWithURL(NSURL(string: setMedia.mediaURL)!)
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
