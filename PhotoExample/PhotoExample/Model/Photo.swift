//
//  Photo.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/13.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation
import UIKit

struct Album {
    var title: String?
    var photos: Array<Photo>?
    var image: UIImage?
}

struct Photo {
    var image: UIImage?
    var date: Date?
    var heart: Bool?
}
