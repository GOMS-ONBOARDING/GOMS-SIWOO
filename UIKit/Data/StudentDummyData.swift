//
//  StudentDummyData.swift
//  UIKit
//
//  Created by 이시우 on 9/10/26.
//

import Foundation

enum StudentDummyData {
    static let students: [Student] = [
        Student(name: "김준표", studentNumber: "2302", status: .inSchool),
        Student(
            name: "이찬진",
            studentNumber: "2310",
            status: .outing,
            expectedReturnTime: Date().addingTimeInterval(60 * 60)
        ),
        Student(name: "이진서", studentNumber: "2311", status: .inSchool)
    ]
}
