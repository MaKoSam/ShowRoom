//
//  ImageManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 05/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class ImageManager {
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private static let pathName: String = {
        let pathName = "restaurant/images"
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                             in: .userDomainMask).first else {
            return pathName
        }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
        }
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        guard let  cacheDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                             in: .userDomainMask).first else {
            return nil
        }
        let hashName = url.split(separator: "/").last ?? "default"
        return cacheDirectory.appendingPathComponent(ImageManager.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
            let data = image.pngData() else {
            return
        }
        FileManager.default.createFile(atPath: fileName,
                                       contents: data,
                                       attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modifyDate = info[FileAttributeKey.modificationDate] as? Date else {
                return nil
        }
        let lifeTime = Date().timeIntervalSince(modifyDate)
        guard lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else {
                return nil
        }
        images[url] = image
        return image
    }
    
    private var images = [String: UIImage]()
    
    private func loadImage(atIndexPath indexPath: IndexPath, byURL url: String) {
        let networkRequest = ImageNetworkRequest()
        networkRequest.requestImage(from: url) { image in
            guard let image = image else {
                return
            }
            self.images[url] = image
            self.saveImageToCache(url: url, image: image)
            DispatchQueue.main.async {
                self.container.reloadRow(atIndexPath: indexPath)
            }
        }
    }
    
    func image(atIndexPath indexPath: IndexPath, byURL url: String) -> UIImage? {
        var image: UIImage?
        if let photo = images[url] {
            image = photo
        } else if let photo = getImageFromCache(url: url) {
            image = photo
        } else {
            loadImage(atIndexPath: indexPath, byURL: url)
        }
        return image
    }
    
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexPath indexPath: IndexPath)
}

extension ImageManager {
    private class Table: DataReloadable {
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    private class Collection: DataReloadable {
        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexPath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
