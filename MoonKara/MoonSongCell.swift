//
//  MoonSongCell.swift
//  MoonKara
//
//  Created by JoJo on 5/16/17.
//  Copyright © 2017 JoJo. All rights reserved.
//

import UIKit

class MoonSongCell: UITableViewCell {
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCountView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
