//
//  Created by Joh Robbins on 23/7/20.
//  Copyright © 2020 Joh Robbins. All rights reserved.
//

struct Location: Codable, Equatable {
  var city: String
  var state: String
  var latitude: String
  var longitude: String
}

extension Location {
  static func loadLocations() -> [Location] {
    let sydney = Location(city: "Sydney", state: "NSW", latitude: "-33.8548157", longitude: "151.2164539")
    let melbourne = Location(city: "Melbourne", state: "VIC", latitude: "-37.8142176", longitude: "144.9631608")
    let brisbane = Location(city: "Brisbane", state: "QLD", latitude: "-27.4689682", longitude: "153.0234991")
    let perth = Location(city: "Perth", state: "WA", latitude: "-31.9527121", longitude: "115.8604796")
    let adelaide = Location(city: "Adelaide", state: "SA", latitude: "-34.9281805", longitude: "138.5999312")
    let canberra = Location(city: "Canberra", state: "ACT", latitude: "-35.2975906", longitude: "149.1012676")
    let hobart = Location(city: "Hobart", state: "TAS", latitude: "-42.8825088", longitude: "147.3281233")
    let darwin = Location(city: "Darwin", state: "NT", latitude: "-12.46044", longitude: "130.8410469")
    let goldCoast = Location(city: "Gold Coast", state: "QLD", latitude: "-28.0023731", longitude: "153.4145987")
    let newcastle = Location(city: "Newcastle", state: "NSW", latitude: "-32.9272881", longitude: "151.7812534")
    let sunshineCoast = Location(city: "Sunshine Coast", state: "QLD", latitude: "-26.649381", longitude: "153.067282")
    let wollongong = Location(city: "Wollongong", state: "NSW", latitude: "-34.4243941", longitude: "150.89385")
    let geelong = Location(city: "Geelong", state: "VIC", latitude: "-38.1492813", longitude: "144.3598269")
    let townsville = Location(city: "Townsville",state: "QLD",latitude: "-19.2569391",longitude: "146.8239537")
    let cairns = Location(city: "Cairns", state: "QLD", latitude: "-16.9206657", longitude: "145.7721854")
    let toowoomba = Location(city: "Toowoomba", state: "QLD", latitude: "-27.5610193", longitude: "151.953351")
    let ballarat = Location(city: "Ballarat", state: "VIC", latitude: "-37.5622632", longitude: "143.8607215")
    let bendigo = Location(city: "Bendigo", state: "VIC", latitude: "-36.7588767", longitude: "144.2825931")
    let albury = Location(city: "Albury", state: "NSW", latitude: "-36.0804766", longitude: "146.9162795")
    let launceston = Location(city: "Launceston", state: "TAS", latitude: "-41.4340813", longitude: "147.1373496")
    let rockhampton = Location(city: "Rockhampton", state: "QLD", latitude: "-23.3782501", longitude: "150.5134442")
    let broome = Location(city: "Broome", state: "WA", latitude: "-17.9566909", longitude: "122.2240181")
    let aliceSprings = Location(city: "Alice Springs", state: "NT", latitude: "-23.6983884", longitude: "133.8812885")
    let norfolkIsland = Location(city: "Norfolk Island", state: "NSW", latitude: "-29.0289575", longitude: "167.9587289")

    return [
      sydney, melbourne, brisbane, perth, adelaide, canberra, hobart, darwin, goldCoast, newcastle, sunshineCoast,
      wollongong, geelong, townsville, cairns, toowoomba, ballarat, bendigo, albury, launceston, rockhampton, broome,
      aliceSprings, norfolkIsland
    ]
  }
}
