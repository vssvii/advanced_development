//
//  Users.swift
//  GeoLocalization
//
//  Created by Developer on 08.12.2022.
//

import Foundation
import MapKit

final class Users: NSObject, MKAnnotation {
    
    
    var name: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(
        name: String,
        coordinate: CLLocationCoordinate2D,
        info: String
    ) {
        self.name = name
        self.coordinate = coordinate
        self.info = info
    }
}

//extension Users {
//    
////    static func make() -> [Users] {
////        return [.init(name: "Бауыржан",
////                      coordinate: CLLocationCoordinate2D(latitude: 51.0890503, longitude: 71.404632),
////                     info: "Пользователь из Астаны"),
////                .init(name: "Андрей", coordinate: CLLocationCoordinate2D(latitude: 55.751754, longitude: 37.662709), info: "Пользователь из Москвы"),
////                .init(name: "Биболат", coordinate: CLLocationCoordinate2D(latitude: 37.427249, longitude: -122.1661477), info: "Пользователь из Сан-Франциско"),
////                .init(name: "Мехмет", coordinate: CLLocationCoordinate2D(latitude: 39.9004151, longitude: 32.8064158), info: "Пользователь из Анкары")
////        ]
////    }
//    
//    
//}
