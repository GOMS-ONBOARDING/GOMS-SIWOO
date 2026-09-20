//
//  StudentListView.swift
//  UIKit
//
//  Created by 이시우 on 9/11/26.
//

import UIKit

final class StudentListViewController: UIViewController {
    private var students = StudentDummyData.students

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 96
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "학생 목록"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StudentListCell.self, forCellReuseIdentifier: StudentListCell.reuseIdentifier)

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let visibleIndexPaths = tableView.indexPathsForVisibleRows ?? []
        guard !visibleIndexPaths.isEmpty else {
            return
        }

        tableView.reloadRows(at: visibleIndexPaths, with: .none)
    }
}

extension StudentListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StudentListCell.reuseIdentifier,
            for: indexPath
        ) as? StudentListCell else {
            return UITableViewCell()
        }

        cell.configure(with: students[indexPath.row])
        return cell
    }
}

extension StudentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = students[indexPath.row]
        let detailViewController = StudentDetailViewController(student: student) { [weak self] updatedStudent in
            guard let self,
                  let updatedIndex = self.students.firstIndex(where: { $0.id == updatedStudent.id }) else {
                return
            }

            self.students[updatedIndex] = updatedStudent
            self.tableView.reloadRows(at: [IndexPath(row: updatedIndex, section: 0)], with: .none)
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
