//
//  ContentView.swift
//  PhotosExample
//
//  Created by 김효원 on 2019/10/10.
//  Copyright © 2019 HyowonKim. All rights reserved.
//

import SwiftUI
import Photos

struct ContentView: View {
    @State var photoCollection: [UIImage]
    
    var body: some View {
        VStack{
            List(0..<photoCollection.count){
                Text("dfsdf")
                GridCell(photo: self.photoCollection[$0])
            }
        }
    }
}


// MARK: - Collection View
struct GridCell: View{
    @State var photo: UIImage
    
    var body: some View {
        HStack{
            Image(uiImage: photo)
        }
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static let photoService = PhotoService()
    
    static var previews: some View {
        ContentView(photoCollection: photoService.imageArray!)
    }
}
#endif
