//
//  Post.swift
//  Advsr
//
//  Created by Omar Elamri on 10/6/16.
//  Copyright © 2016 Omar Elamri. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    let postid: String
    let question: String
    let comments: [(key: String, value: String)]?
    
    init(snapshot: FIRDataSnapshot) {
        let value = snapshot.value! as! [String: AnyObject]
        postid = snapshot.key
        question = value["question"] as! String
        let commentsDict = value["comments"] as? [String: String]
        if let commentsDict = commentsDict {
            var array = [(key: String, value: String)]()
            for value in commentsDict {
                array.append(value)
            }
            comments = array
        } else {
            comments = nil
        }
        
    }
    
    static func getBatchPosts(wholeSnapshot: FIRDataSnapshot) -> [Post]{
        var array = [Post]()
        for post in wholeSnapshot.children {
            array.append(Post(snapshot: post as! FIRDataSnapshot))
        }
        return array
    }
}
