//
//  MovIzzView.swift
//  MovEco
//
//  Created by Jessy Viranaiken on 09/05/2024.
//

import SwiftUI

struct MovIzzView: View {
    
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView{
                    ForEach(users) { user in
                        NavigationLink {
                            MovIzzFocusView(user: user)
                        } label : {
                            MovIzzItem(user: user)
                                .foregroundStyle(Color.black)
                        }
                        .navigationBarTitle("MovIzz")
                        Divider()
                        
                    }
                    .onDelete(perform: deleteUser)
                }
            }
        }
    }
}

struct MovIzzItem: View {
    
    var user: User
    
    var body: some View {
        HStack{
            Image(user.img)
                .resizable()
                .frame(width: 95, height: 95)
                .shadow(radius: 5)
            VStack(alignment: .leading,spacing: 0){
                Text(user.name)
                    .font(.title2)
                    .bold()
                HStack {
                    Text(user.depart)
                    Image(systemName: "arrow.left.and.right.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color.green)
                        .bold()
                    Text(user.arrival)
                }
                VStack(spacing: 0){
                    HStack{
                        Text("7H15")
                            .font(.subheadline)
                        Image(systemName: "arrow.right.to.line")
                            .font(.system(size: 12))
                            .bold()
                            .foregroundStyle(Color.green)
                        Text("8H15")
                            .font(.subheadline)
                    }
                    HStack{
                        Text("17H30")
                            .font(.subheadline)
                        Image(systemName: "arrow.left.to.line")
                            .font(.system(size: 12))
                            .bold()
                            .foregroundStyle(Color.green)
                        Text("18H30")
                            .font(.subheadline)
                    }
                }
            }
            Spacer()
        }
        .padding(0)
    }
}

func deleteUser(index: IndexSet) {
    users.remove(atOffsets: index)
}

#Preview{
    MovIzzView()
}
