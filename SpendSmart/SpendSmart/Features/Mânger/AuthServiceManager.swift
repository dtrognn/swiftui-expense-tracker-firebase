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
        self.apiSignUp(email: email, password: password, fullname: fullname, completion: completion)
    }

    func signIn(email: String, password: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        self.apiSignIn(email: email, password: password, completion: completion)
    }

    func getUserInfo(completion: @escaping (Result<User?, Error>) -> Void) {
        self.apiGetUserInfo(completion: completion)
    }

    func updateUserInfo(_ user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        apiUpdateUserInfo(user, completion: completion)
    }

    func signOut(completion: @escaping (Result<Void, Error>) -> Void) {
        self.apiSignOut(completion: completion)
    }

    private func apiSignUp(email: String, password: String, fullname: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
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

    private func apiSignIn(email: String, password: String, completion: @escaping (Result<FirebaseAuth.User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let user = authResult?.user {
                self?.userSesstion = user
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }

    private func apiGetUserInfo(completion: @escaping (Result<User?, Error>) -> Void) {
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

    private func apiUpdateUserInfo(_ user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        try? FIRUsersCollection.document(user.uid).updateData(user.asDictionary()) { [weak self] error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    private func apiSignOut(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            self.userSesstion = nil
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
