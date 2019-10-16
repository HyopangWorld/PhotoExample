//
//  ViewController.swift
//  PhotoExample
//
//  Created by 김효원 on 2019/10/13.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import UIKit
import Photos

class AlbumViewController: UIViewController, PHPhotoLibraryChangeObserver {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var notiLabel: UILabel!
    
    var viewModel: PhotoViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            viewModel.fetchResultDidChange = { [unowned self] viewModel in
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView(){
        viewModel = PhotoViewModel()
        PhotoService.shard.requestPhotoAccept() { result in
            if result {
                self.viewModel?.albumCollection = PhotoService.shard.getAlbumCollection()
                PHPhotoLibrary.shared().register(self)
            }
            else {
                // 허가 받지 못했을 경우
            }
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let viewModel = viewModel, let changes = changeInstance.changeDetails(for: viewModel.albumCollection!) else {
            return
        }
        
        viewModel.albumCollection = changes.fetchResultAfterChanges
    }
}


extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let albumCollection = viewModel?.albumCollection else {
            notiLabel.isHidden = false
            return 0
        }
        notiLabel.isHidden = albumCollection.count > 0 ? true : false
        
        return albumCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCollectionViewCell
        
        guard let viewModel = viewModel, let album = viewModel.albumCollection?.object(at: indexPath.row) else {
            return cell
        }
        
        let imageWidth = cell.frame.width
        if let asset = PhotoService.shard.getPhotoCollection(index: indexPath.row)?.lastObject {
            PhotoService.shard.imageManager.requestImage(for: asset,
                                                         targetSize: CGSize(width: imageWidth, height: imageWidth),
                                                         contentMode: .aspectFill,
                                                         options: nil,
                                                         resultHandler: { image, _ in
                                                         cell.photo.image = PHUtils().resizeImage(w: imageWidth, h: imageWidth, image: image!)
            })
        }
        else {
            guard let defaultImage = UIImage(named: "Icon-40.png") else {
                return cell
            }
            cell.photo.image = PHUtils().resizeImage(w: imageWidth, h: imageWidth, image: defaultImage)
        }
        
        cell.photo.layer.cornerRadius = CGFloat(imageWidth / 30)
        cell.title.text = album.localizedTitle
        cell.count.text = "\(album.estimatedAssetCount)"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSizeWidth = (view.frame.width - 16*3) / 2
        return CGSize(width: cellSizeWidth, height: cellSizeWidth+50)
    }
}

