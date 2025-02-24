//
//  Factory.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

final class AppStoreViewModelFactory {
    @MainActor
    static func create() -> AppStoreViewModel {
        let repository = AppStoreRepositoryImpl()
        let useCase = FetchAppsUseCaseImpl(repository: repository)
        return AppStoreViewModel(fetchAppsUseCase: useCase)
    }
}
