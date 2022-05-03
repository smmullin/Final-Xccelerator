//
//  CarPostTableViewCell.swift
//  Xccelerator_New
//
//  Created by Sarah Mullings on 3/28/22.
//

import UIKit

class CarPostTableViewCell: UITableViewCell {

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
