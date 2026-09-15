//
//  StudentDetailViewController.swift
//  UIKit
//

import UIKit

final class StudentDetailViewController: UIViewController {
    private let student: Student

    init(student: Student) {
        self.student = student
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "학생 상세"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        configureLayout()
    }
}

private extension StudentDetailViewController {
    func configureLayout() {
        let infoStack = UIStackView(arrangedSubviews: [
            DetailInfoRow(title: "이름", value: student.name),
            DetailInfoRow(title: "학번", value: student.studentNumber),
            DetailInfoRow(title: "현재 상태", value: student.status.rawValue)
        ])
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        infoStack.axis = .vertical
        infoStack.spacing = 24

        view.addSubview(infoStack)
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

private final class DetailInfoRow: UIView {
    init(title: String, value: String) {
        super.init(frame: .zero)

        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .caption1)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title

        let valueLabel = UILabel()
        let title3Font = UIFont.preferredFont(forTextStyle: .title3)
        valueLabel.font = .systemFont(ofSize: title3Font.pointSize, weight: .semibold)
        valueLabel.text = value

        let stack = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 6

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
