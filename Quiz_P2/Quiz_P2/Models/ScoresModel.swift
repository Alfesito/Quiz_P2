//
//  ScoresModel.swift
//  Quiz_P1
//
//  Created by Andrés Alfaro Fernández on 30/9/21.
//

import Foundation

class ScoresModel: ObservableObject {
    
    @Published private(set) var acertadas: Set <Int> = []
    @Published private(set) var arrayAcertadas: Array <QuizItem> = []
    @Published private(set) var arrayNoAcertadas: Array <QuizItem> = []
    @Published private(set) var stringAcertadas: Set <String> = []
    
    func check(res: String, quiz: QuizItem){
        let a1 = res.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let a2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(a1 == a2){
            acertadas.insert(quiz.id)
            stringAcertadas.insert(quiz.question)
            
            // Guarda en array acertadas los quizzes acertados
            arrayAcertadas.append(quiz)
            if arrayAcertadas.count != acertadas.count {
                arrayAcertadas.removeLast()
            }
        }
        
    }
        
        func load() {
            //Sacos de ficheros(bundle)
            guard let jsonURL = Bundle.main.url(forResource: "p1_quizzes", withExtension: "json") else {
                print("Internal error: No encuentro p1_quizzes.json")
                return
            }
            
            do {
                //Data: buffer de bytes
                let data = try Data(contentsOf: jsonURL)
                let decoder = JSONDecoder()
                
                // If para depurar
    /*          if let str = String(data: data, encoding: String.Encoding.utf8) {
                      print("Quizzes ==>", str)
     
                }*/
                
                let quizzes = try decoder.decode([QuizItem].self, from: data)
                self.arrayNoAcertadas = quizzes
                
                //Elimina los quizzes acertados del arrayNoAcertadas
                var cont = -1
                for q2 in arrayNoAcertadas{
                    cont=cont+1
                    for q1 in arrayAcertadas{
                        if(q1.id == q2.id){
                            arrayNoAcertadas.remove(at: cont)
                            cont=cont-1
                            break
                        }
                    }
                }
            
                print("Quizzes no acertados cargados")
                print("arrayAcertadas: \(arrayAcertadas.count)")
                print("arrayNoAcertadas: \(arrayNoAcertadas.count)")
                print("Set acertadas: \(acertadas.count)")
            } catch {
                print("Ha ocurrido un error: \(error)")
            }
        }
    //ADICIONAL-Resetea los arrays y sets para empezar de nuevo el juego
    func reset(){
        acertadas = []
        arrayAcertadas = []
        arrayNoAcertadas = []
        stringAcertadas = []
    }
    
}
    

