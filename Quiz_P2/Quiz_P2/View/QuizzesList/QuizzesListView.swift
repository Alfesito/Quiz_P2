//
//  ContentView.swift
//  Quiz_P1
//
//  Created by Andrés Alfaro Fernández on 22/9/21.
//

import SwiftUI

struct QuizzesListView: View {
    
    @EnvironmentObject var quizzesModel : QuizzesModel
    @EnvironmentObject var scoresModel : ScoresModel
    @State var showNoResueltosView: Bool = false
    
    var body: some View {
        if(showNoResueltosView){
            SubView2(showNoResueltosView2 : $showNoResueltosView)
            
        }else{  //Default
            SubView1(showNoResueltosView1 : $showNoResueltosView)
        }
        
    }
}
//Muestra los quizzes resueltos
struct SubView1: View {
    @EnvironmentObject var quizzesModel : QuizzesModel
    @Binding var showNoResueltosView1: Bool
    var body: some View{
        NavigationView{
            List{
                ForEach(quizzesModel.quizzes){
                    qi in
                    NavigationLink(destination: QuizPlayView(quizItem:qi)){
                        QuizRowView(quizItem: qi)
                    }
                }
            }
            .padding()
            .navigationBarTitle(Text("Quiz P2 SwiftIU"))
                .toolbar{
                    ToolbarItem(placement: .bottomBar){
                        Toggle("Quizzes no resueltos", isOn: $showNoResueltosView1)
                    }
                }
            .onAppear(perform: {
                quizzesModel.load()
            })
        }
    }
}
//Muestra los quizzes no resueltos
struct SubView2: View {
    @EnvironmentObject var scoresModel : ScoresModel
    @EnvironmentObject var quizzesModel : QuizzesModel
    @Binding var showNoResueltosView2: Bool
    var body: some View{
        NavigationView{
            List{
                ForEach(scoresModel.arrayNoAcertadas){
                    qi in
                    NavigationLink(destination: QuizPlayView(quizItem:qi)){
                        QuizRowView(quizItem: qi)
                    }
                }
            }
            .padding()
            .navigationBarTitle(Text("Quiz P2 SwiftIU"))
                .toolbar{
                    ToolbarItem(placement: .bottomBar){
                        Toggle("Quizzes no resueltos", isOn: $showNoResueltosView2)
                    }
                }
            .onAppear(perform: {
                scoresModel.load()
            })
        }
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizzesListView()
//    }
//}
