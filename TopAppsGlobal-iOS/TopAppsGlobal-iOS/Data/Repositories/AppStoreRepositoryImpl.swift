//
//  AppStoreRepositoryImpl.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

final class AppStoreRepositoryImpl: AppStoreRepository {
    func fetchApps(country: Country) async throws -> [AppEntity] {
        guard let url = APIEndpoints.topFreeApps(country: country) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let dto = try JSONDecoder().decode(AppStoreResponseDTO.self, from: data)
        return dto.toDomain()
    }
}
