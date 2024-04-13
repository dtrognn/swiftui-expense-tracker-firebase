//
//  ImageUrl.swift
//  SpendSmart
//
//  Created by dtrognn on 13/04/2024.
//

import SwiftUI

enum ImageContentMode {
    case fit
    case fill
}

struct ImageConfiguration {
    var urlString: String
    var url: URL?

    init(urlString: String, url: URL? = nil) {
        self.urlString = urlString
        self.url = url
    }
}

struct ImageUrl<Content: View>: View {
    private var configuration: ImageConfiguration
    private var contentMode: ImageContentMode
    private var onLoadError: (() -> Void)?
    private var placeholder: () -> Content

    init(configuration: ImageConfiguration,
         contentMode: ImageContentMode,
         onLoadError: (() -> Void)? = nil,
         placeholder: @escaping () -> Content)
    {
        self.configuration = configuration
        self.contentMode = contentMode
        self.onLoadError = onLoadError
        self.placeholder = placeholder
    }

    var body: some View {
        AsyncImage(url: configuration.url == nil ? URL(string: configuration.urlString) : configuration.url!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode == .fit ? .fit : .fill)
        } placeholder: {
            placeholder()
        }
    }
}
