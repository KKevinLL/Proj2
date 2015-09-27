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
                likes.text = "❤️ " + String(setMedia.likes) + " likes"
                if let url = NSURL(string: setMedia.mediaURL) {
                    if let data = NSData(contentsOfURL: url) {
                        if let avatarSquare = UIImage(data:data) {
                            Photo.image = avatarSquare
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
