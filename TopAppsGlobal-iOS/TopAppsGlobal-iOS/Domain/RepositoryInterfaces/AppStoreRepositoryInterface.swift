//
//  AppStoreRepositoryInterface.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

protocol AppStoreRepository {
    func fetchApps(country: Country, appType: AppType) async throws -> [AppEntity]
}

enum Country: Int {
    case korea = 0
    case japan = 1
    case usa = 2
    
    var code: String {
        switch self {
        case .korea: return "kr"
        case .japan: return "jp"
        case .usa: return "us"
        }
    }
}
