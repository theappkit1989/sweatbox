import 'package:flutter/services.dart';

class AutoCapitalizeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Get the text from the new value
    final text = newValue.text;

    // Create a new buffer to store the formatted text
    final buffer = StringBuffer();

    // Track if we are at the start of a new sentence
    bool isNewSentence = true;

    // Iterate through each character in the text
    for (int i = 0; i < text.length; i++) {
      // Get the current character
      final char = text[i];

      // If we are at the start of a new sentence, capitalize the character
      if (isNewSentence && char.isNotEmpty) {
        buffer.write(char.toUpperCase());
        isNewSentence = false;
      } else {
        buffer.write(char);
      }

      // Check if the character is a period
      if (char == '.') {
        // Add a space after the period if it's not the last character
        if (i + 1 < text.length && text[i + 1] != ' ') {
          buffer.write(' ');
        }
        isNewSentence = true; // Next character starts a new sentence
      }
    }

    // Return the formatted text
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
      composing: TextRange.empty,
    );
  }
}
