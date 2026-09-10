//
//  Student.swift
//  UIKit
//
//  Created by 이시우 on 9/10/26.
//

import Foundation

struct Student: Hashable {
    let id: UUID
    let name: String
    let studentNumber: String
    let status: StudentStatus

    init(
        id: UUID = UUID(),
        name: String,
        studentNumber: String,
        status: StudentStatus
    ) {
        self.id = id
        self.name = name
        self.studentNumber = studentNumber
        self.status = status
    }
}

enum StudentStatus: String {
    case inSchool = "교내"
    case outing = "외출"
}
