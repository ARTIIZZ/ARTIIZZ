//
//  ProductTableViewCell.swift
//  ARTIIZZ
//
//  Created by Djason  Sylvaince on 12/17/18.
//  Copyright © 2018 Sandyna Sandaire. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var imgproduct: UIImageView!
    
    @IBOutlet weak var titleproduct: UILabel!
    @IBOutlet weak var descproduct: UILabel!
    @IBOutlet weak var artistproduct: UILabel!
    @IBOutlet weak var dateproduct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
