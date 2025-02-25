//
//  MyPageView.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//


import SwiftUI

struct MyPageView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    Link(destination: URL(string: Config.privateInfoURL)!) {
                        HStack {
                            Text("개인정보 처리방침")
                            Spacer()

                        }
                    }
                }
                
                Section {
                    HStack {
                        Text("버전")
                        Spacer()
                        Text(appVersion)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("마이페이지")
        }
    }
}
