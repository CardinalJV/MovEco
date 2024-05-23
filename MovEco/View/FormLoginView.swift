//
//  SwiftUIView.swift
//  MovEco
//
//  Created by apprenant58 on 07/05/2024.
//

import SwiftUI
import Observation

struct FormLoginView: View {
    
//    @Binding var userActive: User
    @State private var mailValue = ""
    @State private var passwordValue = ""
    @State private var showedAlert = false
    
    func printer(string: String) {
        print(string)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("moveco")
                    .resizable()
                    .frame(width: 225, height: 225)
                Spacer()
                VStack(spacing: 30) {
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
                VStack(spacing: 20) {
                    Button(action: {
                        for user in users {
                            if user.mail == mailValue && user.password == passwordValue {
//                                userActive.img = user.img
                            }
                            print(users)
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 350, height: 50)
                                .foregroundStyle(Color.green)
                            Text("Se connecter")
                                .foregroundStyle(Color.white)
                                .font(.title2)
                                .bold()
                        }
                    })
                    .alert("Attention", isPresented: $showedAlert) {
                    } message: {
                        Text("Formulaire invalide")
                    }
                    VStack {
                        Text("Vous n'avez pas de compte ?")
                        NavigationLink("S'inscrire"){
                            FormSignView()
                        }
                        .foregroundStyle(Color.green)
                    }
                }
                Spacer()
            }
            .padding(25)
        }
    }
}

#Preview {
    FormLoginView()
}
