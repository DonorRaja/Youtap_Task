//
//  ContentView.swift
//  Shared
//
//  Created by DonorRaja on 20/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var id:String = ""
    @State var name:String = ""
    @State var searchText:String = ""
    
    @State var userDetails = [User]()
    @State var filteredUser = [User]()
   
    var body: some View {
        
        NavigationView {
        
        
            VStack {
        
                ZStack {
                    RoundedRectangle(cornerRadius: 0.0)
                                    .fill(Color(red: 31/255, green: 158/255, blue: 203/255))
                                    .frame(height: 150)
                    
                    HStack(spacing:20) {
                    
                    VStack {
                        TextField(Task.userID, text: $id)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .keyboardType(.numberPad)
                        TextField(Task.userName, text: $name)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                    }
                    .padding()
                    
                    Button(action: {
                            
                            if  self.id == "" && self.name == "" {
                                self.filteredUser = self.userDetails
                                
                            }else if self.id != "" && self.name == "" {
                                let userList = self.userDetails.filter { $0.id == Int(self.id) }
                                self.filteredUser = userList
                                
                            }else if self.id == "" && self.name != "" {
                                
                                let userList = self.userDetails.filter { $0.username.hasPrefix(self.name) }
                                self.filteredUser = userList
                                
                            }else {
                                let userNameList = self.userDetails.filter { $0.username.hasPrefix(self.name) }
                                                                                               
                                let userIdList = self.userDetails.filter { $0.id == Int(self.id) }
                                self.filteredUser = userIdList + userNameList
                            }
                        
                        
                    }, label: {
                        Label(Task.searchButtonName,systemImage: Task.searchButtonImage)
                            .foregroundColor(.white)
                           
                            
                    })
                    .frame(width: 100, height: 50)
                    .border(.white)
                       
                    .padding()
                    
                }
                
            }
            
            if filteredUser.count == 0 {
                VStack(alignment: .center) {
                    Text(Task.userNotFound)
                }.padding(50)
                
            }else {
                
                List(filteredUser) { (user) in
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                                        .fill(Color.white)
                                        .border(Color.blue)
                                        .frame(height: 100)
                        VStack(alignment: .leading) {
                            Text(String(Task.user_ID + String(user.id)))
                            
                            if user.email.isValidEmail {
                                Text(Task.user_Email + user.email)
                            }
                            if user.phone.isValidPhoneNumber {
                                Text(Task.user_Phone + user.phone)
                            }
                        }.padding()
                        
                        
                    }
                     .listRowSeparator(.hidden)
                    
                        
                }.listStyle(.plain)
            }
            Spacer()
        }
        .onAppear(){
            self.Shuffle()
        }
            
        .navigationBarTitle(Text(Task.title), displayMode: .inline)
            
        }
        
        
        
    }
    
    func Shuffle() {
        UserAPI().loadData { (users) in
            self.userDetails = users
            self.filteredUser = users
        }
    }
    
    
     
}

struct ContentView_Previews: PreviewProvider {
   
    static var previews: some View {
        ContentView()
    }
}

