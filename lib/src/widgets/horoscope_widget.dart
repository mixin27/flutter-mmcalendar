// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

/// Rich astrological detail card with one-tap AI prompt generation.
class HoroscopeWidget extends StatelessWidget {
  const HoroscopeWidget({
    super.key,
    required this.date,
    this.language = Language.english,
    this.primaryColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
  });

  final CompleteDate date;
  final Language language;
  final Color? primaryColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = primaryColor ?? theme.colorScheme.primary;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: primary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildHeader(primary),
          const SizedBox(height: 14),
          _buildAstroTags(),
          const SizedBox(height: 14),
          _InfoTile(
            label: TranslationService.translateTo('Nakhat', language),
            value: TranslationService.translateTo(date.astro.nakhat, language),
            detail: MyanmarCalendar.getNakhatDescription(date.astro.nakhat),
          ),
          _InfoTile(
            label: TranslationService.translateTo('Mahabote', language),
            value: TranslationService.translateTo(
              date.astro.mahabote,
              language,
            ),
            detail: MyanmarCalendar.getMahaboteCharacteristics(
              date.astro.mahabote,
            ),
          ),
          _InfoTile(
            label: TranslationService.translateTo('Year Name', language),
            value: TranslationService.translateTo(
              date.astro.yearName,
              language,
            ),
            detail: TranslationService.translateTo('year_name_desc', language)
                .replaceAll(
                  '@year',
                  TranslationService.translateTo(date.astro.yearName, language),
                ),
          ),
          if (date.astro.nagahle.isNotEmpty)
            _InfoTile(
              label: TranslationService.translateTo('Naga Head', language),
              value: TranslationService.translateTo(
                date.astro.nagahle,
                language,
              ),
              detail: TranslationService.translateTo('naga_head_desc', language)
                  .replaceAll(
                    '@dir',
                    TranslationService.translateTo(
                      date.astro.nagahle,
                      language,
                    ),
                  ),
            ),
          const SizedBox(height: 14),
          _buildPromptButton(context, primary),
        ],
      ),
    );
  }

  Widget _buildHeader(Color primary) {
    final myanmarDateText = MyanmarCalendar.formatMyanmar(
      date.myanmar,
      pattern: '&y &M &P &ff',
      language: language,
    );

    return Row(
      children: <Widget>[
        Icon(Icons.auto_awesome, color: primary),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                TranslationService.translateTo('Horoscope Details', language),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: primary,
                ),
              ),
              Text(
                myanmarDateText,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAstroTags() {
    final tags = <String>[
      if (date.astro.yatyaza.isNotEmpty) date.astro.yatyaza,
      if (date.astro.pyathada.isNotEmpty) date.astro.pyathada,
      ...date.astro.astrologicalDays,
      if (date.astro.sabbath.isNotEmpty) date.astro.sabbath,
    ];

    if (tags.isEmpty) {
      return Text(
        TranslationService.translateTo('no_events_msg', language),
        style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags
          .map(
            (tag) => Chip(
              label: Text(
                TranslationService.translateTo(tag, language),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              backgroundColor: Colors.indigo.withValues(alpha: 0.08),
              side: BorderSide(color: Colors.indigo.withValues(alpha: 0.2)),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPromptButton(BuildContext context, Color primary) {
    return PopupMenuButton<AIPromptType>(
      onSelected: (AIPromptType type) => _copyPrompt(context, type),
      itemBuilder: (BuildContext context) {
        return const <PopupMenuEntry<AIPromptType>>[
          PopupMenuItem<AIPromptType>(
            value: AIPromptType.horoscope,
            child: Text('Horoscope'),
          ),
          PopupMenuItem<AIPromptType>(
            value: AIPromptType.fortuneTelling,
            child: Text('Fortune Telling'),
          ),
          PopupMenuItem<AIPromptType>(
            value: AIPromptType.divination,
            child: Text('Divination'),
          ),
        ];
      },
      child: FilledButton.icon(
        onPressed: null,
        icon: const Icon(Icons.copy_all),
        label: Text(
          TranslationService.translateTo('Generate AI Prompt', language),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primary,
          disabledForegroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 44),
        ),
      ),
    );
  }

  void _copyPrompt(BuildContext context, AIPromptType type) {
    final prompt = MyanmarCalendar.generateAIPrompt(
      date,
      language: language,
      type: type,
    );

    Clipboard.setData(ClipboardData(text: prompt));
    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          TranslationService.translateTo('Prompt Copied', language),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.label,
    required this.value,
    required this.detail,
  });

  final String label;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: <TextSpan>[
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            detail,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
