//
//  InfoRowView.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import SwiftUI

struct InfoRowView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
}

#Preview {
    InfoRowView(title: "하이", value: "값")
}
