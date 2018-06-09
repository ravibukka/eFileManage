//
//  EnvironConfig.swift
//  eFileManage
//
//  Created by Bukka, Ravikumar on 6/5/18.
//  Copyright © 2018 Bukka, Ravikumar. All rights reserved.
//

import Foundation


public enum PlistKey {
    case ServerURLFirst
    case ServerURLSecond
    case ServerURLThird
    case ServerURLFourth
    case ServerURLPdf
    case ServerURLVideo
//    case TimeoutInterval
//    case ConnectionProtocol
    
    func value() -> String {
        switch self {
        case .ServerURLFirst:
            return "server_url_first"
        case .ServerURLSecond:
            return "server_url_second"
        case .ServerURLThird:
            return "server_url_third"
        case .ServerURLFourth:
            return "server_url_fourth"
        case .ServerURLPdf:
            return "server_url_pdf"
        case .ServerURLVideo:
            return "server_url_video"
//        case .TimeoutInterval:
//            return "timeout_interval"
//        case .ConnectionProtocol:
//            return "protocol"
        }
    }
}
public struct Environment {
    
    fileprivate var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerURLFirst:
            return infoDict[PlistKey.ServerURLFirst.value()] as! String
        case .ServerURLSecond:
            return infoDict[PlistKey.ServerURLSecond.value()] as! String
        case .ServerURLThird:
            return infoDict[PlistKey.ServerURLThird.value()] as! String
        case .ServerURLFourth:
            return infoDict[PlistKey.ServerURLFourth.value()] as! String
        case .ServerURLPdf:
            return infoDict[PlistKey.ServerURLPdf.value()] as! String
        case .ServerURLVideo:
            return infoDict[PlistKey.ServerURLVideo.value()] as! String
            //return infoDict[PlistKey.ServerURL.value()] as! String
//        case .TimeoutInterval:
//            return infoDict[PlistKey.TimeoutInterval.value()] as! String
//        case .ConnectionProtocol:
//            return infoDict[PlistKey.ConnectionProtocol.value()] as! String
        }
    }
}
