//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Mert Özcan on 20.05.2024.
//

import SwiftUI

struct UserProfile: View {
    let firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
            
            Text("First Name: \(firstName)")
            Text("Last Name: \(lastName)")
            Text("Email: \(email)")
        }
    }
}

#Preview {
    UserProfile()
}
