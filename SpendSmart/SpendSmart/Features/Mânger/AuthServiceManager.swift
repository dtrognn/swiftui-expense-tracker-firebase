//
//  AuthenticationManager.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AuthServiceManager: BaseViewModel {
    static let shared = AuthServiceManager()

    override private init() {}

    func signUp(email: String, password: String, fullname: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                completion(.failure(error!))
                return
            }

            let newUser = User(email: email, fullname: fullname)
            try? FIRUsersCollection.document(newUser.uid).setData(newUser.asDictionary()) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(user))
                }
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let user = authResult?.user {
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
