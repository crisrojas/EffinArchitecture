//
//  Utilities.swift
//  EffinArchitecture
//
//  Created by Cristian Patiño Rojas on 12/8/23.
//

import UIKit

extension UIView {
    func center(in view: UIView) {
        view.addSubview(self)
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

/// Owner of the tableView. Responsable to trigger its callbacks and provide dataSource
typealias UITableViewOwner = UITableViewDelegate & UITableViewDataSource
extension UITableView {
    func setOwner(_ owner: UITableViewOwner) {
        self.delegate = owner
        self.dataSource = owner
    }
}
extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
