//
//  CommentsTableViewCell.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 16/02/23.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
