//
//  Student.swift
//  UIKit
//
//  Created by 이시우 on 9/10/26.
//

import Foundation

struct Student: Hashable { // Identifiable는 UIKit에서 UITableView를 사용하면 IndexPath로 배열의 데이터를 직접 가져오기 때문에 필수는 아님
    let id: UUID
    let name: String
    let studentNumber: String
    var status: StudentStatus

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

enum StudentStatus: String { // 상태값을 제한하기 위해서 enum으로 오타나 잘못된 상태값을 막을 수 있음
    case inSchool = "교내"
    case outing = "외출"
}
