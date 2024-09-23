//
  //  NewUserProfilView.swift
  //  MovEco
  //
  //  Created by apprenant58 on 07/05/2024.
  //

import SwiftUI

struct NewUserProfilView: View {
    @State var userBio = ""
    var userPassword = "1234"
    let background = Color(red: 242/255, green: 247/255, blue: 242/255)

    var body: some View {
        ZStack{
            let background = Color(red: 242/255, green: 247/255, blue: 242/255)
            background
                .ignoresSafeArea()
            VStack(spacing: 2){
                Image("jessy")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .shadow(radius: 10)
                VStack(alignment: .leading,spacing: 0){
                    SelfItemView(title: "Nom", content: "Viranaiken")
                    SelfItemView(title: "Prénom", content: "Jessy")
                    SelfItemView(title: "Mail", content: "jessy.viranaiken@icloud.com")
                    SelfItemView(title: "Mot de passe", content: "****")
                    VStack(spacing: 5){
                        HStack {
                            Text("Trajets réguliers")
                                    .fontWeight(.bold)
                                .font(.system(size: 18))
                            Spacer()
                        }
                        HStack{
                            Text("Soual")
                            Image(systemName: "arrow.left.arrow.right.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Color.green)
                            Text("Toulouse")
                                .font(.system(size: 20))
                            Spacer()
                        }
                    }
                    .padding(5)
                }
                .padding()
//                ZStack{
//                    CustomTextEditor("Enter your note", text: $userBio)
//                        .padding()
//                }
                VStack(alignment: .leading) {
                    Text("A propos de moi")
                        .font(.title2)
                        .bold()
                    Text(" ")
                        .frame(width: 350, height: 100)
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 10))
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 350, height: 50)
                            .foregroundStyle(.green)
                        Text("Modifier")
                            .foregroundStyle(.white)
                            .font(.title)
                            .bold()
                    }
                })
                Spacer()
            }
        }
    }
}

struct SelfItemView: View {

  var title: String
  var content: String

    var body: some View {
        ZStack{
            VStack(spacing: 5){
                HStack{
                    Text(title)
                        .fontWeight(.bold)
                        .font(.system(size: 18))
                    Spacer()
                }
                HStack{
                    Text(content)
                        .font(.system(size: 20))
                    Spacer()
                }
            }
            .padding(5)
        }
    }
}

#Preview {
  NewUserProfilView()
}
