//
//  ViewModel.swift
//  CombineExample
//
//  Created by gaeng on 2023/05/01.
//

import Combine

final class ViewModel: ViewModelType {
    struct Input {
        let userName: AnyPublisher<String?, Never>
        let password: AnyPublisher<String?, Never>
        let passwordConfirm: AnyPublisher<String?, Never>
    }
    
    struct Output {
        let buttonIsValid: AnyPublisher<Bool, Never>
    }
    
    func transform(input: Input) -> Output {
        let buttonStatePublisher = input.userName
            .combineLatest(input.password, input.passwordConfirm)
            .map { user, password, passwordConfirm in
                user?.count > 4 &&
                password?.count >= 6 &&
                passwordConfirm == password
            }
            .eraseToAnyPublisher()
        
        return Output(buttonIsValid: buttonStatePublisher)
    }
}
