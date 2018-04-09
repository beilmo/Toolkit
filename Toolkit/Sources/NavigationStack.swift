//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import Foundation


public protocol NavigationStack: Equatable {
    
    associatedtype Element


    /// Updates the `Element` that has to be visible on the top of the stack.
    ///
    /// - Parameters:
    ///   - element: The `Element` that you want to be at the top
    ///     of the stack. This `Element` is not required to be
    ///     on the navigation stack. If present, the stack will discard all the
    ///     elements ontop of it, and if not, it will add the new `Element`
    ///     to the top.
    func navigate(to element: Self.Element, completion: (() -> Void)?)


    /// Presents the associated `Element` modally.
    ///
    /// - Parameters:
    ///   - element: The view element to display over the current one.
    ///   - completion: The block to execute after the presentation finishes.
    ///     This block has no return value and takes no parameters.
    ///     You may specify nil for this parameter.
    func present(_ element: Self.Element, completion: (() -> Void)?)

}

internal protocol _AnyNavigationStackBox {

    var _base: Any { get }

    var _navigate: ((Any, (() -> Void)?) -> Void) { get }
    var _present: ((Any, (() -> Void)?) -> Void) { get }

    func _unbox<T>() -> T? where T : NavigationStack

    /// Determine whether values in the boxes are equivalent.
    ///
    /// - Returns: `nil` to indicate that the boxes store different types, so
    ///   no comparison is possible. Otherwise, contains the result of `==`.
    func _isEqual(to: _AnyNavigationStackBox) -> Bool?
}

internal struct _ConcreteNavigationStackBox<Base: NavigationStack> {

    let _baseNavigationStack: Base

    internal init(_ base: Base) {
        _baseNavigationStack = base
    }
}

extension _ConcreteNavigationStackBox: _AnyNavigationStackBox {

    internal var _base: Any {
        return _baseNavigationStack
    }

    var _navigate: ((Any, (() -> Void)?) -> Void) {
        return { input, closure in
            let element = input as! Base.Element
            self._baseNavigationStack.navigate(to: element, completion: closure)
        }
    }

    var _present: ((Any, (() -> Void)?) -> Void) {
        return { input, closure in
            let element = input as! Base.Element
            self._baseNavigationStack.present(element, completion: closure)
        }
    }

    internal func _unbox<T: NavigationStack>() -> T? {
        let interfaceCast = self as _AnyNavigationStackBox
        let concreteCast = interfaceCast as? _ConcreteNavigationStackBox<T>

        return concreteCast?._baseNavigationStack
    }

    internal func _isEqual(to rhs: _AnyNavigationStackBox) -> Bool? {
        if let rhs: Base = rhs._unbox() {
            return _baseNavigationStack == rhs
        }
        return false
    }

}

/// A type-erased `NavigationStack` value.
///
/// The `AnyNavigationStack` type forwards navigationStack operations
/// to an underlying navigationStack value, hiding its specific underlying type.
public struct AnyNavigationStack<U> {

    public typealias Element = U

    fileprivate let _box: _AnyNavigationStackBox


    /// Creates a type-erased `NavigationStack` value
    /// that wraps the given instance.
    ///
    /// Because the underlying types can be different,
    /// any two AnyNavigationStack instances do not compare as equal
    /// only if they have the same equal underlying type.
    ///
    /// - Parameter base: A navigationStack value to wrap.
    init<Base: NavigationStack>(_ base : Base) where Base.Element == U {
        _box = _ConcreteNavigationStackBox(base)
    }


    /// The value wrapped by this instance.
    ///
    /// The `base` property can be cast back to its original type using one of
    /// the casting operators (`as?`, `as!`, or `as`).
    ///
    ///     let anyStack = AnyNavigationStack(UINavigationController())
    ///     if let unwrappedStack = anyMessage.base as? UINavigationController {
    ///         print(unwrappedStack.self)
    ///     }
    ///     // Prints "UINavigationController"
    public var base: Any {
        return _box._base
    }
}

extension AnyNavigationStack: NavigationStack {

    public func navigate(to element: Element, completion: (() -> Void)? = nil) {
        _box._navigate(element, completion)
    }

    public func present(_ element: Element, completion: (() -> Void)? = nil) {
        _box._present(element, completion)
    }

}

extension AnyNavigationStack: Equatable {

    /// Returns a Boolean value indicating whether two type-erased
    /// NavigationStack instances wrap the same type and value.
    ///
    /// Two instances of `NavigationStack` compare as equal if and only if the
    /// underlying types have the same conformance to the `Equatable` protocol
    /// and the underlying values compare as equal.
    public static func == (lhs: AnyNavigationStack<U>,
                           rhs: AnyNavigationStack<U>) -> Bool {
        return lhs._box._isEqual(to: rhs._box) ?? false
    }

}

#if canImport(UIKit)

// MARK: - UINavigationController

import UIKit

extension UINavigationController: NavigationStack {

    public typealias Element = UIViewController


    public func navigate(to element: Element, completion: (() -> Void)? = nil) {
        // wrap the call in a CATransaction
        CATransaction.begin()

        // decide the right direction based on the curent hierarchy
        if viewControllers.contains(element) {
            popToViewController(element, animated: true)
        } else {
            pushViewController(element, animated: true)
        }

        // register completion
        CATransaction.setCompletionBlock({
            completion?()
        })

        // execute transaction
        CATransaction.commit()
    }

    public func present(_ element: Element, completion: (() -> Void)? = nil) {
        present(element, animated: true, completion: completion)
    }

}

#endif
