//
//  PhotoListTableViewCell.swift
//  PhotoViewer_sample
//
//  Created by 鳥居隆弘 on 2017/07/04.
//  Copyright © 2017年 鳥居隆弘. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoListTableViewCell: UITableViewCell {

    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBase: UIView!
    var flickrPhoto :FlickrPhoto!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ImgView.contentMode = .scaleAspectFill
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupWithPhoto(flickrPhoto: FlickrPhoto) {

        let text = flickrPhoto.title + "\n" +
            flickrPhoto.secret + "\n" + flickrPhoto.photoId
        
        self.flickrPhoto = flickrPhoto
        
        ImgView.sd_setImage(with: flickrPhoto.photoUrl as URL!)
        textView.text = text
       
    }
    
    func animateHide(){
    
        UIView.animate(withDuration: 0.6,
                 animations: {
                    self.textViewBase.transform = CGAffineTransform(scaleX: 0, y: 1.0)
        })
    }
    
    func animateApp(){
        
        UIView.animate(withDuration: 0.6,
                       animations: {
                        self.textViewBase.transform = CGAffineTransform.identity
        })
    }
 
}
