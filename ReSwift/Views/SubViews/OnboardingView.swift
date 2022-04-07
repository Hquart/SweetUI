
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
                        appNameTitle
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
                        appNameTitle
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
                        appNameTitle
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
                    VStack(spacing: 30) {
                        appNameTitle
                        Group {
                        Text("Disclaimer")
                                .font(.title2).fontWeight(.heavy)
                        Text("disclaimerText")
                                .foregroundColor(Color(UIColor.systemGray)).italic()
                                .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.2, alignment: .center)
                        }
                        .font(.caption)
                     
                        Text(String(localized: "onboadring4"))
                        .font(.custom("Arial Rounded MT Bold", size: 40))
                        .foregroundColor(Color(UIColor.systemPink))
                        .frame(width: geo.size.width * 0.4, height: geo.size.height * 0.08)
                        .background(Color.theme.darkBlue)
                        .cornerRadius(8)
                        .shadow(color: Color.theme.lightBlue, radius: 10)
                        .padding()
                        .onTapGesture {
                            isShowingExplanations = false
                        }
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






extension OnboardingView {
    private var appNameTitle: some View {
        HStack(spacing: -1) {
        Text("Sweet")
                .foregroundColor(Color.theme.darkBlue).italic().bold()
                .font(.custom("Arial Rounded MT Bold", size: 55))
        Text("UI")
                .foregroundColor(Color.theme.pinkIcon).italic().bold()
                .font(.custom("Arial Rounded MT Bold", size: 55))
        }
}
}


