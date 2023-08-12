//
//  ViewController.swift
//  EffinArchitecture
//
//  Created by Cristian Patiño Rojas on 12/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    var service = NetworkService()
    var dependency: OtherDependencyProtocol = OtherDependency()
    
    lazy var rootView = View()
    
    override func loadView() {
        view = rootView
    }
    override func viewWillAppear(_ animated: Bool) {
        Task { await loadData() }
    }
    
    func loadData() async {
        do {
            rootView.updateState(.loading)
            let dataSource = try await service.fetchData()
            rootView.updateState(.success(dataSource))
            await dependency.someAsyncMethod()
        } catch {
            rootView.updateState(.error(error.localizedDescription))
        }
    }
}
