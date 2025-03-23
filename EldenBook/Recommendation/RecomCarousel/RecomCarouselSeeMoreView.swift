//
//  RecomCarouselSeeMoreView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import SwiftUI

internal struct RecomCarouselSeeMoreView: View {
    internal var body: some View {
        VStack {
            Spacer()
            
            Text("See More")
                .font(.caption)
                .foregroundColor(.primary)
            
            Image(systemName: "arrow.right.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .frame(width: 140, height: 200, alignment: .top)
        .background(Color.black)
        .cornerRadius(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary.opacity(0.5), lineWidth: 1)
                )
                .shadow(color: Color.primary.opacity(0.2), radius: 2, x: 2, y: 2)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

#Preview {
    RecomCarouselSeeMoreView()
}
