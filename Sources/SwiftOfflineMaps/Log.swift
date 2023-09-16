//
//  Log.swift
//  
//
//  Created by krisna pranav on 16/09/23.
//

import Foundation

public struct Log {
    
    fileprivate static let tag = "[SwiftOfflineMAps]"

    fileprivate enum Level : String {
        case Debug = "[DEBUG]"
        case Release = "[RELEASE]"
        case Error = "[ERROR]"
    }
    
    fileprivate static func log(_ level: Level, _ message: @autoclosure () -> String, _ error: Error? = nil) {
        if let error = error {
            print("\(tag)\(level.rawValue) \(message()) with error \(error)")
        } else {
            print("\(tag)\(level.rawValue) \(message())")
        }
    }
    
    static func debug(message: @autoclosure () -> String, error: Error? = nil) {
        #if DEBUG
        log(.Debug, message(), error)
        #endif
    }

    static func error(message: @autoclosure () -> String, error: Error? = nil) {
        log(.Error, message(), error)
    }
    
}
