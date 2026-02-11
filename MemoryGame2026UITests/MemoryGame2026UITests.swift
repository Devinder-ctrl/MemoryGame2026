//
//  MemoryGame2026UITests.swift
//  MemoryGame2026UITests
//
//  Created by  on 2026-01-05.
//

import XCTest

final class MemoryGame2026UITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
   
    //test stepper
    @MainActor
    func testRowsColStepper() throws {
        let app = XCUIApplication()
        app.activate()
        let increment = app/*@START_MENU_TOKEN@*/.buttons["Increment"]/*[[".steppers",".buttons[\"6 Rows\/Cols, Increment\"]",".buttons[\"Increment\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        let decrement = app/*@START_MENU_TOKEN@*/.buttons["Decrement"]/*[[".steppers",".buttons[\"9 Rows\/Cols, Decrement\"]",".buttons[\"Decrement\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        var value = 5
        
        for _ in 1...7{
            let label = app.staticTexts["\(value) Rows/Cols"].firstMatch
            if( value < 11){
                XCTAssertTrue(label.waitForExistence(timeout: 1), "Expected '\(value) Rows/Cols' label to exist after incrementing" )
            }
            increment.tap()
            value = value +  1
           
        }
        let label1 = app.staticTexts["10 Rows/Cols"].firstMatch
        let label3 = app.staticTexts["9 Rows/Cols"].firstMatch
        //test for the 10
        XCTAssertTrue(label1.waitForExistence(timeout: 1), "Expected '10 Rows/Cols' label to exist after incrementing" )
        
        //test for decrement 9 label
        decrement.tap()
        XCTAssertTrue(label3.waitForExistence(timeout: 1), "Expected '9 Rows/Cols' label to exist after decrementing" )
        
        for _ in 1...6{
            decrement.tap()
        }
        let label2 = app.staticTexts["5 Rows/Cols"].firstMatch
        //test for the 5
        XCTAssertTrue(label2.waitForExistence(timeout: 1), "Expected '5 Rows/Cols' label to exist after decrementing" )
        
    }
    
    
    //test Bonus Toggle
    @MainActor
    func testBonus() throws {
        let app = XCUIApplication()
        app.activate()
        let OFF = app/*@START_MENU_TOKEN@*/.switches["1"]/*[[".switches.switches[\"1\"]",".switches[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        let ON = app/*@START_MENU_TOKEN@*/.switches["0"]/*[[".switches.switches[\"0\"]",".switches[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        //check if its Off
        XCTAssertTrue(ON.waitForExistence(timeout: 1), "Expected to be OFF" )
        ON.tap()
        //check On
        XCTAssertTrue(OFF.waitForExistence(timeout: 1), "Expected to be ON" )
        OFF.tap()
        XCTAssertTrue(ON.waitForExistence(timeout: 1), "Expected to be OFF" )
        
    }
    
    //test app storage
    @MainActor
    func testAppStorage() throws {
        //Check app storage by setting image on lasso and closing the app the reopening the app
        let app = XCUIApplication()
        app.activate()
        let leftButton = app/*@START_MENU_TOKEN@*/.buttons["left button"]/*[[".otherElements",".buttons[\"arrowtriangle.left\"]",".buttons[\"left button\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        let scribble = app.images["scribble"].firstMatch
        let pencil = app.images["pencil"].firstMatch
        let label = app.staticTexts["6 Rows/Cols"].firstMatch
        
        leftButton.tap()
        leftButton.tap()
        
        XCTAssertTrue(scribble.waitForExistence(timeout: 1), "Expected to be scribble")
        
        let posStep = app/*@START_MENU_TOKEN@*/.buttons["Increment"]/*[[".steppers",".buttons[\"5 Rows\/Cols, Increment\"]",".buttons[\"Increment\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        let negStep = app.buttons["Decrement"].firstMatch
        posStep.tap()
        
        let ON = app/*@START_MENU_TOKEN@*/.switches["0"]/*[[".switches.switches[\"0\"]",".switches[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        let OFF = app/*@START_MENU_TOKEN@*/.switches["1"]/*[[".switches.switches[\"1\"]",".switches[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        ON.tap()
        
        let setting = app/*@START_MENU_TOKEN@*/.buttons["Settings"]/*[[".otherElements[\"Settings\"].buttons",".otherElements",".buttons[\"Home\"]",".buttons[\"Settings\"]"],[[[-1,3],[-1,2],[-1,1,1],[-1,0]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()

        XCUIDevice.shared.press(.home)
        XCUIDevice.shared.press(.home)
        XCUIDevice.shared.press(.home)
        
        app.terminate()
        app.launch()
        
        XCTAssertTrue(label.waitForExistence(timeout: 1), "Expected '6 Rows/Cols' label to exist after incrementing" )
        XCTAssertTrue(OFF.waitForExistence(timeout: 1), "Expected to be ON" )
        XCTAssertTrue(scribble.waitForExistence(timeout: 1), "Expected to be scribble")
        for _ in 1...2{
            leftButton.tap()
        }
        XCTAssertTrue(pencil.waitForExistence(timeout: 1), "Expected to be pencil")
        OFF.tap()
        negStep.tap()
        
        
    }
   
    //test left button
    @MainActor
    func testLeftButton() throws{
        let app = XCUIApplication()
        app.activate()
        let leftButton = app.buttons["left button"].firstMatch
        let Img1 = app.images["pencil"].firstMatch
        let Img2 = app.images["eraser"].firstMatch
        let Img3 = app.images["scribble"].firstMatch
        let Img4 = app.images["lasso"].firstMatch
        
        var curInd = 0
        let array = [Img1, Img4, Img3, Img2]
        //check all the images while clicking the left button
        for _ in 1...4{
            leftButton.tap()
            curInd = curInd + 1
            if(curInd  < 4){
                XCTAssertTrue(array[curInd].waitForExistence(timeout: 1), "Expected to be \(array[curInd])")
            }
        }
    
    }
    //test right button
    @MainActor
    func testRightButton() throws {
        let app = XCUIApplication()
        app.activate()
        let rightButton = app.buttons["Right BUtton"].firstMatch
        let Img1 = app.images["pencil"].firstMatch
        let Img2 = app.images["eraser"].firstMatch
        let Img3 = app.images["scribble"].firstMatch
        let Img4 = app.images["lasso"].firstMatch
        
        var curInd = 0
        let array = [Img1, Img2, Img3, Img4]
        //check all the images while clicking the right button
        for _ in 1...4{
            rightButton.tap()
            while curInd < 4{
                curInd = curInd + 1
            }
            
            if(curInd  < 4){
                XCTAssertTrue(array[curInd].waitForExistence(timeout: 1), "Expected to be \(array[curInd])")
            }
        }
           
    }
    
    
    //test gamme view
    @MainActor
    func testGameView() throws {
        let app = XCUIApplication()
        app.launch()
        let leftbtn = app.buttons["left button"].firstMatch
        let eraser = app.images["eraser"].firstMatch
        let setting = app/*@START_MENU_TOKEN@*/.buttons["Settings"]/*[[".otherElements[\"Settings\"].buttons",".otherElements",".buttons[\"Home\"]",".buttons[\"Settings\"]"],[[[-1,3],[-1,2],[-1,1,1],[-1,0]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        let rightbtn = app/*@START_MENU_TOKEN@*/.buttons["Right BUtton"]/*[[".otherElements",".buttons[\"arrowtriangle.right\"]",".buttons[\"Right BUtton\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        
        rightbtn.tap()
        XCTAssert(eraser.waitForExistence(timeout: 1), "Expected to be eraser")
        setting.tap()
        XCTAssert(eraser.waitForExistence(timeout: 1), "Expected to be eraser")
        setting.tap()
        leftbtn.tap()
        
    }
}
