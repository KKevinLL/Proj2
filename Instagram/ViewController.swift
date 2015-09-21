//
//  ViewController.swift
//  Instagram
//
//  Created by Boran Liu on 9/19/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var users: [InstagramModel.User] = []
    
    override func viewDidLoad() {
        var id = "399380794"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        InstagramModel().fetchUserDetails (id, callback: {(user: InstagramModel.User) -> Void in
            self.users.append(user)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

