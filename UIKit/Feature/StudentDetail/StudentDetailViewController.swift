//
//  StudentDetailViewController.swift
//  UIKit
//

import UIKit

final class StudentDetailViewController: UIViewController {
    private var student: Student
    private let onStatusChange: (Student) -> Void
    private let statusRow: DetailInfoRow
    private let returnTimeRow: DetailInfoRow
    private let latenessRow: DetailInfoRow
    private let statusSegmentedControl = UISegmentedControl(items: ["교내", "외출"])
    private let returnTimePicker = UIDatePicker()
    private let returnTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 HH:mm"
        return formatter
    }()

    init(student: Student, onStatusChange: @escaping (Student) -> Void) {
        self.student = student
        self.onStatusChange = onStatusChange
        self.statusRow = DetailInfoRow(title: "현재 상태", value: student.status.rawValue)
        self.returnTimeRow = DetailInfoRow(title: "복귀 예정", value: "설정 필요")
        self.latenessRow = DetailInfoRow(title: "지각 여부", value: "정상")
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
        configureStatusSegmentedControl()
        configureReturnTimePicker()
        configureLayout()
        updateStatusInformation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateStatusInformation()
    }
}

private extension StudentDetailViewController {
    func configureStatusSegmentedControl() {
        statusSegmentedControl.selectedSegmentIndex = student.status == .inSchool ? 0 : 1
        statusSegmentedControl.selectedSegmentTintColor = .systemBlue
        statusSegmentedControl.accessibilityLabel = "학생 상태 변경"
        statusSegmentedControl.addTarget(self, action: #selector(statusDidChange), for: .valueChanged)
    }

    func configureReturnTimePicker() {
        returnTimePicker.datePickerMode = .dateAndTime
        returnTimePicker.preferredDatePickerStyle = .compact
        returnTimePicker.locale = Locale(identifier: "ko_KR")
        returnTimePicker.accessibilityLabel = "복귀 예정 시간"
        returnTimePicker.addTarget(self, action: #selector(returnTimeDidChange), for: .valueChanged)
    }

    func configureLayout() {
        let infoStack = UIStackView(arrangedSubviews: [
            DetailInfoRow(title: "이름", value: student.name),
            DetailInfoRow(title: "학번", value: student.studentNumber),
            statusRow,
            returnTimeRow,
            latenessRow
        ])
        infoStack.axis = .vertical
        infoStack.spacing = 24

        let contentStack = UIStackView(arrangedSubviews: [
            infoStack,
            statusSegmentedControl,
            returnTimePicker
        ])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.spacing = 32

        view.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    @objc func statusDidChange() {
        switch statusSegmentedControl.selectedSegmentIndex {
        case 0:
            student.status = .inSchool
            student.expectedReturnTime = nil
        default:
            student.status = .outing
            student.expectedReturnTime = Date().addingTimeInterval(60 * 60)
        }

        updateStatusInformation()
        onStatusChange(student)
    }

    @objc func returnTimeDidChange() {
        student.expectedReturnTime = returnTimePicker.date
        updateStatusInformation()
        onStatusChange(student)
    }

    func updateStatusInformation() {
        statusRow.update(value: student.status.rawValue)

        switch student.status {
        case .inSchool:
            returnTimeRow.isHidden = true
            latenessRow.isHidden = true
            returnTimePicker.isHidden = true
        case .outing:
            returnTimeRow.isHidden = false
            latenessRow.isHidden = false
            returnTimePicker.isHidden = false

            if let expectedReturnTime = student.expectedReturnTime {
                returnTimePicker.date = expectedReturnTime
                returnTimeRow.update(value: returnTimeFormatter.string(from: expectedReturnTime))
            } else {
                returnTimeRow.update(value: "설정 필요")
            }

            latenessRow.update(value: student.isLate ? "지각" : "정상")
        }
    }
}

private final class DetailInfoRow: UIView {
    private let valueLabel = UILabel()

    init(title: String, value: String) {
        super.init(frame: .zero)

        let titleLabel = UILabel()
        titleLabel.font = .preferredFont(forTextStyle: .caption1)
        titleLabel.textColor = .secondaryLabel
        titleLabel.text = title

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

    func update(value: String) {
        valueLabel.text = value
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
