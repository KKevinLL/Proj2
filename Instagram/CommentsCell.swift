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
                let range1 = (line as NSString).rangeOfString(setComment.username)
                let range2 = (line as NSString).rangeOfString(setComment.content)
                let color1 = UIColor(red: 0.07, green: 0.34, blue: 0.53, alpha: 1.0)
                let color2 = UIColor(red: 0.82, green: 0.82, blue: 0.82, alpha: 1.0)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color1, range: range1)
                attributedString.addAttribute(NSForegroundColorAttributeName, value: color2, range: range2)
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

//extension UIColor {
//    convenience init(red: Int, green: Int, blue: Int) {
//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
//        
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//    
//    convenience init(netHex:Int) {
//        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
//    }
//}
