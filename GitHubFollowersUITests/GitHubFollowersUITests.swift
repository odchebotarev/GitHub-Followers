//
//  GitHubFollowersUITests.swift
//  GitHubFollowersUITests
//
//  Created by Oleg Chebotarev on 19.11.2020.
//

import XCTest

class GitHubFollowersUITests: XCTestCase {

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        let user1 = "alessandroanjos"
        let user2 = "burakglobal"
        let user3 = "SAllen0400"
        
        app.textFields["Enter a username"].tap()
        app.buttons["Next keyboard"].press(forDuration: 1.0);
        app.tables["InputSwitcherTable"].staticTexts["English (US)"].tap()
        
        app.keys["s"].tap()
        app.keys["a"].tap()
        app.keys["l"].tap()
        app.keys["l"].tap()
        app.keys["e"].tap()
        app.keys["n"].tap()
        app.keys["more"].tap()
        app.keys["0"].tap()
        app.keys["4"].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.buttons["Go"].tap()
        
        app.collectionViews.cells.containing(.staticText, identifier: user1).children(matching: .other).element.swipeUp()
        app.collectionViews.cells.containing(.staticText, identifier: user2).children(matching: .other).element.tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.staticTexts["Get followers"].tap()
        let user2NavigationBar = app.navigationBars[user2]
        user2NavigationBar.buttons["User Info"].tap()
        app.navigationBars["GitHub_Followers.UserInfoView"].buttons["Done"].tap()
        user2NavigationBar.buttons["Search"].tap()
        
        app.tabBars["Tab Bar"].buttons["Favorites"].tap()
        XCUIApplication().tabBars["Tab Bar"].buttons["Favorites"].tap()
        let user3StaticText = app.tables.staticTexts[user3]
        user3StaticText.swipeLeft()
        
        app.tabBars["Tab Bar"].buttons["Search"].tap()
                
    }
    
}
