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

    @Published var userSesstion: FirebaseAuth.User?

    private var firestore = Firestore.firestore()

    func loadUser() {
        self.userSesstion = Auth.auth().currentUser
    }

    func signUp(email: String, password: String, fullname: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let user = authResult?.user, error == nil else {
                completion(.failure(error!))
                return
            }

            self?.userSesstion = user

            let newUser = User(uid: user.uid, email: email, fullname: fullname)
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
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let user = authResult?.user {
                self?.userSesstion = user
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func getUserInfo(completion: @escaping (Result<User?, Error>) -> Void) {
        guard let uid = userSesstion?.uid else { return }

        let docRef = FIRUsersCollection.document(uid)
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                if let user = self.firestore.decode(User.self, from: document) {
                    completion(.success(user))
                } else if let error = error {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            self.userSesstion = nil
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
