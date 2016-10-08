//
//  MasterViewController.swift
//  Advsr
//
//  Created by Omar Elamri on 10/5/16.
//  Copyright © 2016 Omar Elamri. All rights reserved.
//

import UIKit
import Firebase

class MasterViewController: UITableViewController {

    var ref: FIRDatabaseReference!
    
    var detailViewController: DetailViewController? = nil
    var posts = [Post]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Advsr"
        ref = FIRDatabase.database().reference()
        let postsQuery = ref.child("posts").queryOrdered(byChild: "date")
        
        postsQuery.observe(.value) { (data: FIRDataSnapshot) -> Void in
            self.posts = Post.getBatchPosts(wholeSnapshot: data).reversed()
            self.tableView.reloadData()
        }
        

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPost))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    func addPost() {
        let alert = UIAlertController(title: "Ask a Question", message: "Type in your question below.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Question"
        }
        
        alert.addAction(
            UIAlertAction(title: "Ask!", style: .default) { action in
                let value = ["question": alert.textFields![0].text!, "comments": [:]] as [String : Any]
                self.ref.child("posts").childByAutoId().setValue(value)
            }
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let post = posts[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.post = post
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MasterViewCell
        let post = posts[indexPath.row]
        cell.post = post
        cell.questionTitle.text = post.question
        
        return cell
    }


}

