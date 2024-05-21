//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Mert Özcan on 20.05.2024.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                navigationBar
                heroSection
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                .padding(.vertical, 10.0)
                registerationSection
                Spacer()
                registerationButton
                Spacer()
            }
        }
    }
    
    private var navigationBar: some View {
        HStack {
            Spacer()
            Image("Logo")
            Spacer()
        }
        .padding(.horizontal)
    }
    
    private var heroSection: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.yellow)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Chicago")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
                Image("hero-image")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(red: 73/255, green: 94/255, blue: 87/255))
    }
    
    private var registerationSection: some View {
        VStack(alignment: .leading) {
            Text("First Name")
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            TextField("", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 3.0)
            
            Text("Last Name")
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            TextField("", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 3.0)
            
            Text("E-mail")
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            TextField("", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 3.0)
        }
        .padding(.horizontal)
    }
    
    private var registerationButton: some View {
        Button(action: {
            if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                UserDefaults.standard.set(firstName, forKey: kFirstName)
                UserDefaults.standard.set(lastName, forKey: kLastName)
                UserDefaults.standard.set(email, forKey: kEmail)
                isLoggedIn = true
            }
        }) {
            Text("Register")
                .bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 350, height: 50) // Set the frame for the button
        .background(Color(red: 73/255, green: 94/255, blue: 87/255))
        .cornerRadius(8)
        .contentShape(Rectangle().size(CGSize(width: 350, height: 50)))
    }
    
}

#Preview {
    Onboarding()
}
