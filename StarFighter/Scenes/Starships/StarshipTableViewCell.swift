//
//  StarshipTableViewCell.swift
//  StarFighter
//
//  Created by Fabiana Montiel on 05/01/2020.
//  Copyright © 2020 StarFighter. All rights reserved.
//

import UIKit

class StarshipTableViewCell: UITableViewCell {

    @IBOutlet var starshipName: UILabel!
    @IBOutlet var damage: UILabel!
    @IBOutlet var starshipImage: UIImageView!
    @IBAction func playButton(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
