//
//  ViewModelType.swift
//  CombineExample
//
//  Created by gaeng on 2023/05/03.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
