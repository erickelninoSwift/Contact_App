//
//  ContactRowView.swift
//  ContactApp
//
//  Created by Erick El nino on 2026/02/03.
//

import SwiftUI

struct ContactRowView: View {
    let user: User
    var body: some View {
        HStack {
           // Cirle
            Text(user.userInitials)
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(.gray)
                .clipShape(.circle)
            // user
            
            VStack (alignment: .leading) {
                Text("\(user.name) \(user.username)")
                Text(user.email)
                    .foregroundStyle(.gray)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContactRowView(user: .init(id: 1
                               , name: "Erick"
                               , username: "Tshimobmbo"
                               , email: "erick@yahoo.com"
                               , phone: "0812119429"
                               , website: "www.elnino.com"
                              ))
}
