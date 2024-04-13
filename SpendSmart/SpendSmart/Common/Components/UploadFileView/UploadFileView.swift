//
//  UploadFileView.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import SwiftUI

struct UploadFileView<Content: View>: View {
    private var content: () -> Content
    private var onImageResult: ((UIImage?) -> Void)?

    @State private var showOption = false
    @State private var showCamera = false
    @State private var showPhotoLibrary = false

    init(content: @escaping () -> Content, onImageResult: ((UIImage?) -> Void)? = nil) {
        self.content = content
        self.onImageResult = onImageResult
    }

    var body: some View {
        Button {
            showOption = true
        } label: {
            content()
        }.actionSheet(isPresented: $showOption) {
            let title = Text("Upload_A_01")
            let buttons: [ActionSheet.Button] = [
                .default(Text("Upload_A_02")) {
                    showCamera = true
                },
                .default(Text("Upload_A_03")) {
                    showPhotoLibrary = true
                },
                .cancel(Text("SS_Common_A_13"))
            ]
            return ActionSheet(title: title, buttons: buttons)
        }.sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera) { image in
                onImageResult?(image)
            }
        }.sheet(isPresented: $showPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary) { image in
                onImageResult?(image)
            }
        }
    }
}
