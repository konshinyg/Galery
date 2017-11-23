//
//  TableViewCell.swift
//  Galery
//
//  Created by Core on 22.11.17.
//  Copyright © 2017 Cornelius. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var photoPreviewImage: UIImageView!
    @IBOutlet weak var photoNameLabel: UILabel!
    @IBOutlet weak var photoSizeLabel: UILabel!    
    @IBOutlet weak var photoHashLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
