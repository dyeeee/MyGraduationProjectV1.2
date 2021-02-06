//
//  UserDefaultTools.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/27.
//

import SwiftUI
import Foundation

public func isNewDay() -> Bool {
    let today = Date().dateToString(format: "yyyyMMdd")
    let lastLogIn = UserDefaults.standard.string(forKey: "LastLogIn")
    if today == lastLogIn {
        return false
    }else{
        return true
    }
}

public func setLearnDay() {
    if (UserDefaults.standard.bool(forKey: "IsLastLearnDone") && isNewDay()) {
        UserDefaults.standard.setValue(UserDefaults.standard.integer(forKey: "LearnDayCount")+1, forKey: "LearnDayCount")
        UserDefaults.standard.setValue(false, forKey: "IsLastLearnDone")
    }
}
