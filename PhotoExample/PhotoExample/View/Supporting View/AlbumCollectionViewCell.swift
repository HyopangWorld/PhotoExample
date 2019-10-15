//
//  AlbumCollectionViewCell.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/15.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var count: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = nil
        count.text = nil
    }
}
