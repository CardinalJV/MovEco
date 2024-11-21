<a href="https://developer.apple.com/xcode/swiftui/">
  <img src="https://raw.githubusercontent.com/CardinalJV/CardinalJV/main/assets/logo-swift/swiftui-96x96_2x.png" alt="SwiftUI" title="SwiftUI" width="75" height="75"/></a>
<a href="https://developer.apple.com/documentation/mapkit/">
  <img src="https://raw.githubusercontent.com/CardinalJV/CardinalJV/main/assets/logo-swift/mapkit-96x96_2x.png" alt="MapKit" title="MapKit" width="75" height="75"/></a>

# MovEco

MovEco est une application iOS native qui permet de visualiser des emplacements sur une carte interactive. L'application utilise les fonctionnalités du SDK MapKit pour gérer l'affichage de la carte, les annotations personnalisées, ainsi que la génération de routes entre les différents points d'intérêt. Elle inclut également une gestion d'utilisateur avec des écrans de connexion, d'inscription et de profil.

## ScreenCast

https://github.com/user-attachments/assets/e9784295-bd33-4d07-a2db-45368f5e0c87

## Fonctionnalités principales 

- Carte interactive avec MapKit :

Utilisation de MapKit pour afficher une carte dynamique.
Affichage de markers personnalisés sur la carte avec des annotations décrivant les points d'intérêt.
Zoom et navigation automatiques basés sur les coordonnées sélectionnées par l'utilisateur.
Génération de routes et calcul d'itinéraires à l'aide de MKDirections.

- Requêtes asynchrones :
  
Utilisation de fonctions asynchrones pour effectuer des appels réseaux, notamment pour récupérer des données liées aux lieux et générer des itinéraires.
Gestion des MKDirections.Request pour calculer les itinéraires entre l'utilisateur et une destination choisie.

- Affichage des détails des emplacements :
  
Quand un utilisateur sélectionne un point sur la carte, une vue modale s'ouvre pour afficher les informations détaillées du lieu, telles que l'adresse, les horaires et d'autres informations pertinentes.
Cette fonctionnalité est implémentée dans la vue MapItemDetailsView.swift.

- Gestion des utilisateurs :
  
Le modèle User.swift gère les informations des utilisateurs, telles que les identifiants et les informations de connexion.
Des vues dédiées pour la connexion et l'inscription (FormLoginView.swift, FormSignView.swift) permettent aux utilisateurs de se connecter ou de créer un compte.

- Composants réutilisables :
  
Les composants UI, comme MovIzzFocusView.swift et MovIzzView.swift, sont utilisés pour afficher des éléments interactifs, tels que des boutons personnalisés ou des vues d'aperçu, facilitant la navigation.

- Structure MVC :
  
Le projet est organisé selon le modèle MVC (Model-View-Controller), ce qui rend le code modulaire et maintenable.
Le MapController.swift centralise la logique de gestion de la carte, notamment les interactions avec les annotations et les requêtes MapKit.

## Détails techniques

- Langage : Swift
- Frameworks : SwiftUI, MapKit
- Gestion des états : Utilisation de @State et @Observable pour la gestion des vues et des modèles.
- Version iOS supportée : iOS 17 et plus (Depuis iOS 18, un overlay rouge apparait sur la map donc pour éviter tous problème d'affichage rester sur une version 17 et plus d'iOS)
- Gestion asynchrone : Utilisation de async/await pour gérer les appels réseau et les calculs d'itinéraires.

## Installation

Clonez le projet depuis le dépôt GitHub, puis ouvrez-le dans Xcode. Assurez-vous que vous utilisez la dernière version de Xcode compatible avec Swift 5 et SwiftUI pour éviter tout problème de compatibilité.

## Crédits

Dédicace à Faiz, Allan, Diego ainsi qu'Ahmed, la team de choc, sans qui ce projet n'aurait jamais vu le jour.
