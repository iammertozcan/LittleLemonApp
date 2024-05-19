//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Mert Özcan on 20.05.2024.
//

let kFirstName = "first_name_key"
let kLastName = "last_name_key"
let kEmail = "email_key"

import SwiftUI

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    
    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
            Button("Register") {
                if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                    UserDefaults.standard.set(firstName, forKey: kFirstName)
                    UserDefaults.standard.set(lastName, forKey: kLastName)
                    UserDefaults.standard.set(email, forKey: kEmail)
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
