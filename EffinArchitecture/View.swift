//
//  View.swift
//  EffinArchitecture
//
//  Created by Cristian Patiño Rojas on 12/8/23.
//

import UIKit

class View: UIView {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        return activity
    }()
    
    private lazy var errorView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Error"
        return label
    }()
    
    enum State {
        case loading
        case success([String])
        case error(String)
        
        var datasource: [String]? {
            if case .success(let data) = self {
                return data
            }
            return nil
        }
    }
    
    private var state: State = .loading {didSet {updateUI()}}
    var datasource: [String]? { state.datasource }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .white
        tableView.setOwner(self)
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        loaderView.center(in: self)
        errorView.center(in: self)
    }
    
    func updateState(_ state: State) {
        self.state = state
    }
    
    private func updateUI() {
        switch state {
        case .loading:
            errorView.isHidden = true
            loaderView.isHidden = false
            tableView.isHidden = true
        case .success(_):
            loaderView.isHidden = true
            errorView.isHidden = true
            tableView.reloadData()
            tableView.isHidden = false
        case .error(let message):
            errorView.text = message
            errorView.isHidden = false
            loaderView.isHidden = true
            tableView.isHidden = true
        }
    }
}

extension View: UITableViewOwner {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        datasource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = datasource?[indexPath.row]
        return cell ?? .init()
    }
}
