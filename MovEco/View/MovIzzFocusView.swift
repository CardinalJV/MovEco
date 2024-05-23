//
//  MovIzzFocusView.swift
//  MovEco
//
//  Created by apprenant58 on 10/05/2024.
//

import SwiftUI

struct MovIzzFocusView: View {
    
    var user: User
    // test
    var body: some View {
        VStack(spacing: 30){
            HStack{
                Image(user.img)
                    .resizable()
                    .frame(width: 125, height: 125)
                Spacer()
                VStack(spacing: 5){
                    Text(user.depart)
                        .font(.title2)
                                .bold()
                    Image(systemName: "arrow.up.arrow.down.circle.fill")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(Color.green)
                    Text(user.arrival)
                        .font(.title2)
                                .bold()
                }
            }
            .padding(20)
            //        VStack{
            //          Image("jessy")
            //            .resizable()
            //            .frame(width: 125, height: 125)
            //          Spacer()
            //          HStack{
            //              Spacer()
            //            Text("Soual")
            //              .font(.title2)
            //  //            .bold()
            //              Spacer()
            //            Image(systemName: "arrow.left.arrow.right.circle.fill")
            //                  .font(.system(size: 50))
            //              .bold()
            //              .foregroundStyle(Color.green)
            //              Spacer()
            //            Text("Toulouse")
            //              .font(.title2)
            //  //            .bold()
            //          }
            //        }
            //        .padding(20)
            //      Spacer()
            VStack(alignment: .leading, spacing: 5){
                Text("Trajets réguliers")
                    .bold()
                    .font(.title2)
                    .foregroundStyle(Color.green)
                Text("Lundi a vendredi:")
                    .bold()
                HStack{
                    Text("\(user.depart) - 7H15")
                    Image(systemName: "arrow.right.to.line")
                        .font(.title3)
                        .foregroundStyle(Color.green)
                    Text("18H30 - \(user.arrival)")
                    Spacer()
                }
                .frame(width: 350)
            }
            .padding()
            //      Spacer()
            VStack(alignment: .leading, spacing: 10){
                Text("A propos de moi ")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.green)
                Text(user.description)
                    .frame(width: 350,height: 100, alignment: .leading)
            }
            //        .padding(5)
            Spacer()
            VStack(spacing: 10){
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.blue)
                            .frame(width: 350, height: 50)
                        HStack{
                            Text("Contacter")
                                .foregroundStyle(Color.white)
                                .font(.title2)
                                .bold()
                            Image(systemName: "message.fill")
                                .foregroundStyle(Color.white)
                                .font(.title3)
                        }
                    }
                })
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.green)
                            .frame(width: 350, height: 50)
                        HStack{
                            Text("On réserve")
                                .foregroundStyle(Color.white)
                                .font(.title2)
                                .bold()
                            Image(systemName: "hand.thumbsup.fill")
                                .foregroundStyle(Color.white)
                                .font(.title3)
                        }
                    }
                })
            }
            .padding()
            Spacer()
        }
        .padding()
        .toolbar(.hidden, for: .tabBar)
        Spacer()
    }
}

#Preview{
    MovIzzFocusView(user: User(name: "Jessy", mail: "jessy.viranaiken@icloud.com", password: "1234", img: "jessy", depart: "Soual", arrival: "Toulouse", description: "jhfyggyc"))
}
