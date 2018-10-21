//
//  DemoRestUITests.swift
//  DemoRestUITests
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import XCTest

class DemoRestUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testTableInteraction() {
        
        let app = XCUIApplication()
        app.launch()
        
        let repositoryTableView = app.tables["table-repository"]
        XCTAssertTrue(repositoryTableView.exists, "The repository tableview exists")
        
        
        let cells = repositoryTableView.cells
        let countTopLevelCells = cells.count
        
        
        if countTopLevelCells > 0 {
            
            let promise = expectation(description: "Wait for table cells")
            
            for i in 0..<countTopLevelCells {
                
                
                // Grab the first cell and verify that it exists and tap it
                let tableCell = cells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                
                // Does this actually take us to the next screen
                tableCell.tap()
                
                if i == countTopLevelCells - 1 {
                    promise.fulfill()
                }
                // Back
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            
            XCTAssert(false, "Was not able to find any table cells")
            
        }
        
    }
}
