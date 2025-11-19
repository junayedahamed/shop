# Ocad - Shop App

Ocad is a cross-platform shopping application built with Flutter, targeting desktop platforms (Windows, Linux, and macOS) as well as web. The app provides an interface for users to browse products, log in or register accounts, and interact with shop-related features.

## Features

- **Product Catalog**: Browse a wide variety of products.
- **User Authentication**: Register, log in, and manage your account securely.
- **Cross-Platform**: Runs on Windows, Linux, macOS, and the web.
- **REST API Integration**: Fetches products and user data from a backend API.
- **Responsive UI**: Optimized for desktop and web experiences.

## Tech Stack

- **Dart & Flutter** – UI and business logic
- **C++/C** – Desktop integration and platform-specific code
- **CMake** – Cross-platform build configuration
- **Swift** – macOS platform support
- **HTML** – Web entry point

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- For desktop: Platform-specific dependencies (GTK for Linux, Visual Studio for Windows, Xcode for macOS)
- For web: Modern web browser

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/junayedahamed/shop.git
   cd shop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   - Add a `.env` file in the root directory with required API keys or endpoints.

4. **Run on your platform**
   - **Web**
     ```bash
     flutter run -d chrome
     ```
   - **Windows**
     ```bash
     flutter run -d windows
     ```
   - **Linux**
     ```bash
     flutter run -d linux
     ```
   - **macOS**
     ```bash
     flutter run -d macos
     ```

## File Structure

- `lib/` – Dart source code (UI, logic, API calls)
- `web/` – Web entry point (index.html)
- `windows/`, `linux/`, `macos/` – Platform-specific build and runner files (CMake, C++/Swift)
- `assets/` – Images and other static files (if any)

## Contributing

Pull requests are welcome! For major changes, please open an issue first to discuss what you would like to change.

## License

This project is open source and available under the [MIT License](LICENSE).

## Credits

Developed by [junayedahamed](https://github.com/junayedahamed).
