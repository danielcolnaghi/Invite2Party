//
//  InviteToPartyUITests.swift
//  InviteToPartyUITests
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import XCTest

class InviteToPartyUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {

    }

    func testExample() {
        let app = XCUIApplication()
        app.buttons["GO Customers!"].tap()
        app.tables.staticTexts["Ian Kehoe"].tap()
        app.tables.staticTexts["Nora Dempsey"].tap()
        app.tables.staticTexts["Christina McArdle"].swipeUp()
        app.tables.staticTexts["Patricia Cahill"].tap()
        app.navigationBars["Customers"].buttons["Back"].tap()
        app.buttons["GO Customers!"].tap()
    }

}
