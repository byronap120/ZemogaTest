//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageFavorite: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
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
