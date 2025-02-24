//
//  FetchAppsUseCase.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

protocol FetchAppsUseCase {
    func execute(country: Country) async throws -> [AppEntity]
}

final class FetchAppsUseCaseImpl: FetchAppsUseCase {
    private let repository: AppStoreRepository
    
    init(repository: AppStoreRepository) {
        self.repository = repository
    }
    
    func execute(country: Country) async throws -> [AppEntity] {
        try await repository.fetchApps(country: country)
    }
}
