//
//  AlbumViewModel.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/14.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation
import Photos

protocol PhotoViewModelProtocol {
    var albumCollection: PHFetchResult<PHAssetCollection>? { get set }
    var fetchResultDidChange: ((PhotoViewModelProtocol) -> ())? { get set }
}

class PhotoViewModel: PhotoViewModelProtocol {
    var albumCollection: PHFetchResult<PHAssetCollection>? {
        didSet{
            self.fetchResultDidChange?(self)
        }
    }
//    var photo: PHFetchResult<PHAsset>? {
//        didSet{
//            self.fetchResultDidChange?(self)
//        }
//    }
    
    var fetchResultDidChange: ((PhotoViewModelProtocol) -> ())?

}

