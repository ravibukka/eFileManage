//
//  ViewController.swift
//  eFileManage
//
//  Created by Bukka, Ravikumar on 6/5/18.
//  Copyright © 2018 Bukka, Ravikumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let server_url = Environment().configuration(PlistKey.ServerURLFirst)
//        print(server_url)
        
        let urlStrings = [
            
            Environment().configuration(PlistKey.ServerURLFirst),
            Environment().configuration(PlistKey.ServerURLSecond),
            Environment().configuration(PlistKey.ServerURLThird),
            Environment().configuration(PlistKey.ServerURLFourth)
        ]
        let urls = urlStrings.flatMap { URL(string: $0) }   // use NSURL in Swift 2
        
        for url in urls {
          //  downloadManager.addDownload(url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

