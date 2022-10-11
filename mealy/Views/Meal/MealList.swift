import SwiftUI

struct MealList: View {
    @ObservedObject var mealService : MealService
    @State private var isPresented = false

    var body: some View {
        NavigationView {
            VStack {
                if(mealService.meals.isEmpty) {
                    VStack(alignment: .leading) {
                        Text("Selina, du hast noch kein Gericht hinterlegt. Solange gibt es Ravioli.").font(.title2)
                        
                        Image("Ravioli").resizable().scaledToFill().padding(60)
                    }.padding(15)
                }
                
                List {
                    ForEach(mealService.meals, id: \.id) { meal in
                        NavigationLink {
                            MealDetail(mealService: mealService, meal: meal)
                        } label: {
                            Text(meal.id)
                        }
                    }.onDelete(perform: mealService.delete)
                }.listStyle(.plain)
                
                NavigationLink(destination: MealDetail(mealService: mealService), isActive: $isPresented) { EmptyView() }
                
                Button(action: {isPresented.toggle()}) {
                    Label("Gericht hinzufügen", systemImage: "plus")
                }.tint(.accentColor).buttonStyle(.borderedProminent).controlSize(.large).buttonBorderShape(.capsule).padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
            }
            .navigationTitle("Deine Gerichte")
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        MealList(mealService: MealService()).preferredColorScheme(.dark)
    }
}
