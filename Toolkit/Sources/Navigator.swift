//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import Foundation

/// Dedicated navigation type who's single purpose is
/// to move towards a given destination.
public protocol Navigator {

    associatedtype Destination


    /// Transitions to the destination item.
    ///
    /// - Parameters:
    ///     - destination: targeted endpoint
    ///     - completion: optional block to be executed after the presentation
    func navigate(to destination: Self.Destination, completion: (() -> Void)?)


    /// Displays the destination item in a modal way.
    ///
    /// - Parameters:
    ///   - destination: targeted endpoint
    ///   - completion: optional block to be executed after the presentation
    func present(destination: Self.Destination, completion: (() -> Void)?)

}
