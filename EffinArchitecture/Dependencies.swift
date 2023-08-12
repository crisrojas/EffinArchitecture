//
//  Dependencies.swift
//  EffinArchitecture
//
//  Created by Cristian Patiño Rojas on 12/8/23.
//

import Foundation

/// A class dependency, mocked through inheritance
class NetworkService {
    func fetchData() async throws -> [String] {
        try await Task.sleep(seconds: 3)
        return Array(0...10).map { $0.description }
    }
}

/// A protocol dependency, mocked through conformance
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
