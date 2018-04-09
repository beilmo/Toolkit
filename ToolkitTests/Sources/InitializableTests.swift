//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import XCTest
@testable import Toolkit

class InitializableTests: XCTestCase {
    
    func testStructInit() {
        let variable = CustomInitializableNameOption.default.rawValue
        let sut = InitializableStruct()
        XCTAssertEqual(sut.name, variable)
    }

    func testStructInitWithBlock() {
        let variable = CustomInitializableNameOption.new.rawValue
        let sut = InitializableStruct.makeNewInstance(variable)
        XCTAssertEqual(sut.name, variable)
    }

    func testClasInit() {
        let variable = CustomInitializableNameOption.default.rawValue
        let sut = InitializableClass()
        XCTAssertEqual(sut.name, variable)
    }

    func testClassInitWithBlock() {
        let variable = CustomInitializableNameOption.new.rawValue
        let sut = InitializableClass.makeNewInstance(variable)
        XCTAssertEqual(sut.name, variable)
    }

    func testFinalClasInit() {
        let variable = CustomInitializableNameOption.default.rawValue
        let sut = InitializableFinalClass()
        XCTAssertEqual(sut.name, variable)
    }

    func testFinalClassInitWithBlock() {
        let variable = CustomInitializableNameOption.new.rawValue
        let sut = InitializableFinalClass.makeNewInstance(variable)
        XCTAssertEqual(sut.name, variable)
    }

    func testObjCClasInit() {
        let variable = CustomInitializableNameOption.default.rawValue
        let sut = InitializableObjCClass()
        XCTAssertEqual(sut.name, variable)
    }

    func testObjCClassInitWithBlock() {
        let variable = CustomInitializableNameOption.new.rawValue
        let sut = InitializableObjCClass.makeNewInstance(variable)
        XCTAssertEqual(sut.name, variable)
    }

}


