//
// Copyright © 2018 Beilmo. All rights reserved. 
// See LICENSE for this file’s licensing information.
//


import Foundation
@testable import Toolkit


protocol CustomInitializableProtocol: Initializable {
    var name: String { get }
}

enum CustomInitializableNameOption: String {
    case `default` = ""
    case new = "new"
}

struct InitializableStruct: CustomInitializableProtocol {

    var name: String

    init() {
        name = ""
    }

    static func makeNewInstance(_ name: String) -> InitializableStruct {
        let newInstance = InitializableStruct { (instance) in
            instance.name = name
        }

        return newInstance
    }

}

class InitializableClass: CustomInitializableProtocol {

    var name: String

    required init() {
        name = ""
    }

    static func makeNewInstance(_ name: String) -> InitializableClass {
        let newInstance = InitializableClass { (instance) in
            instance.name = name
        }

        return newInstance
    }

}


final class InitializableFinalClass: CustomInitializableProtocol {

    var name: String

    required init() {
        name = ""
    }

    static func makeNewInstance(_ name: String) -> InitializableFinalClass {
        let newInstance = InitializableFinalClass { (instance) in
            instance.name = name
        }

        return newInstance
    }

}

class InitializableObjCClass: NSObject & CustomInitializableProtocol {

    var name: String

    required override init() {
        name = ""
    }

    static func makeNewInstance(_ name: String) -> InitializableObjCClass {
        let newInstance = InitializableObjCClass({ new in
            new.name = name
        })

        return newInstance
    }

}
