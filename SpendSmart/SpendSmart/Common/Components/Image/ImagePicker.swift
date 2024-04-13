//
//  ImagePicker.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private var onSelect: ((UIImage?) -> Void)?
    private var onFinish: (() -> Void)?

    init(sourceType: UIImagePickerController.SourceType, onSelect: ((UIImage?) -> Void)? = nil, onFinish: (() -> Void)? = nil) {
        self.sourceType = sourceType
        self.onSelect = onSelect
        self.onFinish = onFinish
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.onSelect?(image)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
