# Calculator App

A modern Flutter calculator application with clean architecture, Provider state management, and beautiful UI design.

## 🚀 Features

- **Modern Calculator Interface**: Clean and intuitive design with smooth animations
- **Dark/Light Theme**: Toggle between dark and light themes with animated transitions
- **Advanced Operations**: Support for basic arithmetic operations (+, -, ×, ÷, ^, %)
- **Real-time Calculation**: Instant evaluation of mathematical expressions
- **Responsive Design**: Adapts to different screen sizes
- **Provider State Management**: Clean separation of concerns using Provider pattern
- **Splash Screen**: Beautiful loading screen with app branding

## 🚀 Features

The app includes:
- **Splash Screen**: App logo and branding
- **Calculator Screen**: Main calculator interface with theme toggle

---

## 📸 Screenshots

| Light Mode | Dark Mode |
|------------|-----------|
| ![image alt](https://github.com/dharmtejaa/Flutter_Calculator_App/blob/08a50ebc131ce7bf496e3a97981ac2fb96af2829/assets/output/light_mode.jpg) | ![image alt](https://github.com/dharmtejaa/Flutter_Calculator_App/blob/08a50ebc131ce7bf496e3a97981ac2fb96af2829/assets/output/dark_mode.jpg) |

### State Management
This project uses **Provider** for state management, eliminating the need for `setState()` calls:

- **CalculatorProvider**: Manages calculator state (user input, results, operations)
- **ThemeProvider**: Manages theme switching between light and dark modes

## 🎥 Demo

#### Providers
- **CalculatorProvider**: Handles all calculator logic including:
  - Number input
  - Operator input
  - Expression evaluation
  - Input validation
  - Result formatting

- **ThemeProvider**: Manages theme state with:
  - Light/dark theme switching
  - Animated theme transitions
  - Persistent theme state

#### Screens
- **SplashScreen**: App introduction with timer-based navigation
- **CalculatorScreen**: Main calculator interface with:
  - Theme toggle button
  - Real-time display
  - Calculator buttons grid
  - Responsive layout

#### Widgets
- **CustomButton**: Reusable button component with:
  - Custom styling
  - Icon support (for delete button)
  - Consistent theming

## 🎨 Design Features

### Color Scheme
- **Light Theme**: Clean white background with blue accents
- **Dark Theme**: Dark background with contrasting elements
- **Custom Colors**: Defined in `constants/colors.dart`

### UI Elements
- **Rounded Buttons**: Modern circular button design
- **Animated Theme Toggle**: Smooth rotation animation
- **Scrollable Display**: Horizontal scrolling for long expressions
- **Responsive Layout**: Adapts to different screen sizes

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd calculator
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  math_expressions: ^2.7.0  # Mathematical expression parsing
  provider: ^6.0.0          # State management
```

## 🔧 Key Features Implementation

### Calculator Logic
- **Expression Parsing**: Uses `math_expressions` package for safe evaluation
- **Input Validation**: Prevents invalid expressions and consecutive operators
- **Decimal Handling**: Smart decimal point placement
- **Error Handling**: Graceful handling of invalid expressions

### State Management Benefits
- **No setState()**: All state changes handled through Provider
- **Reactive UI**: Automatic UI updates when state changes
- **Separation of Concerns**: Business logic separated from UI
- **Testability**: Easy to test individual components

### Theme System
- **Dynamic Theming**: Runtime theme switching
- **Animated Transitions**: Smooth theme change animations
- **Consistent Styling**: All components follow theme colors

## 🧪 Testing

The project includes basic widget tests:
```bash
flutter test
```


## 🔄 Migration from setState to Provider

This project was refactored from using `setState()` to Provider pattern:

### Before (setState approach):
```dart
class _MyHomePageState extends State<MyHomePage> {
  String userInput = '';
  String result = '';
  
  void addNumber(String number) {
    setState(() {
      userInput += number;
    });
  }
}
```

### After (Provider approach):
```dart
class CalculatorProvider with ChangeNotifier {
  String _userInput = '';
  String _result = '';
  
  void addNumber(String number) {
    _userInput += number;
    notifyListeners();
  }
}
```

## 🎯 Benefits of the New Architecture

1. **Maintainability**: Clean separation of concerns
2. **Scalability**: Easy to add new features
3. **Testability**: Isolated components for testing
4. **Performance**: Efficient state updates
5. **Code Reusability**: Shared providers across screens

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Developer

**Developer**: @dharmtejaa

---

**Note**: This calculator app demonstrates modern Flutter development practices with clean architecture and proper state management using Provider pattern.
