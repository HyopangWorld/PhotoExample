//
//  PHUtils.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/16.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation
import UIKit

class PHUtils {
    
    // MARK: - 이미지 리사이징
    func resizeImage(w: CGFloat, h: CGFloat, image: UIImage) -> UIImage {
        var new_image = UIImage()
        let size = CGSize(width: w, height: h)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: rect)
        new_image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return new_image
    }
}
