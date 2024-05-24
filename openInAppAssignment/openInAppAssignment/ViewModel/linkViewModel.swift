//
//  linkViewModel.swift
//  openInAppAssignment
//
//  Created by Adarsh Singh on 21/05/24.
//

import Foundation
import Combine

final class linkViewModel: ObservableObject {
    
    @Published var links: linkModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchLinks() {
        isLoading = true
        errorMessage = nil
        
        ApiManager.shared.fetchLinks { [weak self] response in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch response {
                case .success(let links):
                    self?.links = links
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }
    
    private func handleError(_ error: DataError) {
        switch error {
        case .invalidResponse:
            errorMessage = "Invalid response from the server."
        case .invalidURL:
            errorMessage = "Invalid URL."
        case .invalidDecoding:
            errorMessage = "Failed to decode data."
        case .network(let error):
            errorMessage = error?.localizedDescription ?? "An error occurred."
        }
    }
}
