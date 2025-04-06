# 🧮 Flutter Calculator App

A clean and functional calculator app built with **Flutter**, featuring a custom UI, animated theme switcher (light/dark mode), and expression evaluation using the `math_expressions` package.

This project is ideal for Flutter beginners and mobile developers looking to implement real-time calculations with beautiful UI and smooth animations.

---

## 🚀 Features

- 🔢 **Basic Arithmetic Operations**: `+`, `-`, `×`, `÷`, `%`, `^`, and decimal support.
- 🎨 **Custom UI**: Elegant button layout with themed color palettes.
- 🌗 **Animated Theme Toggle**: Switch between light and dark themes using a sun 🌞 / moon 🌙 animation.
- 🖥️ **Responsive Design**: Scrollable input/output for long expressions.
- 💥 **Clear/Delete Functionality**: Easily reset input or remove the last character.
- 🚀 **Splash Screen**: Smooth transition from launch to calculator view.

---

## 📸 Screenshots

| Light Mode | Dark Mode |
|------------|-----------|
| ![image alt](https://github.com/dharmtejaa/Flutter_Calculator_App/blob/08a50ebc131ce7bf496e3a97981ac2fb96af2829/assets/output/light_mode.jpg) | ![image alt](https://github.com/dharmtejaa/Flutter_Calculator_App/blob/08a50ebc131ce7bf496e3a97981ac2fb96af2829/assets/output/dark_mode.jpg) |

---

---

## 🎥 Demo


|--------|
| ▶️ [Watch Demo Video](assets/output/calculator_output.mp4)

|

> _This demo shows the theme toggle, splash screen, and interactive calculations._

---

## 📁 Project Structure

```
lib/
├── main.dart               # App logic & UI
├── components              
│   └── constants.dart      # Color & style constants
├── custom_widgets         
│   └── button.dart         # Custom calculator buttons
├── theme/
│   └── theme.dart          # Theme toggle and management
├── splash_screen/
│   └── splash_screen.dart  # Launch splash screen
```

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  math_expressions: ^2.2.0
```

Install with:

```bash
flutter pub get
```

---

## 🛠️ Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/flutter-calculator.git
   cd flutter-calculator
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

> Make sure you have [Flutter installed](https://flutter.dev/docs/get-started/install) and a device/emulator connected.

---

## 📌 Use Cases

- Learning Flutter layout, custom widgets, and state management
- Implementing real-time math expression evaluation
- Creating visually appealing UI with animations
- Portfolio or internship demonstration project

---

## 👨‍💻 Author

**Dharma Teja**  
📧 dharmateja238@gmail.com

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

> ⭐ Star this repo if you like it! Contributions are welcome.
