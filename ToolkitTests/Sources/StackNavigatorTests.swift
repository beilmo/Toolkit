//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import XCTest
@testable import Toolkit

class StackNavigatorTests: XCTestCase {


    // MARK: - Parameters & Constants.

    var navigatorStack: MockNavigatorStack! = nil

    // MARK: - Test variables.

    var sut: MockStackNavigator!


    // MARK: - Set up and tear down.

    override func setUp() {
        super.setUp()

        navigatorStack = MockNavigatorStack()

        sut = MockStackNavigator(mockNavigatorStack: navigatorStack)
    }
    
    override func tearDown() {
        sut = nil
        navigatorStack = nil

        super.tearDown()
    }
    
    func testNavigation() {
        let make = self.expectation(description: "Call -make method")
        let navigate = self.expectation(description: "Call -navigate method")

        sut.didCallMakeMethod = {
            make.fulfill()
        }

        navigatorStack.didCallNavigate = {
            navigate.fulfill()
        }

        sut.navigate(to: .screen1, completion: nil)

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }


    func testPresentation() {
        let make = self.expectation(description: "Call -make method")
        let present = self.expectation(description: "Call -present method")

        sut.didCallMakeMethod = {
            make.fulfill()
        }

        navigatorStack.didCallPresent = {
            present.fulfill()
        }

        sut.present(destination: .screen3, completion: nil)

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }

}
