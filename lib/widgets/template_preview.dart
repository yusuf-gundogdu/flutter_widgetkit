import 'package:flutter/material.dart';
import '../tswidget/ts_theme.dart';
import '../tswidget/ts_card.dart';
import '../tswidget/ts_button.dart';
import '../tswidget/ts_tabs.dart';
import '../tswidget/ts_list_tile.dart';
import '../tswidget/ts_list.dart';
import '../tswidget/ts_table.dart';
import '../tswidget/ts_grid.dart';
import '../tswidget/ts_badge.dart';
import '../tswidget/ts_chip.dart';
import '../tswidget/ts_text_field.dart';
import '../tswidget/ts_checkbox.dart';
import '../tswidget/ts_switch.dart';
import '../tswidget/ts_radio.dart';
import '../tswidget/ts_slider.dart';
import '../tswidget/ts_progress.dart';
import '../tswidget/ts_image.dart';
import '../tswidget/ts_snackbar.dart';
import '../tswidget/ts_alert_dialog.dart';
import '../tswidget/ts_bottom_sheet.dart';
import '../tswidget/ts_tooltip.dart';
import '../tswidget/ts_navigation_bar.dart';
import '../tswidget/ts_dropdown.dart';

class TemplatePreview extends StatefulWidget {
  const TemplatePreview({super.key});

  @override
  State<TemplatePreview> createState() => _TemplatePreviewState();
}

