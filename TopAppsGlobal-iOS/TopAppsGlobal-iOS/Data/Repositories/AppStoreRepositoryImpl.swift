//
//  AppStoreRepositoryImpl.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation


class AppStoreRepositoryImpl: AppStoreRepository {
    func fetchApps(country: Country, appType: AppType) async throws -> [AppEntity] {
        let url: URL?
        
        switch appType {
        case .free:
            url = Config.URLGenerator.freeAppsURL(country: country)
        case .paid:
            url = Config.URLGenerator.paidAppsURL(country: country)
        case .my:
            return []
        }
        
        guard let url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        switch appType {
        case .free:
            let freeResponse = try JSONDecoder().decode(AppStoreResponseDTO.self, from: data)
            return freeResponse.toDomain()
        case .paid:
            let paidResponse = try JSONDecoder().decode(AppStoreResponseDTO.self, from: data)
            return paidResponse.toDomain()
        case .my:
            return []
        }
    }
}
