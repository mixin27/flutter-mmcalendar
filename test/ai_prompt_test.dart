import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';

void main() {
  group('AIPromptService & MyanmarCalendar AI Prompt Tests', () {
    test('generateAIPrompt should support different types', () {
      final dateTime = DateTime(2024, 5, 20);
      final date = MyanmarCalendar.getCompleteDate(dateTime);

      // Horoscope Type
      final promptH = MyanmarCalendar.generateAIPrompt(
        date,
        language: Language.english,
        type: AIPromptType.horoscope,
      );
      expect(promptH, contains('horoscope reading'));

      // Fortune Telling Type
      final promptF = MyanmarCalendar.generateAIPrompt(
        date,
        language: Language.english,
        type: AIPromptType.fortuneTelling,
      );
      expect(promptF, contains('fortune-telling reading'));
      expect(promptF, contains('wealth, relationships, and success'));

      // Divination Type
      final promptD = MyanmarCalendar.generateAIPrompt(
        date,
        language: Language.english,
        type: AIPromptType.divination,
      );
      expect(promptD, contains('divination session'));
      expect(promptD, contains('spiritual path'));
    });

    test(
      'generateAIPrompt should respect specified language for all types',
      () {
        final dateTime = DateTime(2024, 5, 20);
        final date = MyanmarCalendar.getCompleteDate(dateTime);

        final promptMM = MyanmarCalendar.generateAIPrompt(
          date,
          language: Language.myanmar,
          type: AIPromptType.fortuneTelling,
        );

        expect(promptMM, contains('ဗေဒင်ဟောစာတမ်း'));
        expect(promptMM, contains('စည်းစိမ်ဥစ္စာ'));
        expect(promptMM, contains('ယတြာ'));
      },
    );
  });
}
