
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
                        Text("Browse the library and tap the one you like to get the code")
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
                        Text("Help grow the community by sharing your own designs")
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .font(.custom("Arial Rounded MT Bold", size: 25))
                            .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.2)
                            .padding()
                    }
                    VStack {
                        Text("Welcome")
                            .foregroundColor(.primary)
                            .font(.custom("Arial Rounded MT Bold", size: 25))
                        Button("Let's go !") {
                            isShowingExplanations.toggle()
                        }
                        .foregroundColor(Color(UIColor.systemBackground))
                        .font(.custom("Arial Rounded MT Bold", size: 25))
                        .frame(width: geo.size.width * 0.5, height: geo.size.height * 0.1)
                        .background(Color.pink.cornerRadius(10))
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

//    struct ExplanationImageView: View {
//        var size: CGSize
//        var images: [String]
//        var body: some View {
//            HStack {
//                ForEach(images, id: \.self) { image in
//                    Image(systemName: image)
//                        .foregroundColor(.primary)
//                        .font(.system(size: size.width * 0.2, weight: .semibold, design: .default))
//                }
//            }
//            .frame(width: size.width * 0.8, height: size.height * 0.3)
//            .padding()
//        }
//    }



