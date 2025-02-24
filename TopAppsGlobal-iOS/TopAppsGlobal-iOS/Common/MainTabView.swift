//
//  MainTabView.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            AppStoreRankView(appType: .free)
                .tabItem {
                    Label("무료", systemImage: "gift")
                }
            
            AppStoreRankView(appType: .paid)
                .tabItem {
                    Label("유료", systemImage: "creditcard")
                }
        }
    }
}
