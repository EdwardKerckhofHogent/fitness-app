//
//  Auth.swift
//  fitness-app-ios
//
//  Created by Edward Kerckhof on 10/12/2019.
//  Copyright © 2019 Edward Kerckhof. All rights reserved.
//
import SwiftKeychainWrapper
import Foundation
import Apollo

class Auth {
    let accessTokenKey = "accessToken"
    let userIdKey = "userId"
    var client: ApolloClient?
    
    func login(email: String, password: String, completion: @escaping(Result<String, Error>) -> Void) {
        client = NetworkManager.shared.apollo
        client!.perform(mutation: LoginMutation(input: UserInput.init(password: password, email: email))) { result in
            guard let data = try? result.get().data?.login else {
                print("UNRESOLVER")
                completion(.failure(CustomError(title: "User Login Error", descr: "Server Error")))
                return
            }
            if ((data.errors?[0]) != nil) {
                completion(.failure(CustomError(title: "Fetch Error", descr: data.errors![0].message)))
            } else {
                completion(.success(data.accessToken!))
                KeychainWrapper.standard.set(data.accessToken!, forKey: self.accessTokenKey)
                KeychainWrapper.standard.set(data.user!.id, forKey: self.userIdKey)
            }
        }
    }

    func logout(completion: @escaping(Result<Bool, Error>) -> Void) {
        client = NetworkManager.shared.apollo
        client!.perform(mutation: LogoutMutation(userId: KeychainWrapper.standard.double(forKey: userIdKey)!)) { result in
            guard let _ = try? result.get().data else {
                completion(.failure(CustomError(title: "User Logout Error", descr: "Server Error")))
                return
            }
            completion(.success(true))
            NetworkManager.shared.setApolloClient(accessToken: nil)
            KeychainWrapper.standard.removeObject(forKey: self.accessTokenKey)
            KeychainWrapper.standard.removeObject(forKey: self.userIdKey)
        }
    }
}
