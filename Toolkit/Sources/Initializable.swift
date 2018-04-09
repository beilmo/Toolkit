//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import Foundation

/// Convenience protocol that facilitates
/// the creation of protocol extension init functions.
public protocol Initializable {

    /// Default constructor
    init()
}

public extension Initializable {

    /// Convenience initializer that uses a customization block
    /// to update the newly created instance.
    ///
    /// - Parameter block: configuration block
    public init(_ block: ((inout Self) -> Void)) {
        self.init()
        block(&self)
    }

}
