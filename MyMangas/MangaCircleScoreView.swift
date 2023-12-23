//
//  MangaCircleScoreView.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 23/12/23.
//

import SwiftUI

//Sacarlo al ViewModel?¿?¿
enum CircleSize: CGFloat {
    case small = 70
    case large = 100
}

struct MangaCircleScoreView: View {
    let manga: Manga
    var circleSize: CircleSize = .large
    @State var progress: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 10)
                .stroke(style: StrokeStyle(lineWidth: circleSize == .large ? 8 : 5, lineCap: .round))
                .foregroundStyle(.black)
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: progress ? (manga.score/10) : 0)
                        .stroke(style: StrokeStyle(lineWidth: circleSize == .large ? 8 : 5, lineCap: .round))
                        .rotation(.degrees(-90))
                        .foregroundColor(manga.scoreColor)
                        .animation(.easeInOut(duration: 2), value: progress)
                )
                .background {
                    Circle()
                        .fill(Color.black)
                }
                .padding()
                .frame(width: circleSize == .large ? 100 : 80)
                .onAppear {
                    progress = true
                }
            Text(manga.score1Fraction)
                .foregroundStyle(manga.scoreColor)
                .font(.system(size: circleSize == .large ? 30 : 20))
                .fontWeight(.light)
                .bold()
        }
    }
}

#Preview {
    MangaCircleScoreView(manga: .test)
}
