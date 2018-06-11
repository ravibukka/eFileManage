//
//  ServiceManager.swift
//  eFileManage
//
//  Created by Administrator on 09/06/18.
//  Copyright © 2018 Bukka, Ravikumar. All rights reserved.
//

import UIKit
import Foundation

let urlStrings = [
    
    Environment().configuration(PlistKey.ServerURLFirst),
    Environment().configuration(PlistKey.ServerURLSecond),
    Environment().configuration(PlistKey.ServerURLThird),
    Environment().configuration(PlistKey.ServerURLFourth),
    Environment().configuration(PlistKey.ServerURLPdf),
    Environment().configuration(PlistKey.ServerURLVideo)
]

protocol ServiceManagerDelegate {
    func dataReceived(data: Any?, error: NSError?)
}

//protocol NetworkManagerDelegate {
//    func dataReceived(data: Any?, error: NSError?)
//}

class ServiceManager: NSObject, URLSessionDelegate, URLSessionDownloadDelegate   {
    
    var delegate: ServiceManagerDelegate?
    override init() {
        super.init()
    }


    let urls = urlStrings.compactMap { URL(string: $0) }   // use NSURL in Swift 2

    
 //Function to download PDF file from URLs
    func downloadImagefile(completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void){
        
        let imageUrlStrings = [
            Environment().configuration(PlistKey.ServerURLFirst),
            Environment().configuration(PlistKey.ServerURLSecond),
            Environment().configuration(PlistKey.ServerURLThird),
            Environment().configuration(PlistKey.ServerURLFourth)
        ]
        
        print(imageUrlStrings)
        let urls = imageUrlStrings.compactMap { URL(string: $0) }   
        
        var count: Int = 0
        
        for url in urls {
            
            // then lets create your document folder url
            let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            count = count + 1
            let destinationUrl = documentsDirectoryURL.appendingPathComponent("myImage\(count)" + ".jpg")
            
            // to check if it exists before downloading it
            if FileManager.default.fileExists(atPath: destinationUrl.path) {
                debugPrint("The file already exists at path")
                completion(true, destinationUrl)
                print(destinationUrl.path)
                // if the file doesn't exist
            } else {
                
                // you can use NSURLSession.sharedSession to download the data asynchronously
                URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    guard let tempLocation = location, error == nil else { return }
                    do {
                        // after downloading your file you need to move it to your destination url
                        try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                        print("File moved to documents folder")
                        completion(true, destinationUrl)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                        completion(false, nil)
                    }
                }).resume()
            }
        }
        
    }

 //Function to download PDF file from URLs
    func downloadPdfFile(completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void){
        
        let itemUrl = URL(string: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=eeda377a-aecb-4a22-8180-4214f5983967")
        
        // then lets create your document folder url
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent("myPdf.pdf")
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            debugPrint("The file already exists at path")
            completion(true, destinationUrl)
            print(destinationUrl.path)
            // if the file doesn't exist
        } else {
            
            // you can use NSURLSession.sharedSession to download the data asynchronously
            URLSession.shared.downloadTask(with: itemUrl!, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                do {
                    // after downloading your file you need to move it to your destination url
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    print("File moved to documents folder")
                    completion(true, destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(false, nil)
                }
            }).resume()
        }
    }
    
    
 //Function to download Video file from URLs
    func downloadVideoFile(completion: @escaping (_ success: Bool,_ fileLocation: URL?) -> Void){
        
        let itemUrl = URL(string: Environment().configuration(PlistKey.ServerURLVideo))
        
        // then lets create your document folder url
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // lets create your destination file url
        let destinationUrl = documentsDirectoryURL.appendingPathComponent("myVideo.mp4")
        
        // to check if it exists before downloading it
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            debugPrint("The file already exists at path")
            completion(true, destinationUrl)
            print(destinationUrl.path)
            // if the file doesn't exist
        } else {
            
            // you can use NSURLSession.sharedSession to download the data asynchronously
            URLSession.shared.downloadTask(with: itemUrl!, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                do {
                    // after downloading your file you need to move it to your destination url
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    print("File moved to documents folder")
                    completion(true, destinationUrl)
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(false, nil)
                }
            }).resume()
        }
    }
    
    private func calculateProgress(session : URLSession, completionHandler : @escaping (Float) -> ()) {
        session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            let progress = downloads.map({ (task) -> Float in
                if task.countOfBytesExpectedToReceive > 0 {
                    return Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
                } else {
                    return 0.0
                }
            })
            completionHandler(progress.reduce(0.0, +))
        }
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        //        if totalBytesExpectedToWrite > 0 {
        //            if let onProgress = onProgress {
        //                calculateProgress(session: session, completionHandler: onProgress)
        //            }
        //            let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        //            debugPrint("Progress \(downloadTask) \(progress)")
        //
        //        }
        
        //        progressView.setProgress(Float(totalBytesWritten)/Float(totalBytesExpectedToWrite), animated: true)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
    }
}
