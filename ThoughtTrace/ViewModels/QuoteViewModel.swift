//
//  QuoteViewModel.swift
//  ThoughtTrace
//
//  Created by Zareen Sharar Cynthia on 9/5/2024.
//

import Combine
import Foundation

class QuoteViewModel: ObservableObject {
    @Published var quote: Quote?
    @Published var isLoading = false
    @Published var errorMessage: String?

    init() {
        // default quote for when the app starts
        self.quote = Quote(q: "The road to success is always under construction..",
                           a: "Lily Tomlin")
    }

    func fetchRandomQuote() {
        isLoading = true
        errorMessage = nil
        guard let url = URL(string: "https://zenquotes.io/api/random") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                guard let data = data,
                      let quoteArray = try? JSONDecoder().decode([Quote].self, from: data),
                      let quote = quoteArray.first else {
                    self.errorMessage = "Failed to decode response"
                    return
                }
                self.quote = quote
            }
        }.resume()
    }
}
