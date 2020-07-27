//
//  Created by Joh Robbins on 26/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import Foundation

class UserPreferences {
  private let defaults = UserDefaults.standard
  private let favouriteKey = "Favourite"

  func saveFavourite(with favourite: Favourite) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(favourite) {
        defaults.set(encoded, forKey: favouriteKey)
    }
  }

  func loadFavourite() -> Favourite? {
    if let savedFavourite = defaults.object(forKey: favouriteKey) as? Data {
        let decoder = JSONDecoder()
        if let loadedFavourite = try? decoder.decode(Favourite.self, from: savedFavourite) {
            return loadedFavourite
        }
    }
    return nil
  }

  func removeFavourite() {
    defaults.removeObject(forKey: favouriteKey)
  }
}
