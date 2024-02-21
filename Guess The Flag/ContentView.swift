//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Kerem Can Bakır on 18.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.purple, .yellow]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                Text ("Guess the Flag").font(.largeTitle.bold()).padding(30).foregroundStyle(.primary)
                Spacer()
            }
            VStack (spacing:30){
                VStack{
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3){number in
                    Button{
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original).clipShape(Capsule())
                            .shadow(radius: 15)
                    }
                }
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }           
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "True"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
