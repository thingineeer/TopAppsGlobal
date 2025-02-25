//
//  AppDetailView.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import SwiftUI

// MARK: - 상세 뷰
struct AppDetailView: View {
    let app: AppEntity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 16) {
                    AsyncImage(url: URL(string: app.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.2))
                    }
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(app.name)
                            .font(.title2)
                            .bold()
                        
                        Text(app.developer)
                            .foregroundColor(.secondary)
                        
                        Text(app.category)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            if let url = URL(string: app.appStoreUrl),
                               UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            Text("보러가기")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .background(Color.blue)
                                .cornerRadius(16)
                        }
                    }
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("설명")
                        .font(.title3)
                        .bold()
                    
                    Text(app.summary)
                        .lineLimit(5)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("정보")
                        .font(.title3)
                        .bold()
                    
                    InfoRowView(title: "가격", value: app.price)
                    InfoRowView(title: "개발자", value: app.developer)
                    InfoRowView(title: "카테고리", value: app.category)
                    InfoRowView(title: "출시일", value: app.releaseDate)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
