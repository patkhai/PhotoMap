//
//  LocationCell.swift
//  PhotoMap
//
//  Created by Pat Khai on 10/4/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
