//
//  FlickrPhoto.swift
//  PhotoViewer_sample
//
//  Created by 鳥居隆弘 on 2017/07/07.
//  Copyright © 2017年 鳥居隆弘. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhoto {
    
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret).jpg")!
    }
    
}

