//
//  Dependencies.swift
//  EffinArchitecture
//
//  Created by Cristian Patiño Rojas on 12/8/23.
//

import Foundation

class NetworkService {
    func fetchData() async throws -> [String] {
        try await Task.sleep(seconds: 3)
        return Array(0...10).map { $0.description }
    }
}

final class OtherDependency: OtherDependencyProtocol {}

protocol OtherDependencyProtocol {
    func someAsyncMethod() async
}

extension OtherDependencyProtocol {
    func someAsyncMethod() async {
        try? await Task.sleep(seconds: 2)
        print("Finished")
    }
}
