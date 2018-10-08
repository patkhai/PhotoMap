//
//  LocationCell.swift
//  PhotoMap
//
//  Created by Pat Khai on 10/4/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import AFNetworking


class LocationCell: UITableViewCell {

    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    
    var location: NSDictionary! {
        didSet {
            storeName.text = location["name"] as? String
            storeAddress.text = location.value(forKeyPath: "location.address") as? String
            
            let categories = location["categories"] as? NSArray
            if (categories != nil && categories!.count > 0) {
                let category = categories![0] as! NSDictionary
                let urlPrefix = category.value(forKeyPath: "icon.prefix") as! String
                let urlSuffix = category.value(forKeyPath: "icon.suffix") as! String
                
                let url = "\(urlPrefix)bg_32\(urlSuffix)"
                photoImage.setImageWith(URL(string: url)!)
            }
        }
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
