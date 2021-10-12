//
//  LocalStorageManager.swift
//  MyMoney
//
//  Created by Kirill on 12.10.2021.
//  Copyright © 2021 Samax. All rights reserved.
//

import Foundation

enum LocalKey: String {
    case isFirstInit
}

class LocalStorageManager {
    
    static let shared = LocalStorageManager()
    
    private let storage = UserDefaults.standard
    
    private init() { }
    
    func set<T>(key: LocalKey, value: T) {
        storage.setValue(value, forKey: key.rawValue)
    }
    
    func get<T>(key: LocalKey, defaultValue: T) -> T {
        get(key: key) ?? defaultValue
    }
    
    func get<T>(key: LocalKey) -> T? {
        storage.object(forKey: key.rawValue) as? T
    }
}

