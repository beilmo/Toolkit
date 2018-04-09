//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import Foundation
import UIKit
@testable import Toolkit


final class MockStackNavigator: StackNavigator {

    typealias Element = UIViewController

    enum Destination {
        case screen1
        case screen2
        case screen3

        func correnspondingColor() -> UIColor {
            switch self {

            case .screen1:
                return .red

            case .screen2:
                return .green

            case .screen3:
                return .blue

            }
        }
    }

    var didCallMakeMethod: (() -> Void)?

    var stack: AnyNavigationStack<UIViewController>? = nil

    init(mockNavigatorStack: MockNavigatorStack) {
        self.stack = AnyNavigationStack(mockNavigatorStack)
    }

}

extension UIViewController: Initializable {}

extension MockStackNavigator {

    func makeElement(for destination: MockStackNavigator.Destination) -> UIViewController {

        var element: UIViewController

        switch destination {

        case .screen1:
            element = UIViewController({ (i) in
                i.view.backgroundColor = destination.correnspondingColor()
            })

        case .screen2:
            element = UIViewController({ (i) in
                i.view.backgroundColor = destination.correnspondingColor()
            })

        case .screen3:
            element = UIViewController({ (i) in
                i.view.backgroundColor = destination.correnspondingColor()
            })

        }

        didCallMakeMethod?()

        return element
    }
}
