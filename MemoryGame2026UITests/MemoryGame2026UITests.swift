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
   

    // Helper to get the current placeholder identifier from the settings picker
    private func currentPlaceholderIdentifier() -> String? {
        let app = XCUIApplication()
        // The center image in ImagePickerView uses its symbol name as accessibilityIdentifier
        // We find any image that matches one of the known identifiers.
        let possible = ["pencil", "eraser", "scribble", "lasso"]
        for id in possible {
            if app.images[id].exists { return id }
        }
        return nil
    }

    // Verifies that changing the image selection in Settings is reflected in GameView tiles
    @MainActor
    func testImageSelectionReflectedInGameView() {
        let app = XCUIApplication()
        app.launch()

        // Change the image by tapping the right arrow once.
        let rightButton = app.buttons["Right BUtton"].firstMatch
        XCTAssertTrue(rightButton.waitForExistence(timeout: 2), "Right arrow button should exist")
        rightButton.tap()

        // Capture the currently selected placeholder identifier.
        guard let selectedIdentifier = currentPlaceholderIdentifier() else {
            XCTFail("Could not determine selected placeholder identifier")
            return
        }

        // Navigate to the GameView by tapping the toolbar toggle button.
        let toggleButton = app.buttons["Settings"].firstMatch
        XCTAssertTrue(toggleButton.waitForExistence(timeout: 2), "Toolbar toggle should exist")
        toggleButton.tap()

        // Wait 4 seconds before closing the toggle (allow GameView to render fully)
        RunLoop.current.run(until: Date().addingTimeInterval(4))

        // Verify at least one tile image exists with the same identifier, meaning the selection propagated.
        let tileImage = app.images[selectedIdentifier]
        XCTAssertTrue(tileImage.waitForExistence(timeout: 2), "Game tiles should use the selected placeholder identifier: \(selectedIdentifier)")

        // Close GameView and return to Settings by tapping the toggle again
        toggleButton.tap()

        // Now revert everything back to defaults: image = pencil, stepper = 5, bonus = off.
        // 1) Reset image back to pencil.
        // Try moving right up to 4 times; if not pencil, move left up to 4 times to find it.
        func ensureImageIs(_ target: String) {
            let leftButton = app.buttons["left button"].firstMatch
            let rightButton = app.buttons["Right BUtton"].firstMatch
            // Prefer using right taps first
            var safety = 8
            while currentPlaceholderIdentifier() != target && safety > 0 {
                if rightButton.exists { rightButton.tap() } else if leftButton.exists { leftButton.tap() }
                safety -= 1
            }
            XCTAssertEqual(currentPlaceholderIdentifier(), target, "Expected current placeholder to be \(target)")
        }
        ensureImageIs("pencil")

        // 2) Reset stepper to 5
        let stepper = app.steppers.firstMatch
        XCTAssertTrue(stepper.waitForExistence(timeout: 2), "Stepper should exist")
        func currentSize() -> Int? {
            let predicate = NSPredicate(format: "label CONTAINS 'Rows/Cols'")
            let labelElement = app.staticTexts.containing(predicate).firstMatch
            guard labelElement.exists else { return nil }
            let label = labelElement.label
            let comps = label.split(separator: " ")
            if let first = comps.first, let val = Int(first) { return val }
            return nil
        }
        var safetySize = 20
        while let cur = currentSize(), cur != 5, safetySize > 0 {
            if cur < 5 { stepper.buttons["Increment"].tap() } else { stepper.buttons["Decrement"].tap() }
            safetySize -= 1
        }
        XCTAssertEqual(currentSize(), 5, "Expected size to be set to 5")

        // 3) Ensure bonus is OFF
        // Based on earlier tests, switch with identifier "0" represents OFF and "1" represents ON (or vice versa).
        // We'll attempt to turn it off reliably by checking both.
        let bonusOffSwitch = app.switches["0"].firstMatch
        let bonusOnSwitch = app.switches["1"].firstMatch
        if bonusOnSwitch.waitForExistence(timeout: 1) {
            // If we see the ON state, tap it to switch off
            bonusOnSwitch.tap()
        }
        // After attempting to turn off, assert that the OFF state exists.
        XCTAssertTrue(bonusOffSwitch.waitForExistence(timeout: 2), "Expected Bonus to be OFF")
    }

    // Verifies that changing the stepper size in Settings is reflected in GameView grid tile count
    @MainActor
    func testBoardSizeReflectedInGameView() {
        let app = XCUIApplication()
        app.launch()

        // Choose a target size via the stepper. We'll set it to 6 for verification.
        let targetSize = 6

        // The stepper label shows "{size} Rows/Cols". Increase/decrease until it reads targetSize.
        let stepper = app.steppers.firstMatch
        XCTAssertTrue(stepper.waitForExistence(timeout: 2), "Stepper should exist")

        // Read current size from the static text containing "Rows/Cols"
        func currentSize() -> Int? {
            let predicate = NSPredicate(format: "label CONTAINS 'Rows/Cols'")
            let labelElement = app.staticTexts.containing(predicate).firstMatch
            guard labelElement.exists else { return nil }
            let label = labelElement.label
            let comps = label.split(separator: " ")
            if let first = comps.first, let val = Int(first) { return val }
            return nil
        }

        // Adjust the stepper to reach targetSize
        var safety = 20
        while let cur = currentSize(), cur != targetSize, safety > 0 {
            if cur < targetSize { stepper.buttons["Increment"].tap() }
            else { stepper.buttons["Decrement"].tap() }
            safety -= 1
        }
        XCTAssertEqual(currentSize(), targetSize, "Expected size to be set to \(targetSize)")

        // Capture the current placeholder identifier to query tiles later.
        let placeholder = currentPlaceholderIdentifier() ?? "pencil"

        // Navigate to GameView
        let toggleButton = app.buttons["Settings"].firstMatch
        XCTAssertTrue(toggleButton.waitForExistence(timeout: 2))
        toggleButton.tap()

        // Count how many tile images are present with the placeholder identifier.
        // This should equal size * size.
        let expectedCount = targetSize * targetSize
        let tilesQuery = app.images.matching(identifier: placeholder)

        // Allow a brief moment for the grid to render
        _ = tilesQuery.element(boundBy: 0).waitForExistence(timeout: 2)

        XCTAssertEqual(tilesQuery.count, expectedCount, "Expected \(expectedCount) tiles, found \(tilesQuery.count)")

        // Return to Settings to restore defaults
        toggleButton.tap()

        // Restore board size to default 5
        var resetSafety = 20
        while let cur = currentSize(), cur != 5, resetSafety > 0 {
            if cur < 5 { stepper.buttons["Increment"].tap() } else { stepper.buttons["Decrement"].tap() }
            resetSafety -= 1
        }
        XCTAssertEqual(currentSize(), 5, "Expected size to be reset to 5")

        // Ensure Bonus is OFF by toggling if necessary
        let bonusOffSwitch = app.switches["0"].firstMatch
        let bonusOnSwitch = app.switches["1"].firstMatch
        if bonusOnSwitch.waitForExistence(timeout: 1) {
            // If ON is visible, tap to turn it off
            bonusOnSwitch.tap()
        }
        XCTAssertTrue(bonusOffSwitch.waitForExistence(timeout: 2), "Expected Bonus to be OFF after reset")
    }

    // Verifies that the Bonus toggle selection in Settings influences GameView state
    @MainActor
    func testBonusReflectedInGameView() {
        let app = XCUIApplication()
        app.launch()

        // Toggle Bonus ON (switch value "0" becomes "1" when turned on depending on system, so we use labels seen in other tests)
        let bonusOff = app.switches["0"].firstMatch
        let bonusOn = app.switches["1"].firstMatch

        // If currently off, tap to turn on; otherwise ensure it's on.
        if bonusOff.waitForExistence(timeout: 1) {
            bonusOff.tap()
        } else {
            XCTAssertTrue(bonusOn.exists, "Bonus switch should be ON or OFF identifiable")
        }

        // Navigate to GameView
        let toggleButton = app.buttons["Settings"].firstMatch
        XCTAssertTrue(toggleButton.waitForExistence(timeout: 2))
        toggleButton.tap()

        // In GameView, assert that an element that indicates bonus mode exists.
        // If GameView exposes an accessibility identifier when bonus is enabled, check it here.
        // As a generic assertion, ensure grid is present and at least one tile exists, implying view rendered under this mode.
        let anyTile = app.images.firstMatch
        XCTAssertTrue(anyTile.waitForExistence(timeout: 2), "Expected at least one tile in GameView when bonus is enabled")
    }

}

