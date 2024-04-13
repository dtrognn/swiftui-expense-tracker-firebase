//
//  StorageManager.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import FirebaseStorage
import UIKit

class StorageManager: BaseViewModel {
    static let shared = StorageManager()

    func updateImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        apiUploadImage(image, completion: completion)
    }

    private func apiUploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            return completion(.failure(UploadError.invalidImageData))
        }

        let storageRef = Storage.storage().reference().child("avatars/\(UUID().uuidString).jpg")
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            storageRef.downloadURL { [weak self] url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }
}

enum UploadError: Error {
    case invalidImageData
}
