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
    @State var showResueltos: Bool = false
    @State var showAlert: Bool = false
    private var kmykey = "MY_KEY"
    //Text("\(UserDefaults.standard.integer(forKey: kmykey))")
    var body: some View {
        NavigationView{
            if(showNoResueltosView){
                SubView2(showNoResueltosView2 : $showNoResueltosView)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            SheetView(showResueltosSheet: $showResueltos, showAlertSheet: $showAlert)
                        }
                    }.alert(isPresented: $showAlert){
                            return Alert(title: Text("⚠️"),
                                         message: Text("No hay quizzes resueltos"),
                                         dismissButton: .default(Text("Ok"))
                            )
                    }
        
            }else{  //Default
                SubView1(showNoResueltosView1 : $showNoResueltosView)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            SheetView(showResueltosSheet: $showResueltos, showAlertSheet: $showAlert)
                        }
                    }.alert(isPresented: $showAlert){
                            return Alert(title: Text("⚠️"),
                                         message: Text("No hay quizzes resueltos"),
                                         dismissButton: .default(Text("Ok"))
                            )
                    }
            }
        }
    }
}

//Muestra los quizzes resueltos
struct SubView1: View {
    @EnvironmentObject var quizzesModel : QuizzesModel
    @Binding var showNoResueltosView1: Bool
    var kmykey = "MY_KEY"
    var body: some View{
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
                    ToolbarItem(placement: .confirmationAction){
                        Text("\(UserDefaults.standard.integer(forKey: kmykey))")
                            .font(.largeTitle)
                    }
                    ToolbarItem(placement: .bottomBar){
                        Toggle("Quizzes no resueltos", isOn: $showNoResueltosView1)
                    }
                }
                
            .onAppear(perform: {
                quizzesModel.load()
            })
        }
}
//Muestra los quizzes no resueltos
struct SubView2: View {
    @EnvironmentObject var scoresModel : ScoresModel
    @EnvironmentObject var quizzesModel : QuizzesModel
    @Binding var showNoResueltosView2: Bool
    var kmykey = "MY_KEY"
    var body: some View{
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
                ToolbarItem(placement: .confirmationAction){
                    Text("\(UserDefaults.standard.integer(forKey: kmykey))")
                        .font(.largeTitle)
                }
                ToolbarItem(placement: .bottomBar){
                    Toggle("Quizzes no resueltos", isOn: $showNoResueltosView2)
                }
            }
            .onAppear(perform: {
                scoresModel.load()
            })
        }
}

struct SheetView: View {
    @EnvironmentObject var scoresModel : ScoresModel
    @EnvironmentObject var quizzesModel : QuizzesModel
    @Binding var showResueltosSheet : Bool
    @Binding var showAlertSheet : Bool
    
    var body: some View{
            Button(action: {
                if(scoresModel.arrayAcertadas.count > 0){
                    showResueltosSheet = true
                }else{
                    //Una alerta o mensaje que diga que no hay quizzes resuelos
                    showAlertSheet = true
                }
            }) {
                Text("Historial")
            }
            .sheet(isPresented: $showResueltosSheet){
                List{
                    ForEach(scoresModel.arrayAcertadas){ q in
                        HStack(alignment: .center){
                            Text("\(q.question)")
                                .padding(20)
                            Image(systemName: "chevron.forward.circle")
                            Text("\(q.answer)")
                        }
                    }
                }
    //            Button(action: {
    //                self.showAlertSheet = false
    //            }){
    //                Text("Volver")
    //            }.padding()
            }
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizzesListView()
//    }
//}
