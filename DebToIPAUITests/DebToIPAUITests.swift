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
        let found = cancelButton.waitForExistence(timeout: 15)
        if !found {
            // Dump the accessibility tree so a CI failure here is diagnosable
            // from the log alone instead of needing another blind guess.
            print("DEBUG accessibility tree after tapping import:\n\(app.debugDescription)")
        }
        XCTAssertTrue(found, "Cancel button not found after tapping the import button")
    }
}
