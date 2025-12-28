
# GoEvent App Blueprint

## Overview

GoEvent is a mobile application for discovering local events. Users can browse, search, and view details for various events happening in their area.

## Features

*   **Home Page:** Displays a list of upcoming events.
*   **Search:** Allows users to search for specific events.
*   **Event Details:** Shows detailed information about an event.
*   **Favorites:** Users can save events they are interested in.
*   **Profile:** User profile section.
*   **Bottom Navigation:** Easy navigation between the main sections of the app.

## Design

*   **Colors:** The primary color is a shade of red, with a clean white background.
*   **Typography:** The app will use the Poppins font from Google Fonts for a modern and clean look.
*   **Layout:** The layout is card-based, with each event displayed in a visually appealing card.

## Plan

1.  **Dependencies:** Add `google_fonts` and `provider` to `pubspec.yaml`.
2.  **Assets:** Add images to the `assets/images` directory and declare them in `pubspec.yaml`.
3.  **`main.dart`:**
    *   Set up `ChangeNotifierProvider` for theme management.
    *   Define the main app theme using `ThemeData`, including `ColorScheme` and `TextTheme` with `GoogleFonts`.
    *   Set up the main `MaterialApp` with a `BottomNavigationBar`.
4.  **`home_page.dart`:**
    *   Build the main UI for the home page.
    *   Include an `AppBar` with the "GoEvent" title.
    *   Add a search bar.
    *   Create a `GridView` to display the event cards.
5.  **`event_card.dart`:**
    *   Create a reusable widget to display individual event information, including:
        *   Event image
        *   Title
        *   Location
        *   Date
        *   Price
6.  **Dummy Pages:**
    *   Create placeholder pages for the "Add Event," "Favorites," and "Profile" sections to be implemented later.
