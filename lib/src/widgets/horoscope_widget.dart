import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/localization/translation_service.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/utils/astro_details.dart';
import 'package:flutter_mmcalendar/src/utils/date_extension.dart';

/// A widget that displays detailed astrological and horoscope information
class HoroscopeWidget extends StatelessWidget {
  /// The date to display horoscope for
  final CompleteDate date;

  final Language _language;

  /// Primary color for headers
  final Color? primaryColor;

  /// Background color for the widget
  final Color? backgroundColor;

  /// Padding around the widget
  final EdgeInsetsGeometry padding;

  /// Create a new [HoroscopeWidget]
  HoroscopeWidget({
    super.key,
    required this.date,
    Language? language,
    this.primaryColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16.0),
  }) : _language = language ?? TranslationService.currentLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePrimaryColor = primaryColor ?? theme.colorScheme.primary;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(effectivePrimaryColor),
          const Divider(height: 24),
          _buildSectionTitle(
            TranslationService.translateTo('Astrological Days', _language),
            effectivePrimaryColor,
          ),
          _buildAstrologicalDays(),
          const SizedBox(height: 16),
          _buildSectionTitle(
            TranslationService.translateTo('Nakhat & Year', _language),
            effectivePrimaryColor,
          ),
          _buildDetailTile(
            TranslationService.translateTo('Nakhat', _language),
            TranslationService.translateTo(date.astro.nakhat, _language),
            AstroDetails.getNakhatDescription(
              date.astro.nakhat,
              language: _language,
            ),
          ),
          _buildDetailTile(
            TranslationService.translateTo('Year Name', _language),
            TranslationService.translateTo(date.astro.yearName, _language),
            TranslationService.translateTo(
              'year_name_desc',
              _language,
            ).replaceAll(
              '@year',
              TranslationService.translateTo(date.astro.yearName, _language),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle(
            TranslationService.translateTo(
              'Mahabote & Characteristics',
              _language,
            ),
            effectivePrimaryColor,
          ),
          _buildDetailTile(
            TranslationService.translateTo('Mahabote', _language),
            TranslationService.translateTo(date.astro.mahabote, _language),
            AstroDetails.getMahaboteCharacteristics(
              date.astro.mahabote,
              language: _language,
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle(
            TranslationService.translateTo('General Info', _language),
            effectivePrimaryColor,
          ),
          _buildDetailTile(
            TranslationService.translateTo('Naga Head', _language),
            TranslationService.translateTo(date.astro.nagahle, _language),
            TranslationService.translateTo(
              'naga_head_desc',
              _language,
            ).replaceAll(
              '@dir',
              TranslationService.translateTo(date.astro.nagahle, _language),
            ),
          ),
          if (date.astro.sabbath.isNotEmpty)
            _buildDetailTile(
              TranslationService.translateTo('Religious Day', _language),
              TranslationService.translateTo(date.astro.sabbath, _language),
              TranslationService.translateTo(
                'today_is_msg',
                _language,
              ).replaceAll(
                '@day',
                TranslationService.translateTo(date.astro.sabbath, _language),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(Color primaryColor) {
    return Row(
      children: [
        Icon(Icons.auto_awesome, color: primaryColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TranslationService.translateTo('Horoscope Details', _language),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Text(
                date.myanmar.format(language: _language),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: color.withValues(alpha: 0.8),
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildAstrologicalDays() {
    final days = date.astro.astrologicalDays;
    final yatyaza = date.astro.yatyaza;
    final pyathada = date.astro.pyathada;

    final allDays = <String>[];
    if (yatyaza.isNotEmpty) allDays.add(yatyaza);
    if (pyathada.isNotEmpty) allDays.add(pyathada);
    allDays.addAll(days);

    if (allDays.isEmpty) {
      return Text(
        TranslationService.translateTo('no_events_msg', _language),
        style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
      );
    }

    return Column(
      children: allDays.map((day) {
        final isGood =
            day.toLowerCase() == 'yatyaza' ||
            day.toLowerCase() == 'amyeittasote' ||
            day.toLowerCase() == 'mahayatkyan';
        final isBad =
            day.toLowerCase().contains('pyathada') ||
            day.toLowerCase() == 'thamanyo' ||
            day.toLowerCase() == 'yatyotema';

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isGood
                ? Colors.green.withValues(alpha: 0.05)
                : isBad
                ? Colors.red.withValues(alpha: 0.05)
                : Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isGood
                  ? Colors.green.withValues(alpha: 0.2)
                  : isBad
                  ? Colors.red.withValues(alpha: 0.2)
                  : Colors.blue.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isGood
                    ? Icons.check_circle_outline
                    : isBad
                    ? Icons.error_outline
                    : Icons.info_outline,
                size: 16,
                color: isGood
                    ? Colors.green
                    : isBad
                    ? Colors.red
                    : Colors.blue,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TranslationService.translateTo(day, _language),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isGood
                            ? Colors.green.shade700
                            : isBad
                            ? Colors.red.shade700
                            : Colors.blue.shade700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AstroDetails.getAstrologicalDayDescription(
                        day,
                        language: _language,
                      ),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDetailTile(String label, String value, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$label: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
