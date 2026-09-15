//
//  DebToIPAUITests.swift
//  DebToIPAUITests
//

import XCTest

final class DebToIPAUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAppLaunchesAndShowsMainList() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.navigationBars["DebToIPA"].waitForExistence(timeout: 5))

        let importButton = app.navigationBars["DebToIPA"].buttons.firstMatch
        XCTAssertTrue(importButton.waitForExistence(timeout: 5))
    }

    func testTappingImportButtonPresentsFileImporter() throws {
        let app = XCUIApplication()
        app.launch()

        let importButton = app.navigationBars["DebToIPA"].buttons.firstMatch
        XCTAssertTrue(importButton.waitForExistence(timeout: 5))
        importButton.tap()

        // A .deb file isn't available to pick in CI, so this only confirms the
        // fileImporter sheet actually presents (via its Cancel control) rather
        // than completing a full conversion.
        let cancelButton = app.buttons["Cancel"]
        XCTAssertTrue(cancelButton.waitForExistence(timeout: 5))
    }
}
