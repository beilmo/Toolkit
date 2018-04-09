//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import Foundation
@testable import Toolkit

class MockNavigatorStack: NavigationStack {

    typealias Element = UIViewController

    var didCallNavigate: (() -> Void)?
    var didCallPresent: (() -> Void)?


    static func == (lhs: MockNavigatorStack, rhs: MockNavigatorStack) -> Bool {
        return true
    }

    func navigate(to element: UIViewController, completion: (() -> Void)?) {
        didCallNavigate?()
    }

    func present(_ element: UIViewController, completion: (() -> Void)?) {
        didCallPresent?()
    }
}
