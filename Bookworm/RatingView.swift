//
//  RatingView.swift
//  Bookworm
//
//  Created by Kirill Baranov on 19/01/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var label = ""

    var maximumRating = 5
    
    var body: some View {
        HStack {
            ForEach (1..<maximumRating+1, id: \.self) { star in
                Button(action: {
                    rating = star
                }, label: {
                    Image(systemName: "star.fill")
                        .foregroundStyle(rating < star ? .gray : .yellow)
                })
            }
        }
        .buttonStyle(.plain)     
        .accessibilityElement()
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating {
                    rating += 1
                }
            case .decrement:
                if rating > 1 {
                    rating -= 1
                }
            default:
                break
            }
            
            
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
