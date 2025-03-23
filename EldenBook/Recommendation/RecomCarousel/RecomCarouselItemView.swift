//
//  RecomCarouselItemView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import SwiftUI

internal struct RecomCarouselItemView: View {
    internal let item: RecomItem

    internal var body: some View {
        let width: CGFloat = 140
        
        VStack(alignment: .center, spacing: 0) {
            EBImage(url: item.image, contentMode: .fill)
                .frame(width: width, height: width)
                .clipped()
            
            HStack(alignment: .center) {
                Text(item.title)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.primary)
                    .font(.system(size: 14))
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .lineSpacing(1.5)
                    .truncationMode(.tail)
                    .padding(.horizontal, 8)
            }
            .frame(height: 60)
        }
        .frame(width: width, height: 200, alignment: .top)
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
    RecomCarouselView(identifier: "Bosses")
        .preferredColorScheme(.dark)
}
