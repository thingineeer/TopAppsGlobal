//
//  MainView.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import SwiftUI

struct AppStoreRankView: View {
    
    // MARK: - Properties

    @StateObject private var viewModel: AppStoreViewModel
    @State private var selectedCountry = 0
    
    let countries = ["🇰🇷 한국", "🇯🇵 일본", "🇺🇸 미국"]
    
    init() {
        _viewModel = StateObject(wrappedValue: AppStoreViewModelFactory.create())
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {  // spacing을 0으로 설정
                Picker("국가 선택", selection: $selectedCountry) {
                    ForEach(0..<countries.count, id: \.self) { index in
                        Text(countries[index])
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                ZStack {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                    
                    List {
                        ForEach(Array(viewModel.apps.enumerated()), id: \.element.id) { index, app in
                            AppRowView(app: app, rank: index + 1)
                        }
                    }
                    .onChange(of: selectedCountry) { newValue in
                        Task {
                            await viewModel.fetchApps(for: newValue)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.fetchApps(for: selectedCountry)
                    }
                    .opacity(viewModel.isLoading ? 0 : 1)
                }
            }
            .navigationTitle("앱스토어 순위")
            .task {
                await viewModel.fetchApps(for: selectedCountry)
            }
            .alert("에러", isPresented: $viewModel.showError) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

// MARK: - 앱 행 뷰
struct AppRowView: View {
    let app: AppEntity
    let rank: Int
    
    var body: some View {
        NavigationLink(destination: AppDetailView(app: app)) {
            HStack(spacing: 16) {
                Text("\(rank)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(width: 30)
                
                AsyncImage(url: URL(string: app.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(width: 60, height: 60)
                .cornerRadius(12)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(app.name)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(app.developer)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Text(app.category)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    AppStoreRankView()
}
