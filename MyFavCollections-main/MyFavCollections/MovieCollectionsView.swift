//
//  MovieCollectionsView.swift
//  MyFavCollections
//
//  Created by Zholbarys on 25.10.2024.
//

import SwiftUI

struct MovieCollectionsView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MovieCollectionViewController {
        return MovieCollectionViewController()
    }
    
    func updateUIViewController(_ uiViewController: MovieCollectionViewController, context: Context) {
    }
}
