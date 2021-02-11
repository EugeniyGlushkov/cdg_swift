//
//  TaskTableViewCell.swift
//  cdg_swift
//
//  Created by evgen on 11.02.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var topLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
