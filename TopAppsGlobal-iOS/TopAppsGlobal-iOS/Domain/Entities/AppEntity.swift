//
//  AppEntity.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

struct AppEntity: Identifiable {
    let id: String
    let name: String
    let developer: String
    let category: String
    let imageUrl: String
    let summary: String
    let releaseDate: String
    let appStoreUrl: String
    let price: String
}
