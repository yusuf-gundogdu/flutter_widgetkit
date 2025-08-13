import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/theme_selector.dart';
import '../widgets/font_selector.dart';
import '../widgets/style_selector.dart';
// import '../widgets/template_preview.dart';
import '../models/template_config.dart';
import '../l10n/app_localizations.dart';
import '../tswidget/ts_theme.dart';
import '../tswidget/ts_card.dart';
import '../tswidget/ts_list.dart';
import '../tswidget/ts_list_tile.dart';
import '../tswidget/ts_table.dart';
import '../tswidget/ts_button.dart';
import '../tswidget/ts_text_field.dart';
import '../tswidget/ts_dropdown.dart';
import '../tswidget/ts_grid.dart';
import '../tswidget/ts_chip.dart';
// import '../tswidget/ts_badge.dart';
// import '../tswidget/ts_image.dart';
import '../tswidget/ts_form.dart';
import '../tswidget/ts_app_bar.dart';
// import '../tswidget/ts_tabs.dart';
// import '../tswidget/ts_snackbar.dart';
// import '../tswidget/ts_fab.dart';
// import '../tswidget/ts_progress.dart';
// import '../tswidget/ts_tooltip.dart';
// import '../tswidget/ts_navigation_bar.dart';
// import '../tswidget/ts_alert_dialog.dart';
// import '../tswidget/ts_bottom_sheet.dart';
import '../tswidget/ts_checkbox.dart';
// import '../tswidget/ts_radio.dart';
import '../tswidget/ts_switch.dart';
// import '../tswidget/ts_slider.dart';
// import '../tswidget/ts_expansion_tile.dart';

class TemplateStudioScreen extends StatefulWidget {
  final Function({
    required Color primary,
    required Color secondary,
    required Color accent,
    bool? darkMode,
  }) onThemeUpdate;
  final Color currentPrimaryColor;
  final Color currentSecondaryColor;
  final Color currentAccentColor;
  final bool currentDarkMode;

  const TemplateStudioScreen({
    super.key,
    required this.onThemeUpdate,
    required this.currentPrimaryColor,
    required this.currentSecondaryColor,
    required this.currentAccentColor,
    required this.currentDarkMode,
  });

  @override
  State<TemplateStudioScreen> createState() => _TemplateStudioScreenState();
}

class _TemplateStudioScreenState extends State<TemplateStudioScreen> {
  late TemplateConfig config;
  bool isSidebarExpanded = true;
  final Set<String> _selected = <String>{};
  bool _switchVal = true;
  bool _checkVal = false;
  String _radioVal = 'A';
  double _sliderVal = 0.4;
  int _navIndex = 0;
  bool _spacious = true;

  @override
  void initState() {
    super.initState();
    config = TemplateConfig(
      primaryColor: widget.currentPrimaryColor,
      secondaryColor: widget.currentSecondaryColor,
      accentColor: widget.currentAccentColor,
      backgroundColor: const Color(0xFFF7FAFC),
      fontFamily: 'Inter',
    );
    _selected.addAll({'List & Detail', 'Form Page', 'Data Table Page', 'E‑commerce Grid', 'Settings Page'});
  }

  void _updateConfig(TemplateConfig newConfig) {
    setState(() {
      config = newConfig;
    });
    
    // Ana tema güncellemesi
    widget.onThemeUpdate(
      primary: newConfig.primaryColor,
      secondary: newConfig.secondaryColor,
      accent: newConfig.accentColor,
    );
  }

  void _toggleTheme() {
    widget.onThemeUpdate(
      primary: config.primaryColor,
      secondary: config.secondaryColor,
      accent: config.accentColor,
      darkMode: !widget.currentDarkMode,
    );
  }

