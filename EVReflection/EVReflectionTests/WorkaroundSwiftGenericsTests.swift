//
//  SwiftGenericsBug.swift
//  EVReflection
//
//  Created by Edwin Vermeer on 8/10/15.
//  Copyright (c) 2015 evict. All rights reserved.
//

import UIKit
import XCTest


/**
Testing the workaround for generics.
*/
class WorkaroundSwiftGenericsTests: XCTestCase {
    func testGenericsJson() {
        let json:String = "{\"test\":\"test\", \"data\":\"data\"}"
        let a = MyGenericObject<NSString>(json: json)
        XCTAssertEqual(a.test, "test", "test should contin test")
        XCTAssertEqual(a.data as! String, "data", "data should contin data")
    }
}

// Only put the generic properties in this class. put the rest in a base class
// Add the protocol EVGenericsKVC so that we still can have a setValue forUndefinedKey like we adr used to
public class MyGenericObject<T where T:NSObject>: MyGenericBase, EVGenericsKVC {
    var data: T = T()
    
    override public func setValue(value: AnyObject!, forUndefinedKey key: String) {
        switch key {
        case "data":
            data = value as! T
        default:
            println("---> setValue '\(value)' for key '\(key)' should be handled.")
        }
    }
}

// Put the rest of the properties in a base class like this. Otherwise you have to handle each in the setValue forUndefinedKey
public class MyGenericBase: EVObject {
    var test : String = ""
}


