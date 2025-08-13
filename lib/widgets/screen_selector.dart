import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/template_config.dart';

class ScreenSelector extends StatelessWidget {
  final TemplateConfig config;
  final Function(TemplateConfig) onConfigChanged;

  const ScreenSelector({
    super.key,
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.screen_share, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Screen Type',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Pick a screen type and see the preview',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Ekran Türü Seçenekleri
            _buildScreenTypeOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenTypeOptions(BuildContext context) {
    final screenTypes = [
      {
        'type': ScreenType.list,
        'name': 'Liste Ekranı',
        'description': 'Data list view',
        'icon': Icons.list_alt,
      },
      {
        'type': ScreenType.form,
        'name': 'Form Ekranı',
        'description': 'Data entry form',
        'icon': Icons.edit_note,
      },
      {
        'type': ScreenType.detail,
        'name': 'Detay Ekranı',
        'description': 'Detail view',
        'icon': Icons.info_outline,
      },
      {
        'type': ScreenType.dashboard,
        'name': 'Dashboard',
        'description': 'Cards and summaries',
        'icon': Icons.dashboard_customize,
      },
      {
        'type': ScreenType.table,
        'name': 'Tablo Ekranı',
        'description': 'Tabular data view',
        'icon': Icons.grid_on,
      },
    ];

    return Column(
      children: screenTypes.map((screenType) {
        final isSelected = config.screenType == screenType['type'];
        final Color color = config.primaryColor;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: () => onConfigChanged(config.copyWith(
              screenType: screenType['type'] as ScreenType,
            )),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected 
                    ? color.withValues(alpha: 0.1)
                    : Theme.of(context).colorScheme.surface,
                 borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected 
                      ? color
                      : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                   Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                       color: isSelected ? color : color.withValues(alpha: 0.1),
                      borderRadius: config.useRoundedCorners ? BorderRadius.circular(config.borderRadius.topLeft.x) : BorderRadius.circular(8),
                    ),
                    child: Icon(
                      screenType['icon'] as IconData,
                       color: isSelected ? Theme.of(context).colorScheme.onPrimary : color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          screenType['name'] as String,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected 
                                ? color
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 6),
                        _MiniPreview(type: screenType['type'] as ScreenType),
                        const SizedBox(height: 6),
                        Text(
                          screenType['description'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                             color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                           ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: color,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

} 

class _MiniPreview extends StatelessWidget {
  final ScreenType type;

  const _MiniPreview({required this.type});

  @override
  Widget build(BuildContext context) {
    final Color base = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12);
    final BorderRadius border = BorderRadius.circular(6);
    switch (type) {
      case ScreenType.list:
        return Row(
          children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: base, borderRadius: border)),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 8, decoration: BoxDecoration(color: base, borderRadius: border)),
                  const SizedBox(height: 6),
                  Container(height: 8, width: 120, decoration: BoxDecoration(color: base, borderRadius: border)),
                ],
              ),
            ),
          ],
        );
      case ScreenType.form:
        return Row(
          children: [
            Expanded(child: Container(height: 12, decoration: BoxDecoration(color: base, borderRadius: border))),
            const SizedBox(width: 8),
            Expanded(child: Container(height: 12, decoration: BoxDecoration(color: base, borderRadius: border))),
            const SizedBox(width: 8),
            Container(width: 60, height: 12, decoration: BoxDecoration(color: base, borderRadius: border)),
          ],
        );
      case ScreenType.detail:
        return Row(
          children: [
            Expanded(child: Container(height: 36, decoration: BoxDecoration(color: base, borderRadius: border))),
            const SizedBox(width: 8),
            Container(width: 60, height: 36, decoration: BoxDecoration(color: base, borderRadius: border)),
          ],
        );
      case ScreenType.dashboard:
        return Row(
          children: [
            Expanded(child: Container(height: 24, decoration: BoxDecoration(color: base, borderRadius: border))),
            const SizedBox(width: 8),
            Expanded(child: Container(height: 24, decoration: BoxDecoration(color: base, borderRadius: border))),
            const SizedBox(width: 8),
            Expanded(child: Container(height: 24, decoration: BoxDecoration(color: base, borderRadius: border))),
          ],
        );
      case ScreenType.table:
        return Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(child: Container(height: 12, decoration: BoxDecoration(color: base, borderRadius: border))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 12, decoration: BoxDecoration(color: base, borderRadius: border))),
                  const SizedBox(width: 6),
                  Expanded(child: Container(height: 12, decoration: BoxDecoration(color: base, borderRadius: border))),
                ],
              ),
            ),
          ],
        );
    }
  }
}