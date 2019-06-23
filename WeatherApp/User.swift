//
//  User.swift
//  WeatherApp
//
//  Created by Ömer Koçbil on 4.07.2017.
//  Copyright © 2017 Ömer Koçbil. All rights reserved.
//

import Foundation

struct User {
    
    let id: String!
    let name: String!
    let surname: String!
    let email: String!
    let password: String!
    let phoneNumber: String!
    let isCorrect: Int!
    
    init(id: String, name: String, surname: String, email: String, password: String, phoneNumber: String, isCorrect: Int){
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.isCorrect = isCorrect
    }
    
}
