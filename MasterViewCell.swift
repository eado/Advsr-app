//
//  MasterViewCell.swift
//  Advsr
//
//  Created by Omar Elamri on 10/5/16.
//  Copyright © 2016 Omar Elamri. All rights reserved.
//

import UIKit

class MasterViewCell: UITableViewCell {

    @IBOutlet weak var questionTitle: UILabel!
    
    var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
