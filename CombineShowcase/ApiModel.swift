//
//  Model.swift
//  CombineShowcase
//
//  Created by Piccirilli Federico on 9/22/21.
//

import Combine
import Foundation

class ApiModel: NSObject {
    func getStuff()-> Future<[String], Error> {
        return Future { 🔮 in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                🔮(.success(["a","b","c","d"]))
            }
        }
    }
}

enum ApiError: Error {
    case generic
}
