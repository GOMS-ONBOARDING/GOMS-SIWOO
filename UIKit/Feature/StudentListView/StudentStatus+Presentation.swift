//
//  StudentStatus+Presentation.swift
//  UIKit
//

import UIKit

enum StudentListStatusPresentation {
    case inSchool
    case outing
    case late

    var title: String {
        switch self {
        case .inSchool:
            return "교내"
        case .outing:
            return "외출"
        case .late:
            return "지각"
        }
    }

    var badgeBackgroundColor: UIColor {
        switch self {
        case .inSchool:
            return .systemGreen.withAlphaComponent(0.16)
        case .outing:
            return .systemOrange.withAlphaComponent(0.16)
        case .late:
            return .systemRed.withAlphaComponent(0.16)
        }
    }
}

extension Student {
    var listStatusPresentation: StudentListStatusPresentation {
        switch status {
        case .inSchool:
            return .inSchool
        case .outing:
            return isLate ? .late : .outing
        }
    }
}
