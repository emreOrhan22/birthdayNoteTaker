// create by Emre ORHAN


import SwiftUI

struct BirthdayEntry: Codable, Identifiable {
    let id = UUID()
    let name: String
    let gender: String
    let date: Date
}

struct ContentView: View {
    @State private var name: String = ""
    @State private var selectedGender: String = "Belirtilmedi"
    @State private var selectedDate: Date = Date()
    @State private var savedEntries: [BirthdayEntry] = []
    @State private var isShowingList: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Ad girin", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Button(action: {
                        selectedGender = "Kadın"
                    }) {
                        Text("Kadın")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedGender == "Kadın" ? Color.pink.opacity(0.8) : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    }

                    Button(action: {
                        selectedGender = "Erkek"
                    }) {
                        Text("Erkek")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedGender == "Erkek" ? Color.blue.opacity(0.8) : Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.black)
                    }
                }
                .padding()

                DatePicker("Doğum Günü Tarihini Seçin", selection: $selectedDate, displayedComponents: .date)
                    .padding()

                if !name.isEmpty {
                    Text("\(name) bir \(selectedGender == "Kadın" ? "Doğum Günü Kızı" : selectedGender == "Erkek" ? "Doğum Günü Çocuğu" : "Kişi")! Doğum günü: \(selectedDate, style: .date)")
                        .font(.headline)
                        .padding()
                }

                // Kaydet Butonu
                Button(action: {
                    if !name.isEmpty {
                        let newEntry = BirthdayEntry(name: name, gender: selectedGender, date: selectedDate)
                        savedEntries.append(newEntry)
                        saveEntries()
                        name = ""
                        selectedGender = "Belirtilmedi"
                        selectedDate = Date()
                    }
                }) {
                    Text("Kaydet")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // Liste ekranına gitmek için buton
                Button(action: {
                    isShowingList = true
                }) {
                    Text("Kaydedilenleri Gör")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Spacer()
            }
            .padding()
            .navigationTitle("Doğum Günü Kaydı")
            .onAppear {
                loadEntries()
            }
            .sheet(isPresented: $isShowingList) {
                SavedListView(savedEntries: $savedEntries)
            }
        }
    }

    // Verileri kaydet
    func saveEntries() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedEntries) {
            UserDefaults.standard.set(encoded, forKey: "SavedEntries")
        }
    }

    // Verileri yükle
    func loadEntries() {
        if let data = UserDefaults.standard.data(forKey: "SavedEntries") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([BirthdayEntry].self, from: data) {
                savedEntries = decoded
            }
        }
    }
}

