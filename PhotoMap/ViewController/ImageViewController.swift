//
//  ImageViewController.swift
//  PhotoMap
//
//  Created by Pat Khai on 10/4/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    var images : UIImage!
    @IBOutlet weak var imagePhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePhoto.image = images
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
