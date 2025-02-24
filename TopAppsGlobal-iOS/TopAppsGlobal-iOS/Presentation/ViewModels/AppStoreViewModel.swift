//
//  AppStoreViewModel.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

@MainActor
final class AppStoreViewModel: ObservableObject {
    @Published var apps: [AppEntity] = []
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let fetchAppsUseCase: FetchAppsUseCase
    
    init(fetchAppsUseCase: FetchAppsUseCase) {
        self.fetchAppsUseCase = fetchAppsUseCase
    }
    
    func fetchApps(for countryIndex: Int) async {
        guard let country = Country(rawValue: countryIndex) else { return }
        
        isLoading = true
        do {
            apps = try await fetchAppsUseCase.execute(country: country)
            isLoading = false
        } catch {
            isLoading = false
            showError = true
            errorMessage = error.localizedDescription
        }
    }
}
