//
//  GallerieTableViewCell.swift
//  ARTIIZZ
//
//  Created by Djason  Sylvaince on 12/18/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit

class GallerieTableViewCell: UITableViewCell {
    @IBOutlet weak var galleriename: UILabel!
    @IBOutlet weak var gallerieadr: UILabel!
    @IBOutlet weak var openhours: UILabel!
    @IBOutlet weak var closehours: UILabel!
    @IBOutlet weak var openinghours: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
