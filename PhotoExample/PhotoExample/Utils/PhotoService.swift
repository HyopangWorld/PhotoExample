//
//  PhotoService.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/15.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import Foundation
import UIKit
import Photos

final class PhotoService {
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    public static let shard: PhotoService = PhotoService()
    
    func requestPhotoAccept(completionHandler: @escaping (Bool) -> Void) {
        let photoAuthoizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthoizationStatus {
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .denied:
                    print("사용자 접근 거부")
                    completionHandler(false)
                case .authorized:
                    print("사용자 접근 허가")
                    completionHandler(true)
                default: break
                }
            })
        case .restricted, .denied:
            print("접근 제한")
            completionHandler(false)
        case .authorized:
            print("접근 허가")
            completionHandler(true)
        default:
            break
        }
    }
    
    func getAlbumCollection() -> PHFetchResult<PHAssetCollection>? {
        return PHAssetCollection.fetchAssetCollections(with: .album, subtype: .smartAlbumUserLibrary, options: nil)
    }
    
    func getPhotoCollection(index: Int) -> PHFetchResult<PHAsset>? {
        let cameraRoll: PHFetchResult<PHAssetCollection>? = self.getAlbumCollection()
        
        guard let cameraRollCollection = cameraRoll?.object(at: index) else {
            return nil
        }
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        return PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOption)
    }
}
