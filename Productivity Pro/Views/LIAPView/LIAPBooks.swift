//
//  LIAPBooks.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 21.04.24.
//

import Foundation

// MARK: AppStore Description
// Lese deine Schullektüre in Productivity Pro.

// MARK: AppStore Review Notes
// 1. Open the "Notizen" tab in the tab bar. 2. Tap on the books icon at the top. 3. A sheet with the IAP will appear.

fileprivate typealias Book = LIAPBookModel
let books: [LIAPBookModel] = [
    Book(
        iapID: "com.stoobit.productivitypro.library.book.emiliagalotti",
        title: "Emilia Galotti",
        author: "Gotthold Ephraim Lessing",
        image: "galotti"
    ),
    Book(
        iapID: "com.stoobit.productivitypro.library.book.kabaleundliebe",
        title: "Kabale und Liebe",
        author: "Friedrich Schiller",
        image: "kabale"
    ),
    Book(
        iapID: "com.stoobit.productivitypro.library.book.werther",
        title: "Die Leiden des jungen Werther",
        author: "Johann Wolfgang von Goethe",
        image: "werther"
    ),
    Book(
        iapID: "com.stoobit.productivitypro.library.book.derprozess",
        title: "Der Prozeß",
        author: "Franz Kafka",
        image: "prozess"
    ),
    Book(
        iapID: "com.stoobit.productivitypro.library.book.dereingebildetekranke",
        title: "Der eingebildete Kranke",
        author: "Molière",
        image: "kranke"
    ),
    Book(
        iapID: "com.stoobit.productivitypro.library.book.derdrauumling",
        title: "Der Dräumling",
        author: "Wilhelm Karl Raabe",
        image: "draumling"
    ),
    Book(
        iapID: "com.stoobit.productivitypro.library.book.derschimmelreiter",
        title: "Der Schimmelreiter",
        author: "Theodor Storm",
        image: "reiter"
    ),
    Book(
        iapID: "com.stoobit.productivitypro.library.book.fruehlingserwachen",
        title: "Frühlings Erwachen",
        author: "Frank Wedekind",
        image: "erwachen"
    ),
]
