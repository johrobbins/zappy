//
//  Created by Joh Robbins on 26/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

import Foundation

class UserPreferences {
  private let defaults = UserDefaults.standard
  private let favoriteKey = "Favorite"

  func saveData(with favorite: Favorite) {
    defaults.set(favorite, forKey: favoriteKey)
  }

  func loadData() -> Favorite? {
    let savedFavorite = defaults.object(forKey: favoriteKey) as? Favorite
    return savedFavorite
  }
}
