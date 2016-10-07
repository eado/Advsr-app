//
//  DetailViewController.swift
//  Advsr
//
//  Created by Omar Elamri on 10/5/16.
//  Copyright © 2016 Omar Elamri. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
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
            //return post.comments.count
            return 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment") as! DetailViewCell
        // cell.commentLabel.text = post?.comments[indexPath.row].value
        return cell
    }
    
    @IBAction func addComment() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if post == nil {
            view.isHidden = true
        }
        // Do any additional setup after loading the view, typically from a nib.
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

