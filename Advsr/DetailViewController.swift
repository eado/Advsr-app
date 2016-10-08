//
//  DetailViewController.swift
//  Advsr
//
//  Created by Omar Elamri on 10/5/16.
//  Copyright © 2016 Omar Elamri. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!


    func configureView() {
        // Update the user interface for the detail item.
        if let post = self.post {
            questionLabel.text = post.question
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let post = self.post {
            guard let comments = post.comments else {
                return 0
            }
            return comments.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! DetailViewCell
        cell.commentLabel.text = post?.comments![indexPath.row].value
        return cell
    }
    
    @IBAction func addComment() {
        let alert = UIAlertController(title: "Add a comment", message: "Type in your comment below.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Comment"
        }
        
        alert.addAction(
            UIAlertAction(title: "Add Comment!", style: .default) { action in
                let value = alert.textFields![0].text
                self.ref.child("posts/\(self.post!.postid)/comments").childByAutoId().setValue(value)
            }
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if post == nil {
            view.isHidden = true
        }
        // Do any additional setup after loading the view, typically from a nib.
        ref = FIRDatabase.database().reference()
        commentTableView.dataSource = self
        commentTableView.delegate = self
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var post: Post?


}

