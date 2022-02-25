
    //
    //  ExplanationsView.swift
    //  ReSwift
    //
    //  Created by Yann Christophe Maertens on 23/02/2022.
    //

    import SwiftUI

struct OnboardingView: View {
    
        @Binding var isShowingExplanations: Bool
    
        var body: some View {
            GeometryReader { geo in
                
                TabView {
                    VStack {
                        HStack(spacing: -1) {
                        Text("Sweet")
                                .foregroundColor(Color.theme.darkBlue).italic().bold()
                                .font(.custom("Arial Rounded MT Bold", size: 55))
                        Text("UI")
                                .foregroundColor(Color.theme.pinkIcon).italic().bold()
                                .font(.custom("Arial Rounded MT Bold", size: 55))
                        }
                        Image("onboarding1")
                            .resizable()
                            .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.3, alignment: .center)
                        Text(String(localized: "onboarding1"))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .font(.custom("Arial Rounded MT Bold", size: 25))
                            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                            .padding()
                    }
                    VStack {
                        HStack(spacing: -1) {
                        Text("Sweet")
                                .foregroundColor(Color.theme.darkBlue).italic().bold()
                                .font(.custom("Arial Rounded MT Bold", size: 55))
                        Text("UI")
                                .foregroundColor(Color.theme.pinkIcon).italic().bold()
                                .font(.custom("Arial Rounded MT Bold", size: 55))
                        }
                      
                        Image("onboarding2")
                            .resizable()
                            .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.3, alignment: .center)
                        Text(String(localized: "onboarding2"))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .font(.custom("Arial Rounded MT Bold", size: 25))
                            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                            .padding()
                    }
                    VStack {
                        HStack(spacing: -1) {
                        Text("Sweet")
                                .foregroundColor(Color.theme.darkBlue).italic().bold()
                                .font(.custom("Arial Rounded MT Bold", size: 55))
                        Text("UI")
                                .foregroundColor(Color.theme.pinkIcon).italic().bold()
                                .font(.custom("Arial Rounded MT Bold", size: 55))
                        }
                       
                        Image("onboarding3")
                            .resizable()
                            .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.3, alignment: .center)
                        Text(String(localized: "onboarding3"))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .font(.custom("Arial Rounded MT Bold", size: 25))
                            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                            .padding()
                    }
                    VStack {
                        Text("Welcome")
                            .foregroundColor(.primary)
                            .font(.custom("Arial Rounded MT Bold", size: 45))
                        
                        
                        Button(String(localized: "onboadring4")) {
                            isShowingExplanations.toggle()
                        }
                        .font(.custom("Arial Rounded MT Bold", size: 45))
                        .foregroundColor(Color.theme.pinkIcon)
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.1)
                        .background(Color.theme.darkBlue)
                        .cornerRadius(8)
                        .shadow(color: Color.theme.lightBlue, radius: 10)
                        .padding()
                    }
                }
                .tabViewStyle(.page)
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                
            }
        }
    }

    struct ExplanationsView_Previews: PreviewProvider {
        static var previews: some View {
            OnboardingView(isShowingExplanations: .constant(false))
        }
    }





