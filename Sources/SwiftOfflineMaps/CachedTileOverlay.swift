//
//  CachedTileOverlay.swift
//
//
//  Created by krisna pranav on 16/09/23.
//

import Foundation
import MapKit

open class CachedTileOverlay: MKTileOverlay {
    let offlineMaps: OfflineProtocol
    
    public var useCache: Bool = true
    
    public init(withCache cache: OfflineProtocol) {
        offlineMaps = cache
        super.init(urlTemplate: offlineMaps.config.urlTemplate)
    }
    
    override public func url(forTilePath path: MKTileOverlayPath) -> URL {
        return offlineMaps.url(forTilePath: path)
    }
    
    override public func loadTile(at path: MKTileOverlayPath, result: @escaping(Data?, Error?) -> Void) {
        if !self.useCache {
            return super.loadTile(at: path, result: result)
        } else {
            return offlineMaps.loadTile(at: path, result: result)
        }
    }
}
