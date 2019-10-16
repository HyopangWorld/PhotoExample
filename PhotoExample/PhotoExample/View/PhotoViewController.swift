//
//  PhotoViewController.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/16.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit
import Photos

class PhotoViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var notiLabel: UILabel!
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var selectBtn: UIBarButtonItem!
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var chronoBtn: UIBarButtonItem!
    @IBOutlet weak var trashBtn: UIBarButtonItem!
    
    var photos: PHFetchResult<PHAsset>?
    var selectIndex: Int?
    
    let PHOTO_SPACING: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView(){
        guard photos != nil else {
            notiLabel.isHidden = false
            return
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func shardPhoto(){
        
    }
    
    func chronogicalPhoto(){
        
    }
    
    func removePhoto(){
        
    }
}


extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let photos = photos else {
            return 0
        }
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        let imageWidth = cell.frame.width
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageWidth))
        
        if let asset = photos?.object(at: indexPath.row) {
            PhotoService.shard.imageManager.requestImage(for: asset,
                                                         targetSize: CGSize(width: imageWidth, height: imageWidth),
                                                         contentMode: .aspectFill,
                                                         options: nil,
                                                         resultHandler: { image, _ in
                                                         imageView.image = PHUtils().resizeImage(w: imageWidth, h: imageWidth, image: image!)
            })
        }
        else {
            guard let defaultImage = UIImage(named: "Icon-40.png") else {
                return cell
            }
            imageView.image = PHUtils().resizeImage(w: imageWidth, h: imageWidth, image: defaultImage)
        }
        
        cell.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex = indexPath.row
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: PHOTO_SPACING, left: PHOTO_SPACING, bottom: PHOTO_SPACING, right: PHOTO_SPACING)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return PHOTO_SPACING
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSizeWidth = (view.frame.width - PHOTO_SPACING*3) / 3
        return CGSize(width: cellSizeWidth, height: cellSizeWidth)
    }
}
