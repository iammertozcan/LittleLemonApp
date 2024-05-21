//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Mert Özcan on 20.05.2024.
//

import SwiftUI

struct UserProfile: View {
    
    @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State var phoneNumber : String = "(217) 555-0113"
    
    @Environment(\.presentationMode) var presentation
    @State private var isCheckedOrder: Bool = true
    @State private var isCheckedPassword: Bool = true
    @State private var isCheckedOffer: Bool = true
    @State private var isCheckedNewsletter: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            navigationBar
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    profileSection
                    infoSection
                    emailNatificationSection
                }
                .padding(.horizontal)
                logOutButton
                buttonsSection
                Spacer()
                Spacer()
            }
        }
    }
    
    private var navigationBar: some View {
        HStack {
            Spacer()
            Spacer()
            Image("logo")
            Spacer()
            Image("profile-image-placeholder")
                .resizable()
                .frame(width: 40, height: 40)
        }
        .padding(.horizontal)
    }
    
    private var profileSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Personal Information")
                .font(.title3)
                .bold()
            Text("Avatar")
                .font(.caption)
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            
            HStack {
                Image("profile-image-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                
                Button("Change") {
                    
                }
                .frame(width: 80, height: 40)
                .background(Color(red: 73/255, green: 94/255, blue: 87/255))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding()
                
                Button("Remove") {
                    
                }
                .frame(width: 80, height: 40)
                .background(.white)
                .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color(red: 73/255, green: 94/255, blue: 87/255), lineWidth: 1)
                )
            }
        }
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading) {
            Text("First name")
                .font(.subheadline)
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            TextField("", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
            
            Text("")
                .font(.subheadline)
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            TextField("Last Name", text: $lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
            
            Text("E-mail")
                .font(.subheadline)
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            TextField("", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20.0)
            
            Text("Phone number")
                .font(.subheadline)
                .foregroundColor(Color(red: 175/255, green: 175/255, blue: 175/255))
            TextField("", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10.0)
        }
    }
    
    private var emailNatificationSection: some View {
        VStack(alignment: .leading) {
            Text("Email Notification")
                .font(.title3)
                .bold()
                .padding(.bottom, 10.0)
            VStack(alignment: .leading, spacing: 10) {
                Button(action: {
                    isCheckedOrder.toggle()
                }) {
                    HStack {
                        Image(systemName: isCheckedOrder ? "checkmark.square.fill" : "square")
                            .foregroundColor(isCheckedOrder ? Color(red: 73/255, green: 94/255, blue: 87/255) : .gray)
                            .font(.system(size: 20))
                        Text("Order statuses")
                            .font(.system(size: 16))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 5.0)
                
                Button(action: {
                    isCheckedPassword.toggle()
                }) {
                    HStack {
                        Image(systemName: isCheckedPassword ? "checkmark.square.fill" : "square")
                            .foregroundColor(isCheckedPassword ? Color(red: 73/255, green: 94/255, blue: 87/255) : .gray)
                            .font(.system(size: 20))
                        Text("Password changes")
                            .font(.system(size: 16))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 5.0)
                
                Button(action: {
                    isCheckedOffer.toggle()
                }) {
                    HStack {
                        Image(systemName: isCheckedOffer ? "checkmark.square.fill" : "square")
                            .foregroundColor(isCheckedOffer ? Color(red: 73/255, green: 94/255, blue: 87/255) : .gray)
                            .font(.system(size: 20))
                        Text("Special offers")
                            .font(.system(size: 16))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 5.0)
                
                Button(action: {
                    isCheckedNewsletter.toggle()
                }) {
                    HStack {
                        Image(systemName: isCheckedNewsletter ? "checkmark.square.fill" : "square")
                            .foregroundColor(isCheckedNewsletter ? Color(red: 73/255, green: 94/255, blue: 87/255) : .gray)
                            .font(.system(size: 20))
                        Text("Newsletter")
                            .font(.system(size: 16))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 20.0)
            }
        }
    }
    
    private var buttonsSection: some View {
        HStack(alignment: .center, spacing: 20) {
            
            Button(action: {
                
            }) {
                Text("Discard changes")
                    .bold()
            }
            .frame(width: 150, height: 50)
            .background(.white)
            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(red: 73/255, green: 94/255, blue: 87/255), lineWidth: 1)
            )
            
            Button(action: {
                
            }) {
                Text("Save changes")
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(width: 150, height: 50)
            .background(Color(red: 73/255, green: 94/255, blue: 87/255))
            .foregroundColor(.white)
            .cornerRadius(8)
            .contentShape(Rectangle().size(CGSize(width: 150, height: 50)))
        }
    }
    
    private var logOutButton: some View {
        Button(action: {
            UserDefaults.standard.set(false, forKey: kIsLoggedIn)
            self.presentation.wrappedValue.dismiss()
        }) {
            Text("Log out")
                .bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(width: 350, height: 50)
        .background(Color(red: 244/255, green: 207/255, blue: 20/255))
        .foregroundColor(.black
        )
        .cornerRadius(8)
        .contentShape(Rectangle().size(CGSize(width: 350, height: 50)))
        .padding(.bottom, 20)
    }
}

#Preview {
    UserProfile()
}
