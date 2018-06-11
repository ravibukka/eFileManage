//
//  CollectionDataSource.swift
//  eFileManage
//
//  Created by Bukka, Ravikumar on 10/06/18.
//  Copyright © 2018 Bukka, Ravikumar. All rights reserved.
//

import UIKit
import Foundation
import QuickLook

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class CollectionDataSource : GenericDataSource<URL>, UICollectionViewDataSource {
    
 
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        
//        [UIImage imageNamed:[_stepImagesArray objectAtIndex:indexPath.row]
        
      //  var myImageView: UIImageView
        
//        print(data.value[0])
//
//        let url = URL(string: data.value[indexPath.row].path)
//        let req = NSURLRequest(url: url!)
//
//
//        let myWebView = UIWebView()
//
//
//        myWebView.loadRequest(req as URLRequest)
        let myImage = UIImage(contentsOfFile: data.value[indexPath.row].path)
//        let myImage = UIImage(contentsOfFile: data.value[indexPath.row].path)
        let myImageView : UIImageView = UIImageView(image: myImage)
        
       // myImageView.imageURL = [NSURL URLWithString:question.picture];
        
      //fileURLs[indexPath.row]
       // let imageView: UIImageView = UIImageView(image: UIImage(URL: data.value[indexPath.row] ))
        
       // let image    = UIImage(contentsOfFile: data.value[indexPath.row].path)
       // cell.imageView.image = myImage
        cell.contentView.addSubview(myImageView)
       // cell.contentView.addSubview([UIImage imageNamed:[data.value[indexPath.row]])
        
       // cell.backgroundColor = data.value[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
       // data.value
        
        print(data.value[indexPath.row].path)
        
        if indexPath.row == 1{
            print("One")
            
        }
        if indexPath.row == 2{
            print("Two")
        }
        if indexPath.row == 3 {
            print("Thrree")
        }
        if indexPath.row == 4 {
            print("Four")
        }
//        self.previewItem = fileLocationURL! as NSURL
//        // Display file
//        let previewController = QLPreviewController()
//        previewController.dataSource = self
//        self.present(previewController, animated: true, completion: nil)
    }
    


        
        // Show horizontal layout
      //  performSegue(withIdentifier: "showHorizontal", sender: indexPath)
        
        //        // Show car's detail view
        //        let selectedCar = dataSource.carAtIndexPath(indexPath)
        //        // 1. Do it with the segue
        //        performSegue(withIdentifier: "selectCar", sender: selectedCar)
    
}


//MARK:- QLPreviewController Datasource

extension ViewController: QLPreviewControllerDataSource, QLPreviewControllerDelegate {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        return self.previewItem as QLPreviewItem
    }
}
