//
//  EffinArchitectureTests.swift
//  EffinArchitectureTests
//
//  Created by Cristian Patiño Rojas on 12/8/23.
//

import XCTest
@testable import EffinArchitecture


final class EffinArchitectureTests: XCTestCase {

    typealias SUTStack = (
        sut: ViewController,
        service: NetworkServiceMock,
        dependency: OtherDependencyMock,
        view: ViewMock
    )
    
    private var stack: SUTStack!
    
    override func setUp() {
        let sut = ViewController()
        let service = NetworkServiceMock()
        let dependency = OtherDependencyMock()
        let view = ViewMock()
        sut.service = service
        sut.dependency = dependency
        sut.rootView = view
        stack = (sut: sut, service: service, dependency: dependency, view: view)
    }
    
    override func tearDown() {
        stack = nil
    }
    
    func testExample() async throws {
        await stack.sut.loadData()
        let states = await stack.view.states
        XCTAssertEqual(states, [.loading, .success(["hello world"])])
        XCTAssertEqual(stack.dependency.someAsyncMethodCallCount, 1)
    }
}

extension View.State: Equatable {
    public static func == (lhs: View.State, rhs: View.State) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.error(let lhsMessage), .error(let rhsMessage)): return lhsMessage == rhsMessage
        case (.success(let lhsData), .success(let rhsData)): return lhsData == rhsData
        default: return false
        }
    }
}

final class ViewMock: View {
    var states = [View.State]()
    override func updateState(_ state: View.State) {
        states.append(state)
    }
}

final class OtherDependencyMock: OtherDependencyProtocol {
    var someAsyncMethodCallCount = 0
    func someAsyncMethod() async { someAsyncMethodCallCount += 1 }
}

final class NetworkServiceMock: NetworkService {
    override func fetchData() async throws -> [String] {
        return ["hello world"]
    }
}
