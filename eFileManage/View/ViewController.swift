//
//  ViewController.swift
//  eFileManage
//
//  Created by Bukka, Ravikumar on 10/06/18.
//  Copyright © 2018 Bukka, Ravikumar. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController,ServiceManagerDelegate,UICollectionViewDelegate {

    @IBOutlet weak var collectionView : UICollectionView!
    
    var fileURLs = [URL]()
    var finalFileURLs = [URL]()
    
    
    lazy var collectionViewFlowLayout : CustomCollectionViewLayout = {
        let layout = CustomCollectionViewLayout(display: .grid)
        return layout
    }()
    
    let dataSource = CollectionDataSource()
    
    lazy var previewItem = NSURL()
    
    func dataReceived(data: Any?, error: NSError?) {
        if error != nil {
            print("Error: \(String(describing: error))")
        }
        
        guard data != nil else {
            print("Error: No data")
            return
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        
        
        self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
        self.collectionView.dataSource = self.dataSource
        //self.collectionView.reloadData()
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            DispatchQueue.main.async(){
            self?.collectionView.reloadData()
            }
        }
        
        
        
        let serviceManager = ServiceManager()
        serviceManager.delegate = self
        serviceManager.downloadImagefile(completion: {(success, fileLocationURL) in
            
            if success {
                
                let fileManager = FileManager.default
                let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                do {
                    self.fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                    
                    
                    let pdfImageURL = Bundle.main.url(forResource:"pdf", withExtension: "png")
                    let videoImageURL = Bundle.main.url(forResource:"video", withExtension: "png")
                    let pdfFileURL = Bundle.main.url(forResource:"myPdf", withExtension: "pdf")
                    let videoFileURL = Bundle.main.url(forResource:"myVideo", withExtension: "mp4")
                    
                    //self.finalFileURLs = self.fileURLs.copy()
                    self.finalFileURLs = NSArray(array:self.fileURLs, copyItems: true) as! [URL]
                    
                    if (self.fileURLs.count > 3) {
                    self.fileURLs.insert(pdfImageURL!, at: 4)
                    self.fileURLs.insert(videoImageURL!, at: 5)
                    self.finalFileURLs.insert(pdfFileURL!, at: 4)
                    self.finalFileURLs.insert(videoFileURL!, at: 5)
                    }
                    
                    
                    self.dataSource.data.value = self.fileURLs
                    // process files
                } catch {
                    print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
                }
                
            }else{
                debugPrint("File can't be downloaded")
            }
        })
    }
    
    @IBAction func layoutValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            self.collectionViewFlowLayout.display = .list
        case 2:
            self.collectionViewFlowLayout.display = .inline
        default:
            self.collectionViewFlowLayout.display = .grid
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        self.previewItem = finalFileURLs[indexPath.row] as NSURL
        
        
        // Display file
        let previewController = QLPreviewController()
        previewController.dataSource = self
        self.present(previewController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

