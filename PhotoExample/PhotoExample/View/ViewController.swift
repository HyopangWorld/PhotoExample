//
//  ViewController.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/13.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    var fetchResult: PHFetchResult<PHAsset>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestPhotoAccept()
    }
    
    func requestPhotoAccept(){
        let photoAuthoizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthoizationStatus {
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .denied:
                    print("사용자 접근 거부")
                case .authorized:
                    print("사용자 접근 허가")
                    self.requestCollection()
                default: break
                }
            })
        case .restricted:
            print("접근 제한")
        case .denied:
            print("접근 거부")
        case .authorized:
            print("접근 허가")
            requestCollection()
        default:
            break
        }
    }
    
    func requestCollection(){
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOption)
    }
}

