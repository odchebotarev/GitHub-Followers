//
//  GitHubFollowersTests.swift
//  GitHubFollowersTests
//
//  Created by Oleg Chebotarev on 19.11.2020.
//

import XCTest
@testable import GitHub_Followers

class GitHubFollowersTests: XCTestCase {

    func testConvertDate() throws {
        let date = Date(timeIntervalSince1970: 0)
        let dateString = date.convertToMonthYearFormat()
        XCTAssertEqual(dateString, "Jan 1970", "Invalid conversion of date to string format \"MMM yyyy\"")
    }

}
