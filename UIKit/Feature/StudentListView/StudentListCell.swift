//
//  StudentListCell.swift
//  UIKit
//

import UIKit

final class StudentListCell: UITableViewCell {
    static let reuseIdentifier = "StudentListCell"

    private let cardView = UIView()
    private let nameLabel = UILabel()
    private let studentNumberLabel = UILabel()
    private let statusLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with student: Student) {
        nameLabel.text = student.name
        studentNumberLabel.text = student.studentNumber
        statusLabel.text = student.status.rawValue
        statusLabel.backgroundColor = student.status == .outing
            ? .systemOrange.withAlphaComponent(0.16)
            : .systemGreen.withAlphaComponent(0.16)
    }
}

private extension StudentListCell {
    func configureAppearance() {
        selectionStyle = .none
        backgroundColor = .clear

        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 14

        nameLabel.font = .preferredFont(forTextStyle: .headline)
        studentNumberLabel.font = .preferredFont(forTextStyle: .subheadline)
        studentNumberLabel.textColor = .secondaryLabel

        statusLabel.font = .preferredFont(forTextStyle: .caption1)
        statusLabel.textAlignment = .center
        statusLabel.layer.cornerRadius = 14
        statusLabel.clipsToBounds = true
    }

    func configureLayout() {
        let textStack = UIStackView(arrangedSubviews: [nameLabel, studentNumberLabel])
        textStack.axis = .vertical
        textStack.spacing = 4

        [cardView, textStack, statusLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        contentView.addSubview(cardView)
        cardView.addSubview(textStack)
        cardView.addSubview(statusLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            textStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            textStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),

            statusLabel.leadingAnchor.constraint(greaterThanOrEqualTo: textStack.trailingAnchor, constant: 12),
            statusLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            statusLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            statusLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 48),
            statusLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}
