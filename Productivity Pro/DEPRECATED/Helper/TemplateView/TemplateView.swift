import SwiftUI

struct TemplateView: View {
    @AppStorage("savedIsPortrait")
    var savedIsPortrait: Bool = true
    
    @AppStorage("savedBackgroundTemplate")
    var savedBackgroundTemplate: String = "blank"
    
    @AppStorage("savedBackgroundColor")
    var savedBackgroundColor: String = "pagewhite"
    
    @Binding var isPresented: Bool
    
    @State var isPortrait: Bool = true
    @State var selectedColor: String = "pagewhite"
    @State var selectedTemplate: String = "blank"
    
    @State var title: String = ""
    
    let buttonTitle: LocalizedStringKey
    
    var preselectedOrientation: Bool = true
    var preselectedColor: String = "pagewhite"
    var preselectedTemplate: String = "blank"
    
    var action: (Bool, String, String, String?) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                if buttonTitle == LocalizedStringKey("Erstellen") {
                    TextField("Unbenannt", text: $title)
                        .frame(height: 30)
                }
                
                Section {
                    OrientationView()
                    ColorsView()
                }
                
                TemplateView()
            }
            .environment(\.defaultMinListRowHeight, 10)
            .scrollIndicators(.hidden)
            .listSectionSpacing(21)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen", systemImage: "xmark") { isPresented = false }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(buttonTitle, systemImage: "checkmark") {
                        action(
                            isPortrait,
                            selectedTemplate,
                            selectedColor,
                            title == "" ? nil : title
                        )
                        
                        savedIsPortrait = isPortrait
                        savedBackgroundColor = selectedColor
                        savedBackgroundTemplate = selectedTemplate
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .onAppear { viewDidAppear() }
    }
    
    func viewDidAppear() {
        if buttonTitle == LocalizedStringKey("Erstellen") {
            isPortrait = savedIsPortrait
            selectedColor = savedBackgroundColor
            selectedTemplate = savedBackgroundTemplate
        } else {
            isPortrait = preselectedOrientation
            selectedColor = preselectedColor
            selectedTemplate = preselectedTemplate
        }
    }
}
