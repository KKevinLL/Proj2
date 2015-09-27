//
//  CommentsCell.swift
//  Instagram
//
//  Created by Boran Liu on 9/26/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import UIKit


//Currently this class is not being used...

class CommentsCell: UITableViewCell {


    
    @IBOutlet weak var comments: UILabel!
    var comment: InstagramModel.Comments? {
        didSet {
            if let setComment = comment {
                let line = setComment.username + ": " + setComment.content
                let attributedString = NSMutableAttributedString(string:line)
                let range = (line as NSString).rangeOfString(setComment.username)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: range)
                comments.attributedText = attributedString
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
