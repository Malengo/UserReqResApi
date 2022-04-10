//
//  CellTableViewCell.swift
//  UsersApi
//
//  Created by user213590 on 4/6/22.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var lastText: UILabel!
    @IBOutlet weak var firstText: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
