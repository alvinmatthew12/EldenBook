//
//  BossGridView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import SwiftUI

internal struct BossGridItemView: View {
    internal let boss: Boss

    internal var body: some View {
        VStack(alignment: .center, spacing: 0) {
            GeometryReader { geometry in
                EBImage(url: boss.image, contentMode: .fill)
                    .frame(height: geometry.size.width)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
            }
            .aspectRatio(contentMode: .fill)
            
            HStack(alignment: .center) {
                Text(boss.name)
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
        .frame(maxWidth: .infinity, alignment: .top)
        .background(Color.black)
        .cornerRadius(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary.opacity(0.5), lineWidth: 1)
                )
                .shadow(color: Color.primary.opacity(0.2), radius: 5, x: 2, y: 4)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

#Preview {
    bossListPreview()
}
