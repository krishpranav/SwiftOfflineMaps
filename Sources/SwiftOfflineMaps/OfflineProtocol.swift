//
//  OfflineProtocol.swift
//
//
//  Created by krisna pranav on 16/09/23.
//

import Foundation
import MapKit

public protocol OfflineProtocol {
    var config: OfflineConfig { get set }

    func url(forTilePath path: MKTileOverlayPath) -> URL
    
    func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void)
    
}
