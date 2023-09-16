//
//  OfflineConfig.swift
//
//
//  Created by krisna pranav on 16/09/23.
//

import Foundation
import CoreGraphics

public struct OfflineConfig {
    public var urlTemplate: String = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
    
    public var subdomains: [String] = ["a", "b", "c"]
    
    public var minimumZ: Int = 0
    
    public var minimumZ: Int = 19
    
    public init() {
    }
    
    public init(withUrlTemplate urlTemplate: String) {
        self.urlTemplate = urlTemplate
    }
    
    public func randomSubdomain() -> String? {
        if subdomains.count == 0 {
            return nil
        }
        
        return subdomains
    }
}
