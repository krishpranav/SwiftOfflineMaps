//
//  CachedTileOverlay.swift
//
//
//  Created by krisna pranav on 16/09/23.
//

import Foundation
import MapKit

open class CachedTileOverlay : MKTileOverlay {
    
    let offlineMaps : OfflineProtocol
    
    public var useCache: Bool = true
    
    public init(withCache cache: OfflineProtocol) {
        offlineMaps = cache
        super.init(urlTemplate: offlineMaps.config.urlTemplate)
    }
    
    override public func url(forTilePath path: MKTileOverlayPath) -> URL {
        return offlineMaps.url(forTilePath: path)
    }
    
    override public func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        if !self.useCache {
            return super.loadTile(at: path, result: result)
        } else {
            return offlineMaps.loadTile(at: path, result: result)
        }
    }
    
    func shouldZoom(at scale: MKZoomScale) -> Bool {
        guard offlineMaps.config.overZoomMaximumZ else { return false }
        return scale.toZoomLevel(tileSize: offlineMaps.config.tileSize) > mapCache.config.maximumZ
    }
    
    func tilesInMapRect(rect: MKMapRect, scale: MKZoomScale) -> [ZoomableTile] {
        var tiles: [ZoomableTile] = []
        let tileSize = offlineMaps.config.tileSize
        var z = scale.toZoomLevel(tileSize: tileSize)
       
        var overZoom = 1
        let tileSetMaxZ = offlineMaps.config.maximumZ
        if (z > tileSetMaxZ) {
            overZoom = Int(pow(2.0, Double(z - tileSetMaxZ)))
            z = tileSetMaxZ
        }
        
        let adjustedTileSize = Double(overZoom * Int(tileSize.width))
        
        let minX = Int(floor((rect.minX * Double(scale)) / adjustedTileSize))
        let maxX = Int(floor((rect.maxX * Double(scale)) / adjustedTileSize))
        let minY = Int(floor((rect.minY * Double(scale)) / adjustedTileSize))
        let maxY = Int(floor((rect.maxY * Double(scale)) / adjustedTileSize))
        
        for x in minX ... maxX {
            for y in minY ... maxY {
                
                let point = MKMapPoint(x: (Double(x) * adjustedTileSize) / Double(scale),
                                       y: (Double(y) * adjustedTileSize) / Double(scale))
                let size = MKMapSize(width: adjustedTileSize / Double(scale),
                                     height: adjustedTileSize / Double(scale))
                let tileRect = MKMapRect(origin: point, size: size)
                
                guard rect.intersects(tileRect) else { continue }
                
                let path =  MKTileOverlayPath(x: x, y: y, z: z, contentScaleFactor: scale)
                let tile = ZoomableTile(maximumZPath: path, rect: tileRect, overZoom: overZoom)
                tiles.append(tile)
            }
        }
        return tiles
    }
}
