//
//  OfflineConfig.swift
//
//
//  Created by krisna pranav on 16/09/23.
//


import Foundation
import CoreGraphics


public struct OfflineConfig  {
    
    public var urlTemplate: String = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
    
    public var subdomains: [String] = ["a","b","c"]
    
    public var minimumZ: Int = 0
    
    public var maximumZ: Int = 19

    public var overZoomMaximumZ: Bool = true
    
    public var cacheName: String = "OfflineMaps"
    
    public var capacity: UInt64 = UINT64_MAX

    public var tileSize: CGSize = CGSize(width: 256, height: 256)
    
    public var loadTileMode: LoadTileMode = .cacheThenServer

    public init() {
    }
    
    public init(withUrlTemplate urlTemplate: String)  {
        self.urlTemplate = urlTemplate
    }
    
    public func randomSubdomain() -> String? {
        if subdomains.count == 0 {
            return nil
        }
        let rand = Int(arc4random_uniform(UInt32(subdomains.count)))
        return subdomains[rand]
    }
    
    private var subdomainRoundRobin: Int = 0
    
    public mutating func roundRobinSubdomain() -> String? {
        if subdomains.count == 0 {
            return nil
        }
        self.subdomainRoundRobin = (self.subdomainRoundRobin + 1)  % subdomains.count
        return subdomains[subdomainRoundRobin]
    }
}
