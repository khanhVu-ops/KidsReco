//
//  MenuViewModel.swift
//  KidsReco
//
//  Created by Khanh Vu on 21/07/5 Reiwa.
//

import Foundation
import RxSwift
import RxCocoa

class MenuViewModel: BaseViewModel {
    func getLastestVersion() -> String {
        return "Lastest version: \(UIApplication.applicationVersion)"
    }
}
