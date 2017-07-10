//
//  ImgViewController.swift
//  PhotoViewer_sample
//
//  Created by 鳥居隆弘 on 2017/07/07.
//  Copyright © 2017年 鳥居隆弘. All rights reserved.
//

import UIKit
import SDWebImage

class ImgViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var backImgView: UIImageView!
    
    var flickrPhoto: FlickrPhoto!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        print(flickrPhoto)
        backImgView.sd_setImage(with: flickrPhoto.photoUrl as URL!)
        imgView.sd_setImage(with: flickrPhoto.photoUrl as URL!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
