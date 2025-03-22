//
//  ViewModel.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Foundation

@MainActor
public protocol ViewModel: ObservableObject {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    
    var state: State { get }
    func send(_ action: Action) async
}
