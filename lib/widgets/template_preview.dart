import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tswidget/ts_theme.dart';
import '../models/template_config.dart';
import '../l10n/app_localizations.dart';

class TemplatePreview extends StatelessWidget {
  final TemplateConfig config;
  final bool showAll;
  final bool embedded;

  const TemplatePreview({
    super.key,
    required this.config,
    this.showAll = false,
    this.embedded = false,
  });

  @override
  Widget build(BuildContext context) {
    if (showAll) {
      final List<_PreviewItemSpec> items = [
        _PreviewItemSpec(ScreenType.dashboard, 320),
        _PreviewItemSpec(ScreenType.list, 520),
        _PreviewItemSpec(ScreenType.form, 540),
        _PreviewItemSpec(ScreenType.detail, 460),
        _PreviewItemSpec(ScreenType.table, 560),
      ];

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: IgnorePointer(
                  ignoring: true,
                  child: TemplatePreview(
                    config: config.copyWith(screenType: items[i].type),
                    embedded: true,
                  ),
                ),
              ),
              if (i != items.length - 1) const SizedBox(height: 30),
            ],
          ],
        ),
      );
    }

    switch (config.screenType) {
      case ScreenType.dashboard:
        return _buildDashboardScreen(context);
      case ScreenType.list:
        return _buildListScreen(context);
      case ScreenType.form:
        return _buildFormScreen(context);
      case ScreenType.detail:
        return _buildDetailScreen(context);
      case ScreenType.table:
        return _buildTableScreen(context);
    }
  }

  

  // Common background decoration based on style variant (without border)
  BoxDecoration _cardDecoration(BuildContext context) {
    // ignore: unused_local_variable
    final ColorScheme scheme = Theme.of(context).colorScheme;
    Color bg = config.backgroundColor;
    List<BoxShadow>? shadows = config.useShadows
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: config.elevation,
              offset: Offset(0, config.elevation / 2),
            ),
          ]
        : null;

    switch (config.styleVariant) {
      case StyleVariant.modern:
        bg = config.backgroundColor;
        break;
      case StyleVariant.classic:
        bg = config.backgroundColor;
        break;
      case StyleVariant.minimal:
        bg = Colors.transparent;
        shadows = null;
        break;
      case StyleVariant.colorful:
        bg = config.primaryColor.withValues(alpha: 0.05);
        break;
      case StyleVariant.neumorphic:
        bg = Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1F2937)
            : const Color(0xFFEFF3F6);
        shadows = config.useShadows
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(8, 8),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 16,
                  offset: Offset(-8, -8),
                ),
              ]
            : null;
        break;
      case StyleVariant.glass:
        bg = Colors.white.withValues(alpha: 0.12);
        shadows = config.useShadows
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null;
        break;
    }

    return BoxDecoration(
      color: Color.alphaBlend(
        config.surfaceTintColor.withValues(alpha: config.surfaceTintStrength),
        bg,
      ),
      borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
      boxShadow: shadows,
    );
  }

  // Foreground-only border so it stays visible above children like headers
  Decoration? _cardBorderDecoration(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    Color borderColor = scheme.outline.withValues(alpha: 0.2);
    double borderWidth = 1.0;

    switch (config.styleVariant) {
      case StyleVariant.modern:
        borderColor = config.primaryColor.withValues(alpha: 0.2);
        borderWidth = 2.0;
        break;
      case StyleVariant.classic:
        borderColor = scheme.outline.withValues(alpha: 0.3);
        borderWidth = 1.0;
        break;
      case StyleVariant.minimal:
        borderWidth = 0.0;
        break;
      case StyleVariant.colorful:
        borderColor = config.primaryColor.withValues(alpha: 0.3);
        borderWidth = 1.5;
        break;
      case StyleVariant.neumorphic:
        borderWidth = 0.0;
        break;
      case StyleVariant.glass:
        borderColor = Colors.white.withValues(alpha: 0.25);
        borderWidth = 1.0;
        break;
    }

    if (borderWidth <= 0) return null;

    return BoxDecoration(
      borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
      border: Border.all(color: borderColor, width: borderWidth),
    );
  }

  // DASHBOARD
  Widget _buildDashboardScreen(BuildContext context) {
    return Container(
      decoration: _cardDecoration(context),
      foregroundDecoration: _cardBorderDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionHeader(context, AppLocalizations.of(context).t('dashboard'), Icons.dashboard_customize),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context).t('discover_designs'),
                  style: _getGoogleFont(config.fontFamily).copyWith(
                    fontSize: config.fontSize,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildChip(context, AppLocalizations.of(context).t('project'), Icons.folder),
                    _buildChip(context, AppLocalizations.of(context).t('progress'), Icons.trending_up),
                    _buildChip(context, AppLocalizations.of(context).t('time'), Icons.access_time),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // LIST
  Widget _buildListScreen(BuildContext context) {
    final int itemCount = embedded ? 3 : 8;
    final items = List.generate(itemCount, (i) => 'Item ${i + 1}');
    return Container(
      decoration: _cardDecoration(context),
      foregroundDecoration: _cardBorderDecoration(context),
      child: Column(
        children: [
          _buildSectionHeader(context, AppLocalizations.of(context).t('list'), Icons.list_alt),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                return Container(
                  decoration: _cardDecoration(context),
                  foregroundDecoration: _cardBorderDecoration(context),
                  child: ListTile(
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -2),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    leading: _buildLeadingAvatar(),
                    title: Text(
                      items[index],
                      style: _getGoogleFont(config.fontFamily).copyWith(
                        fontSize: config.fontSize,
                        fontWeight: config.fontWeight,
                        letterSpacing: config.letterSpacing,
                        height: config.lineHeight,
                      ),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context).t('description_text'),
                      style: _getGoogleFont(config.fontFamily).copyWith(
                        fontSize: config.fontSize * 0.9,
                        letterSpacing: config.letterSpacing,
                        height: config.lineHeight,
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 18),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingAvatar() {
    final double radius = config.useRoundedCorners ? config.borderRadius.topLeft.x : 0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: 40,
        height: 40,
        color: config.primaryColor,
        child: Icon(Icons.work, color: Colors.white, size: config.iconSize),
      ),
    );
  }

  // FORM
  Widget _buildFormScreen(BuildContext context) {
    return Container(
      decoration: _cardDecoration(context),
      foregroundDecoration: _cardBorderDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık şeridi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: config.useGradient
                  ? LinearGradient(
                      colors: [config.primaryColor, config.secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: config.useGradient ? null : config.primaryColor,
              borderRadius: config.useRoundedCorners
                  ? BorderRadius.only(
                      topLeft: Radius.circular(config.borderRadius.topLeft.x),
                      topRight: Radius.circular(config.borderRadius.topRight.x),
                    )
                  : BorderRadius.zero,
            ),
            child: Row(
              children: [
                Icon(Icons.description, color: Colors.white, size: config.iconSize),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).t('project_form'),
                  style: _getGoogleFont(config.fontFamily).copyWith(
                    color: Colors.white,
                    fontSize: config.fontSize * 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabeledField(context, AppLocalizations.of(context).t('project'), 'Template Studio'),
                const SizedBox(height: 12),
                _buildLabeledField(context, AppLocalizations.of(context).t('description_text'), '...'),
                const SizedBox(height: 12),
                _buildLabeledField(context, AppLocalizations.of(context).t('category'), 'UI/UX'),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: config.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context).t('save'),
                      style: TextStyle(
                        fontSize: config.fontSize,
                        fontWeight: FontWeight.w600,
                        letterSpacing: config.letterSpacing,
                        height: config.lineHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DETAIL
  Widget _buildDetailScreen(BuildContext context) {
    return Container(
      decoration: _cardDecoration(context),
      foregroundDecoration: _cardBorderDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionHeader(context, AppLocalizations.of(context).t('detail'), Icons.info_outline),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: config.useGradient
                        ? LinearGradient(
                            colors: [config.primaryColor, config.secondaryColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: config.useGradient ? null : config.primaryColor,
                    borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.design_services, color: Colors.white, size: 56),
                ),
                const SizedBox(height: 16),
                _buildSubTitle(context, AppLocalizations.of(context).t('project')),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context).t('modern_flexible_system'),
                  style: tsTextStyleForConfig(
                    config,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TABLE
  Widget _buildTableScreen(BuildContext context) {
    final t = AppLocalizations.of(context);
    final columns = [
      t.t('id'),
      t.t('name'),
      t.t('status'),
      t.t('score'),
      t.t('date'),
      t.t('category'),
      t.t('tags'),
      t.t('owner'),
      t.t('priority'),
      t.t('action'),
    ];
    final int rowCount = embedded ? 3 : 8;
    final rows = List.generate(rowCount, (i) => {
          'id': '#${1000 + i}',
          'name': 'Item ${i + 1}',
          'status': i % 2 == 0 ? t.t('active') : t.t('passive'),
          'score': (80 + i).toString(),
          'date': '2025-09-${(10 + i).toString().padLeft(2, '0')}',
          'category': ['UI', 'Backend', 'DevOps', 'QA'][i % 4],
          'tags': ['web', 'mobile', 'api', 'ci'][i % 4],
          'owner': ['Alice', 'Bob', 'Elena', 'Chris'][i % 4],
          'priority': ['Low', 'Medium', 'High'][i % 3],
           'action': t.t('edit'),
        });

    final TextStyle headerStyle = _getGoogleFont(config.fontFamily).copyWith(
      fontSize: config.fontSize * 0.95,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );
    final TextStyle cellStyle = _getGoogleFont(config.fontFamily).copyWith(
      fontSize: config.fontSize,
      fontWeight: config.fontWeight,
      color: Theme.of(context).colorScheme.onSurface,
    );

    return Container(
      decoration: _cardDecoration(context),
      foregroundDecoration: _cardBorderDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, AppLocalizations.of(context).t('table'), Icons.grid_on),
          Padding(
            padding: const EdgeInsets.all(16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isTight = constraints.maxWidth < 380;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                            headingRowColor: WidgetStateProperty.all(
                              config.useGradient ? Colors.transparent : config.primaryColor,
                            ),
                            headingRowHeight: 44,
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 56,
                            horizontalMargin: isTight ? 6 : 12,
                            columnSpacing: isTight ? 8 : 16,
                            columns: [
                              for (final c in columns)
                                DataColumn(
                                  label: Container(
                                    padding: EdgeInsets.symmetric(horizontal: isTight ? 4 : 8, vertical: 6),
                                    decoration: config.useGradient
                                        ? BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [config.primaryColor, config.secondaryColor],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(6),
                                          )
                                        : null,
                                    child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        c,
                                        style: headerStyle,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                            rows: [
                              for (final r in rows)
                                DataRow(cells: [
                                  DataCell(Text(r['id']!, style: cellStyle, overflow: TextOverflow.ellipsis, softWrap: false)),
                                  DataCell(Text(r['name']!, style: cellStyle, overflow: TextOverflow.ellipsis, softWrap: false)),
                                  DataCell(Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                       color: (r['status'] == t.t('active')
                                                ? config.accentColor
                                                : Theme.of(context).colorScheme.outline)
                                           .withValues(alpha: 0.15),
                                      borderRadius: config.useRoundedCorners
                                          ? BorderRadius.circular(config.borderRadius.topLeft.x)
                                          : BorderRadius.zero,
                                      border: Border.all(
                                         color: r['status'] == t.t('active')
                                             ? config.accentColor
                                             : Theme.of(context).colorScheme.outline,
                                      ),
                                    ),
                                     child: Row(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         Icon(Icons.circle, size: config.iconSize * 0.6, color: r['status'] == t.t('active') ? config.accentColor : Theme.of(context).colorScheme.outline),
                                         const SizedBox(width: 6),
                                         Text(
                                      r['status']!,
                                      style: cellStyle.copyWith(fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                         ),
                                       ],
                                     ),
                                  )),
                                  DataCell(Text(r['score']!, style: cellStyle, overflow: TextOverflow.ellipsis, softWrap: false)),
                                  DataCell(Text(r['date']!, style: cellStyle, overflow: TextOverflow.ellipsis, softWrap: false)),
                                  DataCell(Text(r['category']!, style: cellStyle, overflow: TextOverflow.ellipsis, softWrap: false)),
                                  DataCell(Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                       color: config.primaryColor.withValues(alpha: 0.08),
                                      borderRadius: config.useRoundedCorners
                                          ? BorderRadius.circular(config.borderRadius.topLeft.x)
                                          : BorderRadius.zero,
                                       border: Border.all(color: config.primaryColor.withValues(alpha: 0.3)),
                                    ),
                                    child: Text(
                                      r['tags']!,
                                      style: cellStyle.copyWith(fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                  )),
                                  DataCell(Text(r['owner']!, style: cellStyle, overflow: TextOverflow.ellipsis, softWrap: false)),
                                  DataCell(_buildPriorityBadge(context, r['priority']!, cellStyle)),
                                  DataCell(Text(
                                    r['action']!,
                                    style: cellStyle.copyWith(color: config.primaryColor, fontWeight: FontWeight.w700),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  )),
                                ]),
                            ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(BuildContext context, String priority, TextStyle cellStyle) {
    Color color;
    switch (priority) {
      case 'High':
        color = Colors.redAccent;
        break;
      case 'Medium':
        color = Colors.orangeAccent;
        break;
      default:
        color = Colors.green;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: config.useRoundedCorners
            ? BorderRadius.circular(config.borderRadius.topLeft.x)
            : BorderRadius.zero,
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        priority,
        style: cellStyle.copyWith(
          fontWeight: FontWeight.w700,
          color: color.withValues(alpha: 0.9),
          letterSpacing: config.letterSpacing,
          height: config.lineHeight,
        ),
      ),
    );
  }

  // Helpers
  Widget _buildChip(BuildContext context, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: _cardDecoration(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: config.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: _getGoogleFont(config.fontFamily).copyWith(
              fontSize: config.fontSize * 0.95,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Shared section header used across previews
  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: config.useGradient
            ? LinearGradient(
                colors: [config.primaryColor, config.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: config.useGradient ? null : config.primaryColor,
        borderRadius: config.useRoundedCorners
            ? BorderRadius.only(
                topLeft: Radius.circular(config.borderRadius.topLeft.x),
                topRight: Radius.circular(config.borderRadius.topRight.x),
              )
            : BorderRadius.zero,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            title,
            style: _getGoogleFont(config.fontFamily).copyWith(
              color: Colors.white,
              fontSize: config.fontSize * 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubTitle(BuildContext context, String text) {
    return Text(
      text,
      style: _getGoogleFont(config.fontFamily).copyWith(
        fontSize: config.fontSize * 1.2,
        fontWeight: FontWeight.w700,
        color: config.primaryColor,
      ),
    );
  }

  Widget _buildLabeledField(BuildContext context, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: _getGoogleFont(config.fontFamily).copyWith(
            fontSize: config.fontSize,
            fontWeight: FontWeight.w600,
            color: config.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          style: _getGoogleFont(config.fontFamily).copyWith(
            fontSize: config.fontSize,
            fontWeight: config.fontWeight,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: _getGoogleFont(config.fontFamily).copyWith(
              fontSize: config.fontSize * 0.95,
               color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            border: OutlineInputBorder(
              borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: config.useRoundedCorners ? config.borderRadius : BorderRadius.zero,
              borderSide: BorderSide(color: config.primaryColor, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _getGoogleFont(String fontFamily) {
    switch (fontFamily) {
      case 'Gruppo':
        return GoogleFonts.gruppo();
      case 'Inter':
        return GoogleFonts.inter();
      case 'Roboto':
        return GoogleFonts.roboto();
      case 'Open Sans':
        return GoogleFonts.openSans();
      case 'Lato':
        return GoogleFonts.lato();
      case 'Poppins':
        return GoogleFonts.poppins();
      case 'Montserrat':
        return GoogleFonts.montserrat();
      case 'Source Sans 3':
        return GoogleFonts.sourceSans3();
      case 'Ubuntu':
        return GoogleFonts.ubuntu();
      case 'Nunito':
        return GoogleFonts.nunito();
      case 'Work Sans':
        return GoogleFonts.workSans();
      case 'Raleway':
        return GoogleFonts.raleway();
      case 'PT Sans':
        return GoogleFonts.ptSans();
      case 'Noto Sans':
        return GoogleFonts.notoSans();
      case 'Merriweather':
        return GoogleFonts.merriweather();
      case 'Playfair Display':
        return GoogleFonts.playfairDisplay();
      case 'Bebas Neue':
        return GoogleFonts.bebasNeue();
      case 'Oswald':
        return GoogleFonts.oswald();
      case 'Dancing Script':
        return GoogleFonts.dancingScript();
      case 'Pacifico':
        return GoogleFonts.pacifico();
      case 'Fredoka One':
        return GoogleFonts.fredoka();
      default:
        return GoogleFonts.gruppo();
    }
  }
}

class _PreviewItemSpec {
  final ScreenType type;
  final double height;
  const _PreviewItemSpec(this.type, this.height);
}