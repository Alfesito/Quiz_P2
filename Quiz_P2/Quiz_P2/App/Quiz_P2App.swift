//
//  Quiz_P2App.swift
//  Quiz_P2
//
//  Created by Andrés Alfaro Fernández on 7/10/21.
//

import SwiftUI

@main
struct Quiz_P2App: App {
    let quizzesModel = QuizzesModel()
    let scoresModel = ScoresModel()
    
    var body: some Scene {
        WindowGroup {
            QuizzesListView()
                .environmentObject(quizzesModel)
                .environmentObject(scoresModel)
        }
    }
}
