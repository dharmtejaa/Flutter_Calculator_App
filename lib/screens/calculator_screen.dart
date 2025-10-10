import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculator/providers/calculator_provider.dart';
import 'package:calculator/providers/theme_provider.dart';
import 'package:calculator/widgets/custom_button.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
              _buildThemeToggle(context),
              SizedBox(height: MediaQuery.of(context).size.width * 0.2),
              _buildDisplay(context),
              _buildDivider(context),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02),
              _buildCalculatorButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) {
                return RotationTransition(turns: animation, child: child);
              },
              child:
                  Provider.of<ThemeProvider>(context).themeData == lightMode
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
    );
  }

  Widget _buildDisplay(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, calculatorProvider, child) {
        return Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  textAlign: TextAlign.right,
                  calculatorProvider.userInput,
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
                  calculatorProvider.result,
                  style: TextStyle(fontSize: 40, color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      thickness: 0.6,
    );
  }

  Widget _buildCalculatorButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Row for AC, DEL, ^, / buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              title: 'AC',
              textColor: Theme.of(context).colorScheme.onSecondary,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              onPress: () => context.read<CalculatorProvider>().clearAll(),
            ),
            CustomButton(
              title: '',
              textColor: Theme.of(context).colorScheme.onSecondary,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              onPress: () => context.read<CalculatorProvider>().deleteLast(),
            ),
            CustomButton(
              title: '^',
              textColor: Theme.of(context).colorScheme.onSecondary,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              onPress:
                  () => context.read<CalculatorProvider>().addOperator('^'),
            ),
            CustomButton(
              title: '/',
              textColor: Theme.of(context).colorScheme.onSecondary,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              onPress:
                  () => context.read<CalculatorProvider>().addOperator('/'),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        // Row for 7, 8, 9, x buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              title: '7',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('7'),
            ),
            CustomButton(
              title: '8',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('8'),
            ),
            CustomButton(
              title: '9',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('9'),
            ),
            CustomButton(
              title: 'x',
              textColor: Theme.of(context).colorScheme.onSecondary,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              onPress:
                  () => context.read<CalculatorProvider>().addOperator('x'),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        // Row for 4, 5, 6, - buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              title: '4',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('4'),
            ),
            CustomButton(
              title: '5',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('5'),
            ),
            CustomButton(
              title: '6',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('6'),
            ),
            CustomButton(
              title: '-',
              textColor: Theme.of(context).colorScheme.onSecondary,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              onPress:
                  () => context.read<CalculatorProvider>().addOperator('-'),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        // Row for 1, 2, 3, + buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              title: '1',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('1'),
            ),
            CustomButton(
              title: '2',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('2'),
            ),
            CustomButton(
              title: '3',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('3'),
            ),
            CustomButton(
              title: '+',
              textColor: Theme.of(context).colorScheme.onSecondary,
              buttonColor: Theme.of(context).colorScheme.onPrimary,
              onPress:
                  () => context.read<CalculatorProvider>().addOperator('+'),
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.width * 0.02),
        // Row for %, 0, ., = buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              title: '%',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress:
                  () => context.read<CalculatorProvider>().addOperator('%'),
            ),
            CustomButton(
              title: '0',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addNumber('0'),
            ),
            CustomButton(
              title: '.',
              textColor: Theme.of(context).colorScheme.secondary,
              buttonColor: Theme.of(context).colorScheme.primary,
              onPress: () => context.read<CalculatorProvider>().addDecimal(),
            ),
            CustomButton(
              title: '=',
              textColor: Colors.white,
              buttonColor: Theme.of(context).colorScheme.onSecondary,
              onPress: () => context.read<CalculatorProvider>().evaluate(),
            ),
          ],
        ),
      ],
    );
  }
}