class _TemplatePreviewState extends State<TemplatePreview> {
  // Form state
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  String dropdownValue = 'Seçiniz';
  bool checked = true;
  bool switched = false;
  String? radioValue = 'A';
  double sliderValue = 50;
  int navIndex = 0;

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure TSTheme is available
    final config = TSTheme.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxHeight < 320;
        Widget body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Tabbed area
          (isCompact
              ? SizedBox(
                  height: 420,
                  child: TSTabs(
                    tabs: const [
                      Tab(icon: Icon(Icons.dashboard_outlined), text: 'Genel'),
                      Tab(icon: Icon(Icons.checklist_rtl), text: 'Formlar'),
                      Tab(icon: Icon(Icons.table_chart_outlined), text: 'Tablo'),
                      Tab(icon: Icon(Icons.grid_view), text: 'Izgara'),
                      Tab(icon: Icon(Icons.widgets_outlined), text: 'Bileşenler'),
                    ],
                    views: [
                      _buildOverview(context),
                      _buildForms(context),
                      _buildTable(context),
                      _buildGrid(context),
                      _buildComponents(context),
                    ],
                  ),
                )
              : Expanded(
            child: TSTabs(
              tabs: const [
                Tab(icon: Icon(Icons.dashboard_outlined), text: 'Genel'),
                Tab(icon: Icon(Icons.checklist_rtl), text: 'Formlar'),
                Tab(icon: Icon(Icons.table_chart_outlined), text: 'Tablo'),
                Tab(icon: Icon(Icons.grid_view), text: 'Izgara'),
                Tab(icon: Icon(Icons.widgets_outlined), text: 'Bileşenler'),
              ],
              views: [
                _buildOverview(context),
                _buildForms(context),
                _buildTable(context),
                _buildGrid(context),
                _buildComponents(context),
              ],
            ),
          )),
          const SizedBox(height: 16),
          // Inline navigation preview
          TSCard(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: TSNavigationBar(
              selectedIndex: navIndex,
              onDestinationSelected: (i) => setState(() => navIndex = i),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Ana'),
                NavigationDestination(icon: Icon(Icons.search_outlined), selectedIcon: Icon(Icons.search), label: 'Arama'),
                NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Ayarlar'),
              ],
            ),
          ),
        ],
      );

        if (isCompact) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(child: body),
          );
        }
        return Padding(padding: const EdgeInsets.all(16), child: body);
      },
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    final config = TSTheme.of(context);
    return Text(
      title,
      style: tsTextStyleForConfig(
        config,
        size: config.fontSize * 1.1,
        weight: FontWeight.w700,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final config = TSTheme.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return TSCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Canlı Önizleme',
            style: tsTextStyleForConfig(
              config,
              size: config.fontSize * 1.4,
              weight: FontWeight.w700,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Sağ panelde tema, tipografi ve stil değişikliklerinin bileşenlere etkisini anında görün.',
            style: tsTextStyleForConfig(
              config,
              size: config.fontSize * 0.95,
              color: onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TSButton(
                onPressed: () => showTSSnackBar(context, 'Bir bilgi mesajı…'),
                child: const Row(children: [Icon(Icons.info_outline), SizedBox(width: 8), Text('Snackbar')]),
              ),
              TSButton(
                filled: false,
                onPressed: () {
                  final inheritedConfig = config; // capture TSTheme config
                  showDialog(
                    context: context,
                    builder: (_) => TSTheme(
                      config: inheritedConfig,
                      child: const TSAlertDialog(
                        title: 'Onay',
                        content: 'Bu bir uyarı diyalog örneğidir.',
                      ),
                    ),
                  );
                },
                child: const Row(children: [Icon(Icons.warning_amber), SizedBox(width: 8), Text('Diyalog')]),
              ),
              TSButton(
                onPressed: () => showTSBottomSheet(
                  context: context,
                  builder: (ctx) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alt Sayfa', style: tsTextStyleForConfig(config, weight: FontWeight.w700, color: onSurface)),
                      const SizedBox(height: 8),
                      Text(
                        'Bu, modal alt sayfa bileşeni örneğidir.',
                        style: tsTextStyleForConfig(config, color: onSurface.withValues(alpha: 0.85)),
                      ),
                    ],
                  ),
                ),
                child: const Row(children: [Icon(Icons.unfold_more), SizedBox(width: 8), Text('Bottom Sheet')]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverview(BuildContext context) {
    final config = TSTheme.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderCard(context),
          const SizedBox(height: 12),
          _sectionTitle(context, 'Durum Kartları'),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TSBadge(
                  label: '12',
                  badgeDiameter: 28,
                  offsetRight: -12,
                  offsetTop: -12,
                  child: TSCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        const Icon(Icons.mail_outline),
                        const SizedBox(width: 8),
                        Text('Mesajlar', style: tsTextStyleForConfig(config, weight: FontWeight.w600, color: onSurface)),
                      ]),
                      const SizedBox(height: 8),
                      TSLinearProgress(value: 0.6),
                      const SizedBox(height: 6),
                      Text('%60 tamamlandı', style: tsTextStyleForConfig(config, size: config.fontSize * 0.9, color: onSurface.withValues(alpha: 0.75))),
                    ]),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TSCard(
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      TSCircularProgress(value: 0.72),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Kullanıcı Doygunluğu', style: tsTextStyleForConfig(config, weight: FontWeight.w600, color: onSurface)),
                          const SizedBox(height: 4),
                          Text('%72', style: tsTextStyleForConfig(config, size: config.fontSize * 1.2, weight: FontWeight.w700, color: onSurface)),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _sectionTitle(context, 'Öne Çıkan'),
          const SizedBox(height: 8),
          TSCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Yeni Sürüm', style: tsTextStyleForConfig(config, size: config.fontSize * 1.15, weight: FontWeight.w700, color: onSurface)),
                    const SizedBox(height: 6),
                    Text('Tema ve stil değişiklikleri artık canlı önizlemede!', style: tsTextStyleForConfig(config, color: onSurface.withValues(alpha: 0.8))),
                    const SizedBox(height: 12),
                    Wrap(spacing: 8, runSpacing: 8, children: const [
                      TSChip(label: Text('Performans')),
                      TSChip(label: Text('UI/UX')),
                      TSChip(label: Text('Material3')),
                    ]),
                  ]),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 160,
                  height: 120,
                  child: TSImage(image: const AssetImage('assets/logo.png'), fit: BoxFit.contain),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForms(BuildContext context) {
    final config = TSTheme.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle(context, 'Girişler'),
          const SizedBox(height: 8),
          TSCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              TSTextField(hint: 'Ad Soyad', controller: nameCtrl),
              const SizedBox(height: 12),
              TSTextField(hint: 'E-posta', controller: emailCtrl),
              const SizedBox(height: 12),
              TSDropdown<String>(
                value: dropdownValue,
                items: const [
                  DropdownMenuItem(value: 'Seçiniz', child: Text('Seçiniz')),
                  DropdownMenuItem(value: 'İstanbul', child: Text('İstanbul')),
                  DropdownMenuItem(value: 'Ankara', child: Text('Ankara')),
                  DropdownMenuItem(value: 'İzmir', child: Text('İzmir')),
                ],
                onChanged: (v) => setState(() => dropdownValue = v ?? dropdownValue),
              ),
            ]),
          ),
          const SizedBox(height: 12),
          _sectionTitle(context, 'Seçimler'),
          const SizedBox(height: 8),
          TSCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                TSCheckbox(value: checked, onChanged: (v) => setState(() => checked = v ?? checked)),
                const SizedBox(width: 8),
                Text('Kabul ediyorum', style: tsTextStyleForConfig(config, color: onSurface)),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                TSSwitch(value: switched, onChanged: (v) => setState(() => switched = v)),
                const SizedBox(width: 8),
                Text('Bildirimler', style: tsTextStyleForConfig(config, color: onSurface)),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                TSRadio<String>(value: 'A', groupValue: radioValue, onChanged: (v) => setState(() => radioValue = v)),
                Text('Seçenek A', style: tsTextStyleForConfig(config, color: onSurface)),
                const SizedBox(width: 16),
                TSRadio<String>(value: 'B', groupValue: radioValue, onChanged: (v) => setState(() => radioValue = v)),
                Text('Seçenek B', style: tsTextStyleForConfig(config, color: onSurface)),
              ]),
            ]),
          ),
          const SizedBox(height: 12),
          _sectionTitle(context, 'Slider'),
          const SizedBox(height: 8),
          TSCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              TSSlider(value: sliderValue, min: 0, max: 100, onChanged: (v) => setState(() => sliderValue = v)),
              const SizedBox(height: 8),
              Text('Değer: ${'${sliderValue.toStringAsFixed(0)}'}', style: tsTextStyleForConfig(config, color: onSurface)),
            ]),
          ),
          const SizedBox(height: 12),
          Row(children: [
            TSButton(onPressed: () => showTSSnackBar(context, 'Form kaydedildi'), child: const Text('Kaydet')),
            const SizedBox(width: 12),
            TSButton(filled: false, onPressed: () => Navigator.of(context).maybePop(), child: const Text('İptal')),
          ]),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    final config = TSTheme.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final columns = ['Ad', 'Durum', 'Rol', 'Skor'];
    final rows = [
      ['Elif', 'Aktif', 'Yönetici', '92'],
      ['Ahmet', 'Pasif', 'Editör', '74'],
      ['Zeynep', 'Aktif', 'Kullanıcı', '88'],
      ['Mert', 'Aktif', 'Editör', '81'],
    ]
        .map((r) => [
              Text(r[0], style: tsTextStyleForConfig(config, color: onSurface)),
              Text(r[1], style: tsTextStyleForConfig(config, color: onSurface)),
              Text(r[2], style: tsTextStyleForConfig(config, color: onSurface)),
              Text(r[3], style: tsTextStyleForConfig(config, weight: FontWeight.w700, color: onSurface)),
            ])
        .toList();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle(context, 'Kullanıcı Tablosu'),
          const SizedBox(height: 8),
          Expanded(
            child: TSCard(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TSTable(columns: columns, rows: rows),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final config = TSTheme.of(context);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle(context, 'Ürün Izgarası'),
          const SizedBox(height: 8),
          Expanded(
            child: TSGrid(
              children: List.generate(8, (i) {
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(children: [
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TSImage(
                                    image: const AssetImage('assets/logo.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          const SizedBox(height: 8),
                          Text('Ürün ${i + 1}', style: tsTextStyleForConfig(config, weight: FontWeight.w600, color: Theme.of(context).colorScheme.onSurface)),
                          const SizedBox(height: 4),
                          Row(children: [
                            const TSTooltip(message: 'Sepete ekle', child: Icon(Icons.add_shopping_cart_outlined)),
                            const Spacer(),
                            const TSTooltip(message: 'Favorilere ekle', child: Icon(Icons.favorite_outline)),
                          ]),
                        ],
                      ),
                      
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponents(BuildContext context) {
    final config = TSTheme.of(context);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final items = List.generate(
      12,
      (i) => TSListTile(
        leading: const Icon(Icons.apps),
        title: Text('Bileşen ${i + 1}'),
        subtitle: const Text('Açıklama metni'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => showTSSnackBar(context, 'Bileşen ${i + 1}'),
        decorated: false,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _sectionTitle(context, 'Liste ve Rozetler'),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TSList(children: items),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TSCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Etiketler', style: tsTextStyleForConfig(config, weight: FontWeight.w700, color: onSurface)),
                      const SizedBox(height: 8),
                      Wrap(spacing: 8, runSpacing: 8, children: const [
                        TSChip(label: Text('Yeni')),
                        TSChip(label: Text('Popüler')),
                        TSChip(label: Text('Önerilen')),
                        TSChip(label: Text('Trend')),
                        TSChip(label: Text('Güncel')),
                      ]),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


