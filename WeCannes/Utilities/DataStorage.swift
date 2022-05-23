//
//  UserRepository.swift
//  WeCannes
//
//  Created by Dustin Allen on 5/23/22.
//

import Foundation

extension UserDefaults {
  func setCodable<T: Codable>(_ value: T, forKey key: String) {
    guard let data = try? JSONEncoder().encode(value) else {
      fatalError("Cannot create a json representation of \(value)")
    }
    self.set(data, forKey: key)
  }

  func codable<T: Codable>(forKey key: String) -> T? {
    guard let data = self.data(forKey: key) else {
      return nil
    }
    return try? JSONDecoder().decode(T.self, from: data)
  }
}
