//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import XCTest
import UIKit

@testable import Toolkit

class AnyNavigationStackTests: XCTestCase {

    // MARK: - Parameters & Constants

    var viewController1: UIViewController! = nil
    var viewController2: UIViewController! = nil
    var viewController3: UIViewController! = nil
    var navigationController: MockUINavigationController! = nil

    // MARK: - Test variables

    var sut: AnyNavigationStack<UIViewController>! = nil


    // MARK: - Set up and tear down

    override func setUp() {
        super.setUp()

        viewController1 = UIViewController()
        viewController2 = UIViewController()
        viewController3 = UIViewController()
        navigationController = MockUINavigationController()

        sut = AnyNavigationStack(navigationController)
    }
    
    override func tearDown() {
        sut = nil
        navigationController = nil
        viewController1 = nil
        viewController2 = nil
        viewController3 = nil
        
        super.tearDown()
    }


    // MARK: - Tests

    func testUnwrap() {
        let unwrappedValue = sut.base as? UINavigationController
        XCTAssertEqual(unwrappedValue, navigationController)
    }

    func testIsEqual() {
        let candidate = AnyNavigationStack(navigationController)
        XCTAssertEqual(sut, candidate)
    }

    func testNotEqual() {
        let candidate = AnyNavigationStack(UINavigationController())
        XCTAssertNotEqual(sut, candidate)
    }


    func testPresentation() {
        let expectation = self.expectation(description: "Call -present method.")
        navigationController.didCallPresentMethod = {
            expectation.fulfill()
        }

        sut.present(viewController1)

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }

    func testRootNavigation() {
        XCTAssertEqual(navigationController.topViewController, nil)

        let expectation = self.expectation(description: "Call -push method.")
        navigationController.didCallPushMethod = {
            expectation.fulfill()
        }

        sut.navigate(to: viewController1)

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }

    func testSuccessiveNavigation() {
        navigationController.viewControllers = [viewController1]
        XCTAssertEqual(navigationController.topViewController, viewController1)

        let expectation = self.expectation(description: "Call -push method.")
        navigationController.didCallPushMethod = {
            expectation.fulfill()
        }

        sut.navigate(to: viewController2)

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }

    func testInPlaceNavigation() {
        navigationController.viewControllers = [viewController1]
        XCTAssertEqual(navigationController.topViewController, viewController1)

        let expectation = self.expectation(description: "Call -pop method.")
        navigationController.didCallPopMethod = {
            expectation.fulfill()
        }

        sut.navigate(to: viewController1)

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }

    func testPreviousNavigation() {
        navigationController.viewControllers = [viewController1,
                                                viewController2,
                                                viewController3]
        XCTAssertEqual(navigationController.topViewController, viewController3)

        let expectation = self.expectation(description: "Call -pop method.")
        navigationController.didCallPopMethod = {
            expectation.fulfill()
        }

        sut.navigate(to: viewController1)

        waitForExpectations(timeout: 1) { (error) in
            guard let error = error else {
                return
            }
            XCTFail(error.localizedDescription)
        }
    }
}
