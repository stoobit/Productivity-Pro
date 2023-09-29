# Productivity Pro
### Data Models
| ContentObjects              | Exportable                        | Document                        |
| --------------------------- | --------------------------------- | ------------------------------- |
| `Productivity Pro 2.0`      | `Productivity Pro 2.0`            | `Productivity Pro 1.0`          |
| • intern document models    | • exportable file types           | • old file type: ~~deprecated~~ |
| • storing notes and folders | • sharing notes and backups       | • import docs of version 1.0    |
| • **no file extension**     | • **.pronote** and **.probackup** | • **.pro**                      |

#### DataModel Checklist
- [ ] SwiftData Model for PPNote, PPPage and PPPageItems 
- [ ] Export Models with `struct` and `Codable` of `Note`
- [ ] Export Models with `sturct` and `Codable` of `Backup` <- [`ContentObject`] with `item` containing `Note`