  void _resetTemplate() {
    final TemplateConfig newConfig = TemplateConfig();
    setState(() {
      _selected
        ..clear()
        ..addAll({'List & Detail', 'Form Page', 'Data Table Page', 'E‑commerce Grid', 'Settings Page'});
      _switchVal = true;
      _checkVal = false;
      _radioVal = 'A';
      _sliderVal = 0.4;
      _navIndex = 0;
      _spacious = true;
      isSidebarExpanded = true;
    });
    _updateConfig(newConfig);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmall = screenWidth < 800;
    final bool isMedium = screenWidth >= 800 && screenWidth < 1200;
    final bool isLarge = screenWidth >= 1200;
    final double sidebarTargetWidth = isLarge
        ? 400
        : isMedium
            ? (isSidebarExpanded ? 300 : 64)
            : 0;
    return Scaffold(
      drawer: isSmall
          ? Drawer(
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: _buildControls(),
                ),
              ),
            )
          : null,
      appBar: AppBar(
        leading: isSmall
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: Row(
          children: [
            Icon(
              Icons.design_services,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              AppLocalizations.of(context).t('app_title'),
              style: GoogleFonts.gruppo().copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _toggleTheme,
            icon: Icon(
              widget.currentDarkMode ? Icons.light_mode_rounded : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
        ],
        backgroundColor: widget.currentPrimaryColor,
        elevation: 0,
      ),
      body: Row(
        children: [
          if (!isSmall)
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              width: sidebarTargetWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
              ),
              child: isMedium && !isSidebarExpanded
                          ? Center(
                      child: IconButton(
                        tooltip: AppLocalizations.of(context).t('open_settings'),
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () => setState(() => isSidebarExpanded = true),
                      ),
                    )
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: _buildControls(),
                        ),
                        if (isMedium)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              tooltip: isSidebarExpanded ? AppLocalizations.of(context).t('collapse') : AppLocalizations.of(context).t('expand'),
                              icon: Icon(isSidebarExpanded ? Icons.chevron_left : Icons.chevron_right),
                              onPressed: () => setState(() => isSidebarExpanded = !isSidebarExpanded),
                            ),
                          ),
                      ],
                    ),
            ),
          
          // Sağ Panel - Çoklu TS Widget Seçimi + Önizleme
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: DefaultTextStyle.merge(
                  style: _getGoogleFontForStudio(config.fontFamily).copyWith(
                    fontSize: config.fontSize,
                    fontWeight: config.fontWeight,
                  ),
                  child: TSTheme(
                    config: config,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: LayoutBuilder(
                          builder: (context, cons) {
                            final bool isNarrow = cons.maxWidth < 600;
                            final title = Text(
                              AppLocalizations.of(context).t('preview_area'),
                              style: _getGoogleFontForStudio(config.fontFamily).copyWith(
                                fontSize: config.fontSize * 1.1,
                                fontWeight: FontWeight.bold,
                                letterSpacing: config.letterSpacing,
                                height: config.lineHeight,
                              ),
                            );
                            final densityToggle = Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconTheme(
                                data: IconThemeData(size: config.iconSize),
                                child: Row(children: [
                                  IconButton(
                                    tooltip: AppLocalizations.of(context).t('compact'),
                                    icon: Icon(Icons.grid_view, color: !_spacious ? widget.currentPrimaryColor : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                                    onPressed: () => setState(() => _spacious = false),
                                  ),
                                  IconButton(
                                    tooltip: AppLocalizations.of(context).t('spacious'),
                                    icon: Icon(Icons.space_dashboard, color: _spacious ? widget.currentPrimaryColor : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
                                    onPressed: () => setState(() => _spacious = true),
                                  ),
                                ]),
                              ),
                            );
                            final actionsColumn = ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 320),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => setState(() => _selected.clear()),
                                    icon: const Icon(Icons.clear_all),
                                    label: Text(AppLocalizations.of(context).t('clear_widget')),
                                  ),
                                  const SizedBox(height: 8),
                                  TextButton.icon(
                                    onPressed: _resetTemplate,
                                    icon: const Icon(Icons.restart_alt),
                                    label: Text(AppLocalizations.of(context).t('clear_template')),
                                  ),
                                ],
                              ),
                            );

                            if (isNarrow) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  title,
                                  const SizedBox(height: 8),
                                  densityToggle,
                                  const SizedBox(height: 8),
                                  actionsColumn,
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Flexible(child: title),
                                      const SizedBox(width: 16),
                                      densityToggle,
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () => setState(() => _selected.clear()),
                                      icon: const Icon(Icons.clear_all),
                                      label: Text(AppLocalizations.of(context).t('clear_widget')),
                                    ),
                                    TextButton.icon(
                                      onPressed: _resetTemplate,
                                      icon: const Icon(Icons.restart_alt),
                                      label: Text(AppLocalizations.of(context).t('clear_template')),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _options(context).keys.map((k) {
                            final bool picked = _selected.contains(k);
                            return FilterChip(
                              label: Text(_localizedOptionTitle(context, k)),
                              selected: picked,
                              onSelected: (v) => setState(() {
                                if (v) {
                                  _selected.add(k);
                                } else {
                                  _selected.remove(k);
                                }
                              }),
                              selectedColor: config.primaryColor.withValues(alpha: 0.15),
                              checkmarkColor: config.primaryColor,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, cons) {
                            final double base = _spacious ? 900 : 680;
                            final double maxW = cons.maxWidth;
                            final int col = maxW ~/ (base + 12).clamp(1, 999);
                            final double tileW = (col <= 1) ? maxW : base;
                            return SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Wrap(
                                spacing: 16,
                                runSpacing: 16,
                                children: [
                                  for (final key in _selected) _buildSample(context, key, tileW),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tema Seçici
        ThemeSelector(
          config: config,
          onConfigChanged: _updateConfig,
        ),
        const SizedBox(height: 24),
        // Font Seçici
        FontSelector(
          config: config,
          onConfigChanged: _updateConfig,
        ),
        const SizedBox(height: 24),
        // Stil Seçici
        StyleSelector(
          config: config,
          onConfigChanged: _updateConfig,
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  TextStyle _getGoogleFontForStudio(String fontFamily) {
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

  Map<String, Widget Function(BuildContext)> _options(BuildContext context) => {
        // Dashboard kaldırıldı
        'List & Detail': (ctx) => Column(children: [
              TSAppBar(title: Text(AppLocalizations.of(context).t('records'))),
              const SizedBox(height: 12),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: SizedBox(height: 320, child: TSList(children: [for (int i = 0; i < 6; i++) TSListTile(title: Text('${AppLocalizations.of(context).t('item')} ${i + 1}'), subtitle: Text(AppLocalizations.of(context).t('description_text')))]))),
                const SizedBox(width: 12),
                Expanded(child: TSCard(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    AppLocalizations.of(context).t('detail_title'),
                    style: _getGoogleFontForStudio(config.fontFamily).copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: config.fontSize,
                      letterSpacing: config.letterSpacing,
                      height: config.lineHeight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TSTextField(hint: AppLocalizations.of(context).t('add_note')),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TSButton(onPressed: () {}, child: Text(AppLocalizations.of(context).t('save'))),
                      TSButton(filled: false, onPressed: () {}, child: Text(AppLocalizations.of(context).t('delete'))),
                    ],
                  ),
                ]))))
              ]),
            ]),
        'Form Page': (ctx) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TSAppBar(title: Text(AppLocalizations.of(context).t('new_record'))),
              const SizedBox(height: 12),
              TSFormSection(title: AppLocalizations.of(context).t('general'), children: [
                TSTextField(hint: AppLocalizations.of(context).t('first_name')),
                TSTextField(hint: AppLocalizations.of(context).t('last_name')),
              ]),
              const SizedBox(height: 8),
              TSFormSection(title: AppLocalizations.of(context).t('contact'), children: [
                TSTextField(hint: AppLocalizations.of(context).t('email')),
                TSDropdown<String>(
                  value: 'a',
                  items: [
                    DropdownMenuItem(value: 'a', child: Text(AppLocalizations.of(context).t('turkey'))),
                    DropdownMenuItem(value: 'b', child: Text(AppLocalizations.of(context).t('germany'))),
                  ],
                  onChanged: (_) {},
                )
              ]),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  TSButton(onPressed: () {}, child: Text(AppLocalizations.of(context).t('submit'))),
                  TSButton(filled: false, onPressed: () {}, child: Text(AppLocalizations.of(context).t('cancel'))),
                ],
              ),
            ]),
        'Data Table Page': (ctx) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TSAppBar(title: Text(AppLocalizations.of(context).t('reports'))),
              const SizedBox(height: 12),
              TSTable(columns: ['ID', 'Ad', 'Durum', 'Aksiyon'], rows: [
                [
                  Text('#1', style: _getGoogleFontForStudio(config.fontFamily)),
                  Text('Alice', style: _getGoogleFontForStudio(config.fontFamily)),
                  const TSChip(label: Text('Active')),
                  TSButton(filled: false, onPressed: () {}, child: const Text('Edit'))
                ],
                [
                  Text('#2', style: _getGoogleFontForStudio(config.fontFamily)),
                  Text('Bob', style: _getGoogleFontForStudio(config.fontFamily)),
                  const TSChip(label: Text('Inactive')),
                  TSButton(filled: false, onPressed: () {}, child: const Text('Edit'))
                ],
                [
                  Text('#3', style: _getGoogleFontForStudio(config.fontFamily)),
                  Text('Elena', style: _getGoogleFontForStudio(config.fontFamily)),
                  const TSChip(label: Text('Active')),
                  TSButton(filled: false, onPressed: () {}, child: const Text('Edit'))
                ],
              ]),
            ]),
        'E‑commerce Grid': (ctx) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TSAppBar(title: Text(AppLocalizations.of(context).t('products'))),
              const SizedBox(height: 12),
              TSTextField(hint: AppLocalizations.of(context).t('search')),
              const SizedBox(height: 12),
              SizedBox(height: 320, child: TSGrid(children: [
                for (int i = 0; i < 8; i++)
                  Padding(padding: const EdgeInsets.all(8), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.asset('assets/logo.png', width: 96, height: 96),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${AppLocalizations.of(context).t('product')} ${i + 1}',
                      style: _getGoogleFontForStudio(config.fontFamily).copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: config.fontSize,
                        letterSpacing: config.letterSpacing,
                        height: config.lineHeight,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TSButton(filled: false, onPressed: () {}, child: Text(AppLocalizations.of(context).t('add_to_cart'))),
                  ])),
              ])),
            ]),
        'Settings Page': (ctx) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TSAppBar(title: Text(AppLocalizations.of(context).t('settings'))),
              const SizedBox(height: 12),
              TSCard(child: Padding(padding: const EdgeInsets.all(12), child: Column(children: [
                Row(children: [
                  TSSwitch(value: _switchVal, onChanged: (v) => setState(() => _switchVal = v)),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('enable_notifications'), style: _getGoogleFontForStudio(config.fontFamily))
                ]),
                const SizedBox(height: 8),
                Row(children: [
                  TSCheckbox(value: _checkVal, onChanged: (v) => setState(() => _checkVal = v ?? false)),
                  const SizedBox(width: 8),
                  Text(AppLocalizations.of(context).t('receive_emails'), style: _getGoogleFontForStudio(config.fontFamily))
                ]),
                const SizedBox(height: 8),
                Row(children: [Expanded(child: TSTextField(hint: AppLocalizations.of(context).t('username'))), const SizedBox(width: 8), Expanded(child: TSDropdown<String>(value: 'a', items: const [DropdownMenuItem(value: 'a', child: Text('TR')), DropdownMenuItem(value: 'b', child: Text('EN'))], onChanged: (_) {}))]),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TSButton(onPressed: () {}, child: Text(AppLocalizations.of(context).t('save'))),
                    TSButton(filled: false, onPressed: () {}, child: Text(AppLocalizations.of(context).t('cancel'))),
                  ],
                ),
              ]))),
            ]),
      };

  String _localizedOptionTitle(BuildContext context, String key) {
    final t = AppLocalizations.of(context);
    switch (key) {
      case 'List & Detail':
        return t.t('list_detail_label');
      case 'Form Page':
        return t.t('form_page_label');
      case 'Data Table Page':
        return t.t('data_table_page_label');
      case 'E‑commerce Grid':
        return t.t('ecommerce_grid_label');
      case 'Settings Page':
        return t.t('settings_page_label');
      default:
        return key;
    }
  }

  Widget _buildSample(BuildContext context, String key, double width) {
    final builder = _options(context)[key]!;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: widget.currentPrimaryColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(Icons.widgets, size: 18, color: widget.currentPrimaryColor),
                const SizedBox(width: 8),
            Text(
              _localizedOptionTitle(context, key),
              style: _getGoogleFontForStudio(config.fontFamily).copyWith(
                fontWeight: FontWeight.w700,
                fontSize: config.fontSize,
                letterSpacing: config.letterSpacing,
                height: config.lineHeight,
              ),
            ),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(12), child: builder(context)),
        ],
      ),
    );
  }
}

