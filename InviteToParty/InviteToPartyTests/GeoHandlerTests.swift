//
//  InviteToPartyTests.swift
//  InviteToPartyTests
//
//  Created by Daniel Colnaghi on 06/02/2019.
//  Copyright © 2019 Daniel Colnaghi. All rights reserved.
//

import XCTest
@testable import InviteToParty

class GeoHandlerTests: XCTestCase {

    var rad: Double!
    var deg: Double!
    var officeCoord: GeoPoint!
    var wrongOfficeCoord: GeoPoint!
    var officeDistance: Double!
    var wrongDistance: Double!
    var distance10km: Double!
    
    override func setUp() {
        print("🌎 GeoHandler test setup.")
        rad = GeoHandler.deg2rad(deg: 57.2958).rounded()
        deg = GeoHandler.rad2deg(rad: 1.012).rounded(.up)
        officeCoord = GeoPoint(lat: 53.339428, lon: -6.257664)
        wrongOfficeCoord = GeoPoint(lat: 53.0, lon: -6.0)
        officeDistance = GeoHandler.officeDistance(lat: officeCoord.lat, lon: officeCoord.lon)
        wrongDistance = GeoHandler.officeDistance(lat: wrongOfficeCoord.lat, lon: wrongOfficeCoord.lon)
        distance10km = GeoHandler.officeDistance(lat: 53.2451022, lon: -6.238335).rounded(.down)
    }

    override func tearDown() {
        print("🌎 GeoHandler tear down.")
        rad = nil
        deg = nil
        officeCoord = nil
        wrongOfficeCoord = nil
        officeDistance = nil
        wrongDistance = nil
        distance10km = nil
    }

    func testDeg2rad() {
        print("🌎 Rounded rad \(rad ?? 0).")
        XCTAssertTrue(rad == 1, "‼️ GeoHandler deg2rad test FAIL.")
    }

    func testRad2deg() {
        print("🌎 Rounded rad \(deg ?? 0).")
        XCTAssertTrue(deg == 58, "‼️ GeoHandler rad2deg test FAIL.")
    }
    
    func testOfficeCoordinates() {
        print("🌎 Office coord from GeoHandler \(GeoHandler.officeCoord).")
        print("🌎 Office coord from test \(String(describing: officeCoord)).")
        //True opperator
        XCTAssertTrue(officeCoord.lat == GeoHandler.officeCoord.lat, "‼️ GeoHandler wrong latitude")
        XCTAssertTrue(officeCoord.lon == GeoHandler.officeCoord.lon, "‼️ GeoHandler wrong longitude")
        //False opperator
        XCTAssertFalse(wrongOfficeCoord.lat == GeoHandler.officeCoord.lat, "‼️ GeoHandler wrong latitude")
        XCTAssertFalse(wrongOfficeCoord.lon == GeoHandler.officeCoord.lon, "‼️ GeoHandler wrong longitude")
    }
    
    func testOfficeDistance() {
        XCTAssertTrue(officeDistance == 0, "‼️ GeoHandler wrong distance")
        XCTAssertFalse(wrongDistance == 0, "‼️ GeoHandler wrong distance")
        XCTAssertTrue(distance10km == 10, "‼️ GeoHandler wrong distance")
    }
}
