////
////  ScoreView.swift
////  SweetUI
////
////  Created by Naji Achkar on 08/03/2022.
////
//
//import SwiftUI
//
//struct ScoreView: View {
//    
//    @StateObject var viewmodel = CKScoreService()
//    
//    var body: some View {
//        VStack {
//            List {
//                ForEach(viewmodel.scoreItems, id: \.self) { record in
//                    HStack {
//                    Text(record.creator)
//                        Text("\(record.value)")
//                }
//            }
//        }
//        }
//        .onAppear(perform: viewmodel.fetchScoreItems)
//    }
//}
//
//struct ScoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScoreView()
//    }
//}
