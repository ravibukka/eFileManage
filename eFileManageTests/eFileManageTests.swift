//
//  eFileManageTests.swift
//  eFileManageTests
//
//  Created by Bukka, Ravikumar on 6/5/18.
//  Copyright © 2018 Bukka, Ravikumar. All rights reserved.
//

import XCTest
@testable import eFileManage

class eFileManageTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDownloadWebData() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Download the image")
        
        // Create a URL for a web page to be downloaded.
        let url = URL(string: "https://clientarea.indegene.com/sharemax/retrieve.jsp?id=fd7b185a-58e7-4e1f-9870-654736d9fa2d")!
        
        // Create a background task to download the web page.
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
            
        }
        
        // Start the download task.
        dataTask.resume()
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
}
