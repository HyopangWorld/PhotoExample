//
//  PhotoService.swift
//  PhotosExample
//
//  Created by 김효원 on 2019/10/10.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation
import Photos

protocol PhotoService {
    func requestImage()
}

class PhotoServiceImpl: PhotoService {
    var fetchResult: PHFetchResult<PHAsset>!
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    func requestImage(){
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
}
