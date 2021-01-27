//
//  MyGraduationProjectV1App.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2020/12/27.
//

import SwiftUI

@main
struct MyGraduationProjectV1App: App {
    let persistenceController = PersistenceController.shared

    init() {
        //测试时注释本行UserDefaults.standard.set(Date().dateToString(format: "yyyyMMdd"), forKey: "LastLogIn")
        setLearnDay()
    }
    
    
    var body: some Scene {
        WindowGroup {
            HomeTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
