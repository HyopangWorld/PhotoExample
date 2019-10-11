//
//  PhotoService.swift
//  PhotosExample
//
//  Created by 김효원 on 2019/10/10.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import SwiftUI
import Photos


class PhotoService {
    var imageArray: [UIImage]?
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    fileprivate func requestCollection(){
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
        
        imageArray = Array<UIImage>()
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            for i in 0..<fetchResult.count {
                let asset: PHAsset = fetchResult.object(at: i)
                
                self.imageManager.requestImage(for: asset,
                                          targetSize: CGSize(width:30, height:30),
                                          contentMode: .aspectFill,
                                          options: nil,
                                          resultHandler: { image, _ in
                                            self.imageArray?.append(image!)
                })
            }
        })
        
    }
    
    func requestAuthorization() {
        let photoAuthoiationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthoiationStatus {
        case .authorized:
            print("접근 허가 됨")
            self.requestCollection()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                    case .authorized:
                        print("사용자가 접근 허용함")
                        self.requestCollection()
                    case .denied :
                        print("사용자가 접근 불허함")
                    default: break
                }
            })
        case .restricted:
            print("접근 제한")
        default: break
        }
    }
    
}
