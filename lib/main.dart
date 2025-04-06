import 'package:calculator/custom_widgets/button.dart'; // Import custom button widget.
import 'package:calculator/splash_screen/splash_screen.dart'; // Import Splash Screen
import 'package:calculator/theme/theme.dart'; // Import theme provider and themes.
import 'package:flutter/material.dart'; // Import Flutter's Material Design library.
import 'package:math_expressions/math_expressions.dart'; // Import for parsing and evaluating mathematical expressions.
import 'package:provider/provider.dart'; // Import for state management using Provider.
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // <-- Add this line

  // Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

/// Root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), //Splash Screen
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

/// Home page of the calculator application.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// Stores user input.
  var userInput = '';

  /// Stores calculated result.
  var result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<ThemeProvider>(
                          context,
                          listen: false,
                        ).toggleTheme();
                      },
                      // Theme mode icon
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),

                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                            turns: animation,
                            child: child,
                          );
                        },
                        child:
                            Provider.of<ThemeProvider>(context).themeData ==
                                    lightMode
                                ? const Icon(
                                  Icons.dark_mode_sharp,
                                  key: ValueKey("moon"),
                                  size: 30,
                                )
                                : const Icon(
                                  Icons.wb_sunny,
                                  key: ValueKey("sun"),
                                  size: 30,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
              // Display user input in a scrollable view.
              SizedBox(height: MediaQuery.of(context).size.width * 0.2),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        textAlign: TextAlign.right,
                        userInput,
                        style: TextStyle(
                          fontSize: 60,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //horizontal divider
              Divider(
                color: Theme.of(context).colorScheme.primary,
                thickness: 0.6,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              // Calculator buttons.
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row for AC, DEL, ^, / buttons.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        title: 'AC',
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        buttonColor: Theme.of(context).colorScheme.onPrimary,
                        onPress: () {
                          // Clear input and result.
                          setState(() {
                            userInput = '';
                            result = '';
                          });
                        },
                      ),
                      CustomButton(
                        title: '',
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        buttonColor: Theme.of(context).colorScheme.onPrimary,
                        onPress: () {
                          // Delete last character of expression.
                          setState(() {
                            result = '';
                            if (userInput.isNotEmpty) {
                              userInput = userInput.substring(
                                0,
                                userInput.length - 1,
                              );
                            }
                            //if operator present at the end of the operation do nothing, else autovaildate the expression
                            if (isOperatorAllowed(userInput)) {
                              return;
                            }
                          });
                        },
                      ),
                      CustomButton(
                        title: '^',
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        buttonColor: Theme.of(context).colorScheme.onPrimary,
                        onPress: () {
                          setState(() {
                            // Prevent consecutive operators.
                            if (isOperatorAllowed(userInput)) {
                              return;
                            }
                            userInput += '^';
                          });
                        },
                      ),
                      CustomButton(
                        title: '/',
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        buttonColor: Theme.of(context).colorScheme.onPrimary,
                        onPress: () {
                          setState(() {
                            // Prevent consecutive operators.
                            if (isOperatorAllowed(userInput)) {
                              return;
                            }
                            userInput += '/';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  // Row for 7, 8, 9, x  buttons.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        title: '7',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '7';
                          });
                        },
                      ),
                      CustomButton(
                        title: '8',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '8';
                          });
                        },
                      ),
                      CustomButton(
                        title: '9',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '9';
                          });
                        },
                      ),
                      CustomButton(
                        title: 'x',
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        buttonColor: Theme.of(context).colorScheme.onPrimary,
                        onPress: () {
                          setState(() {
                            // Prevent consecutive operators.
                            if (isOperatorAllowed(userInput)) {
                              return;
                            }
                            userInput += 'x';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  // Row for 4, 5, 6, -  buttons.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        title: '4',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '4';
                          });
                        },
                      ),
                      CustomButton(
                        title: '5',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '5';
                          });
                        },
                      ),
                      CustomButton(
                        title: '6',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '6';
                          });
                        },
                      ),
                      CustomButton(
                        title: '-',
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        buttonColor: Theme.of(context).colorScheme.onPrimary,
                        onPress: () {
                          setState(() {
                            // Conditional statement: Check if userInput is not empty AND the last character is an operator.
                            if (userInput.isNotEmpty &&
                                RegExp(
                                  r'[\^/x\-\+%\.]',
                                ).hasMatch(userInput[userInput.length - 1])) {
                              // If true, do nothing.
                              return;
                            }
                            userInput += '-';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  // Row for 1, 2, 3, +  buttons.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        title: '1',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '1';
                          });
                        },
                      ),
                      CustomButton(
                        title: '2',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '2';
                          });
                        },
                      ),
                      CustomButton(
                        title: '3',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '3';
                          });
                        },
                      ),
                      CustomButton(
                        title: '+',
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        buttonColor: Theme.of(context).colorScheme.onPrimary,
                        onPress: () {
                          setState(() {
                            // Prevent consecutive operators.
                            if (isOperatorAllowed(userInput)) {
                              return;
                            }
                            userInput += '+';
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.02),
                  // Row for &, 0, .  =  buttons.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        title: '%',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            // Prevent consecutive operators.
                            if (isOperatorAllowed(userInput)) {
                              return;
                            }
                            userInput += '%';
                          });
                        },
                      ),
                      CustomButton(
                        title: '0',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            userInput += '0';
                          });
                        },
                      ),
                      CustomButton(
                        title: '.',
                        textColor: Theme.of(context).colorScheme.secondary,
                        buttonColor: Theme.of(context).colorScheme.primary,
                        onPress: () {
                          setState(() {
                            if (userInput.isEmpty ||
                                RegExp(r'[\^/x\-\+%]$').hasMatch(userInput)) {
                              // Prevent starting with '.' or placing it right after an operator
                              userInput += '0.';
                            } else if (!RegExp(
                              r'\d+\.\d*$',
                            ).hasMatch(userInput)) {
                              // Add '.' only if the current number doesn't already have one
                              userInput += '.';
                            }
                          });
                        },
                      ),
                      CustomButton(
                        title: '=',
                        textColor: Colors.white,
                        buttonColor: Theme.of(context).colorScheme.onSecondary,
                        onPress: () {
                          setState(() {
                            evaluate();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //checks the arithmetic symbol at end of expression
  bool isOperatorAllowed(String input) {
    return input.isEmpty ||
        RegExp(r'[\^/x\-\+%\.]').hasMatch(input[input.length - 1]);
  }

  /// Parses and evaluates the mathematical expression entered by the user.
  void evaluate() {
    try {
      String finalInput = userInput.replaceAll('x', '*');
      // ignore: deprecated_member_use
      Expression expression = Parser().parse(finalInput);
      ContextModel contextModel = ContextModel();
      double evalResult = expression.evaluate(
        EvaluationType.REAL,
        contextModel,
      );
      // Convert integer results to int, else keep precision
      result =
          evalResult == evalResult.toInt()
              ? evalResult.toInt().toString()
              : evalResult.toStringAsFixed(6);
    } catch (e) {
      result = 'Invalid Expression';
    }
  }
}
