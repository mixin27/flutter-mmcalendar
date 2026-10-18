import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/ai.dart';

import '../adaptive/mm_buttons.dart';
import '../adaptive/mm_segmented.dart';
import '../adaptive/mm_surface.dart';
import '../day/day_builder.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';

/// Builds a horoscope, fortune or divination prompt for a day with
/// `AIPromptService`, shows the start of it, and hands the full text to
/// [onPrompt] when the user taps the button.
///
/// The widget never copies, shares or sends the prompt itself: [onPrompt]
/// decides, e.g. `Clipboard.setData` or your own model call.
class AIPromptAction extends StatefulWidget {
  /// Creates the action for [date] (default: today).
  const AIPromptAction({
    required this.onPrompt,
    super.key,
    this.date,
    this.initialType = AIPromptType.horoscope,
    this.buttonLabel,
    this.previewLines = 4,
    this.style,
    this.clock,
  });

  /// Receives the prompt kind and full text.
  final void Function(AIPromptType type, String prompt) onPrompt;

  /// The day; today when null.
  final DateTime? date;

  /// The kind selected at first.
  final AIPromptType initialType;

  /// The button text; "Copy prompt" by default.
  final String? buttonLabel;

  /// How many lines of the prompt to preview; 0 hides the preview.
  final int previewLines;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  @override
  State<AIPromptAction> createState() => _AIPromptActionState();
}

class _AIPromptActionState extends State<AIPromptAction> {
  late AIPromptType _type = widget.initialType;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);

    return DayBuilder(
      date: widget.date,
      clock: widget.clock,
      builder: (context, day, _) {
        final prompt = AIPromptService.generatePrompt(
          day,
          language: scope.language,
          type: _type,
        );
        return MmSurface(
          style: widget.style,
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: MmSegmented<AIPromptType>(
                  segments: {
                    AIPromptType.horoscope: strings.horoscope,
                    AIPromptType.fortuneTelling: strings.fortune,
                    AIPromptType.divination: strings.divination,
                  },
                  selected: _type,
                  style: widget.style,
                  onChanged: (t) => setState(() => _type = t),
                ),
              ),
              if (widget.previewLines > 0) ...[
                const SizedBox(height: 12),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.surfaceVariant.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      prompt,
                      maxLines: widget.previewLines,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textStyle(
                        TextStyle(color: theme.ink, fontSize: 12.5),
                        scope.language,
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: MmButton(
                  label: widget.buttonLabel ?? strings.copyPrompt,
                  icon: Icons.auto_awesome_outlined,
                  style: widget.style,
                  onPressed: () => widget.onPrompt(_type, prompt),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
