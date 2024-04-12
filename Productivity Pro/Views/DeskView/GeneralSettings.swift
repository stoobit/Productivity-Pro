//
//  GenerellSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct GeneralSettings: View {
    @Environment(\.horizontalSizeClass) var hsc
    
    @AppStorage("horizontalScroll") var isHorizontal: Bool = true
    @AppStorage("isMarkdownf") var markdownFullscreen: Bool = false
    
    @AppStorage("notificationTime")
    var notificationTime: Date = Calendar.current.date(
        bySettingHour: 15, minute: 30, second: 00, of: Date()
    )!
    
    @AppStorage("defaultFont")
    private var defaultFont: String = "Avenir Next"
    
    @AppStorage("defaultFontSize")
    private var defaultFontSize: Double = 12
    
    @State private var scrollSetter: Bool = true
    @State private var fontSetter: String = "Avenir Next"
    @State private var sizeSetter: Double = 12
    @State private var cbSetter: Int = 0
    
    @State private var showSizePicker: Bool = false
    @State private var showTerminationAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Notizen") {
                    Picker("Scrollrichtung der Seiten", selection: $scrollSetter) {
                        Text("Horizontal")
                            .tag(true)
                        
                        Text("Vertikal")
                            .tag(false)
                    }
                }
                .onChange(of: scrollSetter) {
                    if scrollSetter != isHorizontal {
                        showTerminationAlert = true
                    }
                }
                .alert(
                    "Einstellungen ändern?", isPresented: $showTerminationAlert,
                    actions: {
                        Button("Abbrechen", role: .cancel) {
                            scrollSetter = isHorizontal
                            showTerminationAlert = false
                        }
                        
                        Button("Neustarten") {
                            isHorizontal = scrollSetter
                            showTerminationAlert = false
                            
                            var localUserInfo: [AnyHashable: Any] = [:]
                            localUserInfo["pushType"] = "restart"
                               
                            let content = UNMutableNotificationContent()
                            content.title = String(localized: "Einstellungen geändert")
                            content.body = String(
                                localized: "Tippe um Productivity Pro zu öffnen."
                            )
                            
                            content.sound = UNNotificationSound.default
                            content.userInfo = localUserInfo
                            let trigger = UNTimeIntervalNotificationTrigger(
                                timeInterval: 0.5, repeats: false
                            )

                            let identifier = "com.stoobit.restart"
                            let request = UNNotificationRequest
                                .init(identifier: identifier, content: content, trigger: trigger)
                            
                            let center = UNUserNotificationCenter.current()
                            center.add(request)
                            
                            exit(0)
                        }
                    },
                    message: {
                        Text("Um diese Einstellungen zu ändern muss die App neugestartet werden.")
                    }
                )
                
                Section("Aufgaben") {
                    DatePicker(
                        "Uhrzeit der Benachrichtigung",
                        selection: $notificationTime,
                        displayedComponents: .hourAndMinute
                    )
                    .frame(height: 30)
                }
                
                Section("Markdown") {
                    Picker("Schriftart", selection: $fontSetter) {
                        ForEach(UIFont.familyNames, id: \.self) { font in
                            Text(font)
                                .tag(font)
                        }
                    }
                    .frame(height: 30)
                    .onChange(of: fontSetter) {
                        defaultFont = fontSetter
                    }
                    
                    HStack {
                        Text("Schriftgröße")
                        Spacer()
                        Button(String(defaultFontSize)) {
                            showSizePicker.toggle()
                        }
                        .ppDoubleKeyboard(isPresented: $showSizePicker, value: $sizeSetter)
                        .onChange(of: sizeSetter) {
                            defaultFontSize = sizeSetter
                        }
                    }
                    .frame(height: 30)
                }
                
                Picker("Markdown Editor", selection: $markdownFullscreen) {
                    Text("Kompakt")
                        .tag(false)
                    
                    Text("Groß")
                        .tag(true)
                }
            }
            .environment(\.defaultMinListRowHeight, 10)
            .navigationTitle("Allgemein")
            .onAppear {
                fontSetter = defaultFont
                sizeSetter = defaultFontSize
                scrollSetter = isHorizontal
                
                askNotificationPermission()
            }
        }
    }
    
    func askNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { _, _ in }
    }
}

#Preview {
    GeneralSettings()
}
