//
//  Tests.swift
//  ReSwift
//
//  Created by Naji Achkar on 21/02/2022.
//




import SwiftUI

struct ProductCard: View {
    
    var image: String
    var title: String
    var description: String
    var price: Double
    
    var body: some View {
        GeometryReader { geo in
        HStack(alignment: .center) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .padding(.all, 20)
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(description)
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.gray)
                HStack {
                    Text("$" + String.init(format: "%0.2f", price))
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding(.top, 8)
                }
            }.padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: geo.size.width * 0.5, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}


struct TypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(image: "strawberry", title: "Strawberry", description:  "This is a description", price: 2.0)
    }
}
