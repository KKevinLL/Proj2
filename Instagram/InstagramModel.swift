//
//  InstagramModel.swift
//  Instagram
//
//  Created by Boran Liu on 9/19/15.
//  Copyright © 2015 Boran Liu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class InstagramModel {
    
    struct User {
        let avatarURL: String
        let username: String
        let bio: String
        let posts: String
        let followers: String
        let follows: String
    }
    
    struct Media {
        let date: String
        let avatarURL: String
        let username: String
        let user_id: String
        let mediaURL: String
        let likes: Int
        let caption: String
        let comments: [Comments]
    }
    

    struct Comments {
        let username: String
        let content:String
    }
    
    public init() {
        
    }
    
    
    func fetchUserDetails(id: String, callback: (User) -> Void) {
        Alamofire.request(.GET, "https://api.instagram.com/v1/users/" + id + "/?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { _, _, jsonObj in
                self.populateUserInfoWith(jsonObj.value!, callback: callback)
        }
    }
    
    
    func populateUserInfoWith(data: AnyObject?, callback: (User) -> Void) {
        let json = JSON(data!)["data"]
        callback(User(avatarURL: json["profile_picture"].stringValue,
            username: json["username"].stringValue, bio:
            json["bio"].stringValue, posts: json["counts"]["media"].stringValue,
            followers: json["counts"]["followed_by"].stringValue, follows: json["counts"]["follows"].stringValue))
    }
    
    func fetchUserMediaDetails(id: String, callback: ([Media]) -> Void) {
        Alamofire.request(.GET, "https://api.instagram.com/v1/users/" + id + "/media/recent/?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { _, _, jsonObj in
                self.populateMediaWith(jsonObj.value!, callback: callback)
        }
    }
    
    func populateMediaWith(data: AnyObject?, callback: ([Media]) -> Void) {
        let json = JSON(data!)
        var medias = [Media]()
        for media in json["data"].arrayValue {
            var curComments:[Comments] = []
            for comment in media["comments"]["data"].arrayValue{
                curComments.append(Comments(username: comment["from"]["username"].stringValue, content: comment["text"].stringValue))
            }
            medias.append(Media(date: media["created_time"].stringValue, avatarURL: media["user"]["profile_picture"].stringValue, username: media["user"]["username"].stringValue,
                user_id: media["user"]["id"].stringValue, mediaURL: media["images"]["standard_resolution"]["url"].stringValue, likes: media["likes"]["count"].intValue, caption: media["caption"]["text"].stringValue,comments: curComments))
        }
        
        callback(medias)
    }
    
    func fetchPopularMediaDetails(callback: ([Media]) -> Void) {
        Alamofire.request(.GET, "https://api.instagram.com/v1/media/popular?client_id=c953ffadb974463f9f6813fc4fc91673")
            .responseJSON { _, _, jsonObj in
                self.populateMediaWith(jsonObj.value!, callback: callback)
        }
    }
    
}

