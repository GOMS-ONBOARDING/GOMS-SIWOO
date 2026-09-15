//
//  StudentStatus+Presentation.swift
//  UIKit
//

import UIKit

extension StudentStatus {
    var badgeBackgroundColor: UIColor {
        switch self {
        case .inSchool:
            return .systemGreen.withAlphaComponent(0.16)
        case .outing:
            return .systemOrange.withAlphaComponent(0.16)
        }
    }
}
