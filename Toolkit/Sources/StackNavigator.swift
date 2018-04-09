//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import Foundation


/// A container that defines a stack-based scheme
/// for navigating hierarchical content.
public protocol StackNavigator: Navigator {

    associatedtype Element


    /// The navigation stack managed by the navigator.
    var stack: AnyNavigationStack<Element>? { get }


    /// Factory method designated to create the right end point `Element`
    /// given a specific destination.
    ///
    /// - Parameter destination: The specific target to be reached.
    /// - Returns: The corresponding end point item
    ///     associated to the specified destination.
    func makeElement(for destination: Self.Destination) -> Self.Element
}

public extension Navigator where Self: StackNavigator {

    func navigate(to destination: Self.Destination, completion: (() -> Void)?) {
        let element = makeElement(for: destination)
        stack?.navigate(to: element, completion: completion)
    }

    func present(destination: Self.Destination, completion: (() -> Void)?) {
        let element = makeElement(for: destination)
        stack?.present(element, completion: completion)
    }

}
