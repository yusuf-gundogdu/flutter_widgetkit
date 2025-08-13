import 'package:flutter/material.dart';
import '../widgets/theme_selector.dart';
import '../widgets/font_selector.dart';
import '../widgets/style_selector.dart';
import '../models/template_config.dart';
import '../l10n/app_localizations.dart';
import '../tswidget/ts_theme.dart';
import '../tswidget/ts_app_bar.dart';
import '../widgets/template_preview.dart';

class TemplateStudioScreen extends StatefulWidget {
  final Function(TemplateConfig) onConfigUpdate;
  final TemplateConfig currentConfig;
  final bool currentDarkMode;
  final VoidCallback onDarkModeToggle;

  const TemplateStudioScreen({
    super.key,
    required this.onConfigUpdate,
    required this.currentConfig,
    required this.currentDarkMode,
    required this.onDarkModeToggle,
  });

  @override
  State<TemplateStudioScreen> createState() => _TemplateStudioScreenState();
}

class _TemplateStudioScreenState extends State<TemplateStudioScreen> {
  late TemplateConfig config;
  bool isSidebarExpanded = true;

  @override
  void initState() {
    super.initState();
    config = widget.currentConfig;
  }

  void _updateConfig(TemplateConfig newConfig) {
    setState(() {
      config = newConfig;
    });
    widget.onConfigUpdate(newConfig);
  }

  void _toggleTheme() {
    widget.onDarkModeToggle();
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
                  padding: const EdgeInsets.all(32),
                  child: _buildControls(),
                ),
              ),
            )
          : null,
      appBar: TSAppBar(
        config: config,
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
            const Icon(
              Icons.design_services,
              color: Colors.white,
            ),
            const SizedBox(width: 24),
            Text(
              AppLocalizations.of(context).t('app_title'),
              style: tsTextStyleForConfig(config, size: 20, weight: FontWeight.bold, color: Colors.white),
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
          const SizedBox(width: 32),
        ],
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
                          padding: const EdgeInsets.all(32),
                          child: _buildControls(),
                        ),
                        if (isMedium)
                          Positioned(
                            top: 16,
                            right: 16,
                            child: IconButton(
                              tooltip: isSidebarExpanded ? AppLocalizations.of(context).t('collapse') : AppLocalizations.of(context).t('expand'),
                              icon: Icon(isSidebarExpanded ? Icons.chevron_left : Icons.chevron_right),
                              onPressed: () => setState(() => isSidebarExpanded = !isSidebarExpanded),
                            ),
                          ),
                      ],
                    ),
            ),
          
          // Sağ Panel - Canlı Demo Önizleme
          Expanded(
            child: _PreviewArea(config: config),
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
}


class _PreviewArea extends StatelessWidget {
  final TemplateConfig config;
  const _PreviewArea({required this.config});

  @override
  Widget build(BuildContext context) {
    // Sağ panelin arka planı, ayırıcı çizgi ve paddingleri
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Başlık şeridi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.15),
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.visibility_outlined),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context).t('preview_area'),
                  style: tsTextStyleForConfig(config, weight: FontWeight.w700, color: Theme.of(context).colorScheme.onSurface),
                ),
              ],
            ),
          ),
          // İçerik
          Expanded(
            child: TSTheme(
              config: config,
              child: const TemplatePreview(),
            ),
          ),
        ],
      ),
    );
  }
}

