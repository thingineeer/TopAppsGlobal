//
//  AppType.swift
//  TopAppsGlobal-iOS
//
//  Created by 이명진 on 2/24/25.
//

import Foundation

enum AppType {
    case free
    case paid
    case my
    
    var title: String {
        switch self {
        case .free: return "무료 앱 순위"
        case .paid: return "유료 앱 순위"
        case .my: return "마이페이지"
        }
    }
}
