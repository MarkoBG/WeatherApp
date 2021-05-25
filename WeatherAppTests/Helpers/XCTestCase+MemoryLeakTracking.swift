//
//  XCTestCase+MemoryLeakTracking.swift
//  WeatherAppTests
//
//  Created by Marko Tribl on 3/27/21.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should be deallocated from memory.", file: file, line: line)
        }
    }
}
