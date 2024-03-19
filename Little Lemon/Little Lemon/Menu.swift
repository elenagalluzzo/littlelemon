//
//  Menu.swift
//  Little Lemon
//
//  Created by Elena Galluzzo on 2024-03-12.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    @State var categorySelected = ""
    var body: some View {
        VStack {
            ZStack {
                LittleLemonLogo()
                    .padding(.bottom, 20)
                HStack {
                    Spacer()
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .frame(width: 50)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 20))
                }
            }
            ZStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            
                            Text("Little Lemon")
                                .font(.largeTitle)
                                .foregroundStyle(Color("approvedYellow"))
                            Text("Chicago")
                                .font(.title2)
                                .foregroundStyle(.white)
                            
                            Text("""
                "We are a family owned
                 Mediterranean restaurant,
                 focused on traditional
                 recipes served with a
                 modern twist.
                """)
                            .font(.callout)
                            .foregroundStyle(.white)
                            .fixedSize(horizontal: false, vertical: true)
                            
                        }
                        Image("HomePic")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search menu", text: $searchText)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray.opacity(0.2))).background(.white).cornerRadius(20)
                    
                }
                
                .padding()
                .background(Color("oliveGreen"))
            }
            Text("ORDER FOR DELIVERY!")
                .font(.title2)
            HStack {
                Button("Starters") {
                    categorySelected = "starters"
                }
                .font(.callout)
                .foregroundStyle(Color("oliveGreen"))
                .padding()
                .background(categorySelected == "starters" ? Color("oliveGreen").opacity(0.2) : Color("oliveGreen").opacity(0.4))
                .cornerRadius(20)
                Button("Mains") {
                    categorySelected = "mains"
                }
                .font(.callout)
                .foregroundStyle(Color("oliveGreen"))
                .padding()
                .background(categorySelected == "mains" ? Color("oliveGreen").opacity(0.2) : Color("oliveGreen").opacity(0.4))
                .cornerRadius(20)
                Button("Desserts") {
                    categorySelected = "desserts"
                }
                .font(.callout)
                .foregroundStyle(Color("oliveGreen"))
                .padding()
                .background(categorySelected == "desserts" ? Color("oliveGreen").opacity(0.2) : Color("oliveGreen").opacity(0.4))
                .cornerRadius(20)
                Button("Drinks") {
                    categorySelected = "drinks"
                }
                .font(.callout)
                .foregroundStyle(Color("oliveGreen"))
                .padding()
                .background(categorySelected == "drinks" ? Color("oliveGreen").opacity(0.2) : Color("oliveGreen").opacity(0.4))
                .cornerRadius(20)
            }
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id:\.self) { dish in
                        HStack {
                            VStack (alignment: .leading){
                                Text((dish.title ?? ""))
                                    .font(.title3)
                                Text((dish.descrip ?? ""))
                                    .font(.caption)
                                Text(" $" + (String(format: "%.2f", Float(dish.price ?? "") ?? 0)))
                            }
                            Spacer()
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .onAppear {
            getMenuData()
        }
    }
    func getMenuData() {
        PersistenceController.shared.clear()
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menuList = try? decoder.decode(MenuList.self, from: data) {
                    for item in menuList.menu {
                        let newDish = Dish(context: viewContext)
                        newDish.title = item.title
                        newDish.image = item.image
                        newDish.price = item.price
                        newDish.category = item.category
                        newDish.descrip = item.description
                    }
                    try? viewContext.save()
                }
            }
        }
        task.resume()
        
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText == "" && categorySelected == "" {
            return NSPredicate(value: true)
        } else if searchText == "" {
            return NSPredicate(format: "category CONTAINS[cd] %@", categorySelected)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

#Preview {
    Menu()
}
