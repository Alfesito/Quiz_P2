//
//  QuizzesModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 17/09/2021.
//

import Foundation
//ObservableObject: permite que se actualice si hay cambios
class QuizzesModel: ObservableObject {
    
    // Los datos
    @Published private(set) var quizzes: Array = [QuizItem]()
    
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
            self.quizzes = quizzes
        
            print("Quizzes cargados")
        } catch {
            print("Ha ocurrido un error: \(error)")
        }
    }
}
