//
//  ContentView.swift
//  LoginForm
//
//  Created by Jessy Viranaiken on 06/05/2024.
//

import SwiftUI

struct FormSignView: View {
    
    let background = Color(red: 242/255, green: 247/255, blue: 242/255)
    
    @State private var nameValue = ""
    @State private var surnameValue = ""
    @State private var mailValue = ""
    @State private var passwordValue = ""
    @State private var showedAlert = false
    
    func printer(string: String) {
        print(string)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.badge.plus")
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            VStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5){
                    Text("Nom")
                    TextField("Écriver votre nom", text: $nameValue)
                }
                VStack(alignment: .leading, spacing: 5){
                    Text("Prénom")
                    TextField("Écriver votre prénom", text: $surnameValue)
                }
                VStack(alignment: .leading, spacing: 5){
                    Text("E-mail")
                    TextField("Écriver votre mail", text: $mailValue)
                }
                VStack(alignment: .leading, spacing: 5){
                    Text("Mot de passe")
                    TextField("Ajouter un mot de passe", text: $passwordValue)
                }
            }
            Spacer()
            Button(action: {
                if nameValue.isEmpty || surnameValue.isEmpty || mailValue.isEmpty || passwordValue.isEmpty {
                    showedAlert = true
                    printer(string: "error")
                } else {
                    for user in users {
                        if user.mail == mailValue {
                            // Erreur utilisateur déja enregistré
                            printer(string: "Utilisateur déja enregistré")
                        }
                    }
                    //                    users.append(User(name: "\(nameValue) \(surnameValue)", mail: mailValue, password: passwordValue, img: ""))
                    printer(string: "Ajout réussi")
                    print(users)
                }
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 350, height: 50)
                        .foregroundStyle(Color.green)
                    Text("S'inscrire")
                        .foregroundStyle(Color.white)
                        .font(.title2)
                        .bold()
                }
            })
            .alert("Attention", isPresented: $showedAlert) {
            } message: {
                Text("Formulaire invalide")
            }
            Spacer()
        }
        .padding(25)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    FormSignView()
}
