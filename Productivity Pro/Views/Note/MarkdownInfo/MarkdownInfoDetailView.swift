//
//  MarkdownInfoDetailView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 19.03.23.
//

import SwiftUI
import MarkdownUI
import Splash

struct MarkdownInfoDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let type: MarkdownView
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                switch type {
                case .header:
                    HeaderView()
                case .bold:
                    BoldView()
                case .italic:
                    ItalicView()
                case .strikethrough:
                    StrikethroughView()
                case .orderedList:
                    OrderedListView()
                case .unorderedList:
                    UnorderedListView()
                case .taskList:
                    TaskListView()
                case .code:
                    CodeView()
                case .codeBlock:
                    CodeBlockView()
                case .blockquote:
                    BlockquoteView()
                case .link:
                    LinkView()
                case .linebreak:
                    LinebreakView()
                }
            }
            .textSelection(.enabled)
            .listStyle(.plain)
            .toolbarRole(.navigationStack)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(type.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Close") {
                        isPresented.toggle()
                    }
                    .keyboardShortcut(.return, modifiers: [])
                }
            }
        }
    }
    
    @ViewBuilder func HeaderView() -> some View {
        Section("Markdown") {
            Text(
            """
            # Header 1
            ## Header 2
            ### Header 3
            #### Header 4
            ##### Header 5
            ###### Header 6
            """
            )
        }
        Section("Output") {
            Markdown {
"""
# Header 1
## Header 2
### Header 3
#### Header 4
##### Header 5
###### Header 6
"""
            }
        }
    }
    @ViewBuilder func BoldView() -> some View {
        Section("Markdown") {
            Text(
                String(
                    "To make a text **bold** in Markdown you have to put two asterisks **before** and **after** the text."
                )
            )
        }
        Section("Output") {
            Markdown {
                "To make a text **bold** in Markdown you have to put two asterisks **before** and **after** the text."
            }
        }
    }
    @ViewBuilder func ItalicView() -> some View {
        Section("Markdown") {
            Text(
                String(
                    "To make a text *italic* in Markdown you have to put one asterisks *before* and *after* the text."
                )
            )
        }
        Section("Output") {
            Markdown {
                "To make a text *italic* in Markdown you have to put one asterisks *before* and *after* the text."
            }
        }
    }
    @ViewBuilder func StrikethroughView() -> some View {
        Section("Markdown") {
            Text(
                String(
                    "This is how you can strike through ~~text~~."
                )
            )
        }
        Section("Output") {
            Markdown {
                "This is how you can strike through ~~text~~."
            }
            .markdownTextStyle(\.strikethrough) {
                StrikethroughStyle(.init(pattern: .solid, color: .red))
            }
        }
    }
    @ViewBuilder func OrderedListView() -> some View {
        Section("Markdown") {
            Text(
                String(
                    "1. First Item\n1. Second Item\n1. Third Item"
                )
            )
        }
        Section("Output") {
            Markdown {
"""
1. First Item
1. Second Item
1. Third Item
"""
            }
        }
    }
    @ViewBuilder func UnorderedListView() -> some View {
        Section("Markdown") {
            Text(
                String(
                    "- First Item\n- Second Item\n- Third Item"
                )
            )
        }
        Section("Output") {
            Markdown {
"""
- First Item
- Second Item
- Third Item
"""
            }
        }
    }
    @ViewBuilder func TaskListView() -> some View {
        Section("Markdown") {
            Text(
                String(
                    "- [x] Task One\n- [x] Task Two\n- Task Three"
                )
            )
        }
        Section("Output") {
            Markdown {
"""
- [x] Task One
- [x] Task Two
- Task Three
"""
            }
        }
    }
    @ViewBuilder func CodeView() -> some View {
        Section("Markdown") {
            Text(
                String(
                    "In SwiftUI, a `View` is a basic building block of the user interface. It represents a visible and interactive element on the screen, such as a `Button`, a `TextField`, or an `Image`."
                )
            )
        }
        Section("Output") {
            Markdown {
                "In SwiftUI, a `View` is a basic building block of the user interface. It represents a visible and interactive element on the screen, such as a `Button`, a `TextField`, or an `Image`."
            }
            .markdownTextStyle(\.code) {
                FontWeight(.bold)
                FontFamilyVariant(.monospaced)
                ForegroundColor(Color("codecolor"))
            }
        }
    }
    @ViewBuilder func CodeBlockView() -> some View {
        Section("Markdown") {
            Text(
                String(
#"""
This is a simple view in SwiftUI:
```
struct MyView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
```
"""#
                ).trimmingCharacters(in: .whitespacesAndNewlines)
            )
        }
        Section("Output") {
            Markdown {
                """
This is a simple view in SwiftUI:
```
struct MyView: View {
    var body: some View {
        Text("Hello, World!")
    }
}
```
"""
            }
            .markdownCodeSyntaxHighlighter(.splash(theme: self.theme))
        }
    }
    @ViewBuilder func BlockquoteView() -> some View {
        Section("Markdown") {
            Text(
                String(
"""
> "You can’t connect the dots looking forward; you can only connect them looking backwards.
> So you have to trust that the dots will somehow connect in your future. You have to trust in something — your gut, destiny, life, karma, whatever.
> This approach has never let me down, and it has made all the difference in my life."

- Steve Jobs
"""
                ).trimmingCharacters(in: .whitespacesAndNewlines)
            )
        }
        Section("Output") {
            Markdown {
              """
              > "You can’t connect the dots looking forward; you can only connect them looking backwards.
              > So you have to trust that the dots will somehow connect in your future. You have to trust in something — your gut, destiny, life, karma, whatever.
              > This approach has never let me down, and it has made all the difference in my life."

              – Steve Jobs
              """
            }

        }
    }
    @ViewBuilder func LinkView() -> some View {
        Section("Markdown") {
            Text(
                String("This is a link to [stoobit.com](https://www.stoobit.com)")
            )
        }
        Section("Output") {
            Markdown {
                "This is a link to [stoobit.com](https://www.stoobit.com)"
            }
            .markdownTextStyle(\.link) {
                ForegroundColor(Color.accentColor)
            }
        }
    }
    @ViewBuilder func LinebreakView() -> some View {
        Section("Markdown") {
            Text(
                String("With a backslash\\\nyou can do a linebreak.")
            )
        }
        Section("Output") {
            Markdown {
                """
With a backslash \\
you can do a linebreak.
"""
            }
        }
    }
    
    private var theme: Splash.Theme {
        switch self.colorScheme {
        case .dark:
            return .wwdc17(withFont: .init(size: 16))
        default:
            return .presentation(withFont: .init(size: 16))
        }
    }
    
}

enum MarkdownView: String {
    case header = "Header"
    case bold = "Bold"
    case italic = "Italic"
    case strikethrough = "Strikethrough"
    case orderedList = "Ordered List"
    case unorderedList = "Unordered List"
    case taskList = "Task List"
    case code = "Code"
    case codeBlock = "Code Block"
    case blockquote = "Blockquote"
    case link = "Link"
    case linebreak = "Line Break"
}
