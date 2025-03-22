//
//  BossItemView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import SwiftUI

internal struct BossItemView: View {
    internal let boss: Boss
    
    internal var body: some View {
        ZStack {
            GeometryReader { geometry in
                EBImage(url: boss.image, contentMode: .fill)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height * 1.3)
                    .mask {
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black, location: 0.0),
                                .init(color: .black, location: 0.5),
                                .init(color: .clear, location: 1.0)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    }
            }
            
            GeometryReader { geometry in
                HStack {
                    Spacer()
                        .frame(width: geometry.size.width / 2.3)
                    VStack {
                        Text("\(boss.name)")
                            .foregroundStyle(Color.primary)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                            .lineLimit(2)
                            .lineSpacing(1.5)
                            .truncationMode(.tail)
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.trailing, 8)
                }
            }
        }
        .frame(height: 166)
        .background(Color.black)
        .cornerRadius(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.black)
                .shadow(color: Color.primary.opacity(0.2), radius: 5, x: 2, y: 4)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    bossListPreview()
}
