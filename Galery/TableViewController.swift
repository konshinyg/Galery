//
//  TableViewController.swift
//  Galery
//
//  Created by Core on 22.11.17.
//  Copyright © 2017 Cornelius. All rights reserved.
//

import UIKit
import Photos

class TableViewController: UITableViewController {
    
    var imageArray = [UIImage]()
    var namesArray = [String]()
    var sizesArray = [Int]()
    var hashArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
    }
    
    func getPhotos() {
        let imgManager = PHImageManager.default()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .fastFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        if fetchResult.count > 0 {
            for i in 0..<fetchResult.count {
                
                // получаем файл
                imgManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 120, height: 120), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                    image, error in
                    self.imageArray.append(image!)
                    self.hashArray.append(image!.hashValue)
                })
                
                // получаем имя файла
                let imageName = fetchResult.object(at: i).value(forKey: "filename") as! String
                self.namesArray.append(imageName)
                
                // получаем размер файла
                imgManager.requestImageData(for: fetchResult.object(at: i), options: requestOptions, resultHandler: {
                    data, string, orientation, info in
                    
                    if data != nil {
                        let dataString : String! = String(describing: data!)
                        let newString = dataString.components(separatedBy: " ")
                        if let bytes = Int(newString[0]) {
                            let kB = bytes / 1000
                            self.sizesArray.append(kB)
                        }
                    }
                })
                
                // получаем хэш файла
                
            }
        } else {
            print("No any photos in Photo Galery!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.photoPreviewImage.image = imageArray[indexPath.row]
        cell.photoNameLabel.text = namesArray[indexPath.row]
        cell.photoSizeLabel.text = "size: \(sizesArray[indexPath.row]) kB"
        cell.photoHashLabel.text = "hash: \(hashArray[indexPath.row])"
        return cell
    }
}
