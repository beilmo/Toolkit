//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import UIKit
@testable import Toolkit

class MockUINavigationController: UINavigationController {

    var didCallPresentMethod: (() -> Void)?
    var didCallPushMethod: (() -> Void)?
    var didCallPopMethod: (() -> Void)?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        super.present(viewControllerToPresent, animated: flag, completion: completion)
        didCallPresentMethod?()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        didCallPushMethod?()
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        let result = super.popToViewController(viewController, animated: animated)
        didCallPopMethod?()
        return result
    }

}
