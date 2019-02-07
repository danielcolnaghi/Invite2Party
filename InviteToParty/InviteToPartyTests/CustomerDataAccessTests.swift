//
//  CustomerDataAccessTests.swift
//  InviteToPartyTests
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import XCTest
@testable import InviteToParty

class CustomerDataAccessTests: XCTestCase {

    var customer1: Customer!
    var customerLast: Customer!
    var customerEmpty: Customer!
    
    override func setUp() {
        customer1 = Customer(userId: 1, name: "Alice Cahill", latitude: "51.92893", longitude: "-10.27699")
        customerLast = Customer(userId: 39, name: "Lisa Ahearn", latitude: "53.0033946", longitude: "-6.3877505")
        customerEmpty = Customer(userId: 0, name: "", latitude: "", longitude: "")
    }

    override func tearDown() {
        customer1 = nil
        customerEmpty = nil
        customerLast = nil
    }

    func testLoadData() {
        CustomerDataAccess.shared.loadData({ (list) in
            let sortedList = list.sorted(by: { $0.userId < $1.userId })
            print("📝 Sorted List \(sortedList)")
            let firstItem = sortedList.first
            let lastItem = sortedList.last
            XCTAssertEqual(firstItem?.userId, customer1.userId, "📝 Customer list is different from the original")
            XCTAssertEqual(lastItem?.userId, customerLast.userId, "📝 Customer list is different from the original")
        }) { (errorMessage) in
            XCTFail("‼️ Customer list error message: \(errorMessage)")
        }
    }

}
