//
//  User.swift
//  MovEco
//
//  Created by apprenant58 on 07/05/2024.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let mail: String
    var password: String
    var img: String
    var depart: String
    var arrival: String
    var description: String
}

var users: [User] = [
    User(name: "Faiz", mail: "", password: "faiz", img: "faiz", depart: "Longages", arrival: "Toulouse", description: "Je m'appelle Faiz et je fais régulièrement la navette entre Longages et Toulouse. Ces trajets sont pour moi l'occasion parfaite de partager des moments agréables avec des compagnons de route. En dehors de mes voyages, je suis un grand fan de GTA RP, où j'aime incarner divers personnages et explorer des mondes virtuels passionnants. Toujours prêt pour une bonne conversation et de nouvelles rencontres, je suis impatient de vous accueillir à bord pour un trajet convivial et détendu."),
    User(name: "Ahmed", mail: "", password: "ahmed", img: "ahmed",depart: "Colomiers", arrival: "Toulouse", description: "Je m'appelle Ahmed et je fais régulièrement la navette entre Longages et Toulouse. Ces trajets sont pour moi l'occasion parfaite de partager des moments agréables avec des compagnons de route. En dehors de mes voyages, je suis un grand passionné de cinéma, toujours à la recherche des derniers films à découvrir et des classiques à revisiter. Toujours prêt pour une bonne conversation et de nouvelles rencontres, je suis impatient de vous accueillir à bord pour un trajet convivial et détendu."),
    User(name: "Diego", mail: "", password: "diego", img: "diego", depart: "Colomiers", arrival: "Toulouse", description: "Je m'appelle Diego et je fais régulièrement la navette entre Colomiers et Toulouse. Ces trajets sont pour moi l'occasion parfaite de partager des moments agréables avec des compagnons de route. En dehors de mes voyages, je suis un grand passionné d'épées, collectionnant et étudiant ces armes fascinantes à travers les âges. Toujours prêt pour une bonne conversation et de nouvelles rencontres, je suis impatient de vous accueillir à bord pour un trajet convivial et détendu."),
    User(name: "Allan", mail: "", password: "allan", img: "allan", depart: "Colomiers", arrival: "Toulouse", description: "Je m'appelle Allan et je fais régulièrement la navette entre Colomiers et Toulouse. Ces trajets sont pour moi l'occasion parfaite de partager des moments agréables avec des compagnons de route. En dehors de mes voyages, je suis un grand passionné de PlayStation, passant des heures à explorer des jeux captivants et à relever des défis virtuels. Toujours prêt pour une bonne conversation et de nouvelles rencontres, je suis impatient de vous accueillir à bord pour un trajet convivial et détendu."),
    User(name: "Jessy", mail: "", password: "jessy", img: "jessy", depart: "Soual", arrival: "Toulouse", description: "Je m'appelle Jessy et je fais régulièrement la navette entre Soual et Toulouse. Ces trajets sont pour moi l'occasion parfaite de partager des moments agréables avec des compagnons de route. En dehors de mes voyages, je suis une grande passionnée de powerlifting, consacrant beaucoup de temps à l'entraînement et à la compétition dans ce sport de force. Toujours prête pour une bonne conversation et de nouvelles rencontres, je suis impatiente de vous accueillir à bord pour un trajet convivial et détendu.")
]

