//
//  AsyncImageView.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 6/02/25.
//

import SwiftUI
import UIKit

struct AsyncImageView: View {
    let url: URL
    
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
            }else{
                ProgressView()
                    .accentColor(.white)
            }
        }
        .onAppear {
            Task {
                do {
                    image = try await downloadImage(url: url)
                }catch {
                    // handle error SHOW A IMAGE ERROR o text ERROR
                }
            }
        }

    }
    
    private func downloadImage(url: URL) async throws -> UIImage {
        let cache = DefaultNSCacheStoreDatasource<String,UIImage>()
        
        //Check if the image is already cached
        if let cachedImage = cache[url.absoluteString]{
            return cachedImage
        }
        
        //Download the image if not cached
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data){
                // cache the downloaded image
                cache[url.absoluteString] = image
                return image
            }
        }catch {
            throw ImageError.downloadFailed
        }
        
        throw ImageError.downloadFailed
    }
    
    enum ImageError: Error {
        case downloadFailed
    }
}

