import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/banking_actions.dart';
import '../../core/utils/formatters.dart';
import '../providers/dashboard_provider.dart';
import '../providers/notification_provider.dart';
import '../widgets/animated_reveal.dart';
import '../widgets/metric_tile.dart';
import '../widgets/particle_background.dart';
import '../widgets/section_container.dart';
import 'dashboard/widgets/account_card.dart';

class ActionFlowScreen extends StatefulWidget {
  const ActionFlowScreen({
    super.key,
    required this.actionId,
  });

  final String actionId;

  @override
  State<ActionFlowScreen> createState() => _ActionFlowScreenState();
}

class _ActionFlowScreenState extends State<ActionFlowScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _selectedCardId;
  int _selectedOptionIndex = 0;
  _ActionReceipt? _lastReceipt;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cards = context.read<DashboardProvider>().cards;
    if (_selectedCardId == null && cards.isNotEmpty) {
      _selectedCardId = cards.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final definition = bankingActionById(widget.actionId);
    if (definition == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Операция')),
        body: const Center(
          child: Text('Такой операции не существует.'),
        ),
      );
    }

    final dashboardProvider = context.watch<DashboardProvider>();
    final cards = dashboardProvider.cards;
    final currentCardId =
        _selectedCardId ?? (cards.isEmpty ? null : cards.first.id);
    final selectedCard = currentCardId == null
        ? null
        : dashboardProvider.cardById(currentCardId);

    return Scaffold(
      appBar: AppBar(title: Text(definition.title)),
      body: ParticleBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedCard != null)
                  AnimatedReveal(
                    child: Hero(
                      tag: 'card-${selectedCard.id}',
                      child: SizedBox(
                        height: 210,
                        child: AccountCard(card: selectedCard),
                      ),
                    ),
                  ),
                if (selectedCard != null) const SizedBox(height: 20),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 60),
                  child: SectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.18),
                                    Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.14),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                definition.icon,
                                color: Theme.of(context).colorScheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    definition.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(definition.subtitle),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (selectedCard != null) ...[
                          const SizedBox(height: 18),
                          MetricTile(
                            title: 'Доступно на выбранной карте',
                            value: AppFormatters.formatBalance(
                              selectedCard.balance,
                            ),
                            caption: selectedCard.maskedNumber,
                            icon: Icons.account_balance_wallet_outlined,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedReveal(
                  delay: const Duration(milliseconds: 120),
                  child: SectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Параметры операции',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                        const SizedBox(height: 18),
                        DropdownButtonFormField<String>(
                          value: currentCardId,
                          items: cards
                              .map(
                                (card) => DropdownMenuItem(
                                  value: card.id,
                                  child: Text(
                                    '${card.title} · ${card.maskedNumber}',
                                  ),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            labelText: 'Счет списания / зачисления',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedCardId = value;
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        Text(
                          definition.targetLabel,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(
                            definition.options.length,
                            (index) {
                              final option = definition.options[index];
                              final isSelected = index == _selectedOptionIndex;

                              return ChoiceChip(
                                label: SizedBox(
                                  width: 190,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        option.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        option.subtitle,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                selected: isSelected,
                                onSelected: (_) {
                                  setState(() {
                                    _selectedOptionIndex = index;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            labelText: definition.amountHint,
                            hintText: 'Например, 2500',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: definition.amountPresets
                              .map(
                                (preset) => ActionChip(
                                  label: Text('${preset.toString()} ₽'),
                                  onPressed: () {
                                    _amountController.text = preset.toString();
                                  },
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: _noteController,
                          decoration: InputDecoration(
                            labelText: definition.noteLabel,
                            hintText: 'Необязательно',
                          ),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: cards.isEmpty
                                ? null
                                : () => _submit(context, definition),
                            icon: Icon(definition.icon),
                            label: Text(definition.submitLabel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_lastReceipt != null) ...[
                  const SizedBox(height: 20),
                  AnimatedReveal(
                    delay: const Duration(milliseconds: 180),
                    child: SectionContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            definition.successTitle,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(definition.successSubtitle),
                          const SizedBox(height: 18),
                          MetricTile(
                            title: 'Сумма операции',
                            value: AppFormatters.formatBalance(
                              _lastReceipt!.amount,
                            ),
                            caption:
                                'Карта ${_lastReceipt!.cardMaskedNumber} · ${AppFormatters.formatDate(_lastReceipt!.date)}',
                            icon: Icons.check_circle_outline_rounded,
                          ),
                          const SizedBox(height: 12),
                          MetricTile(
                            title: 'Получатель / источник',
                            value: _lastReceipt!.targetTitle,
                            caption: _lastReceipt!.note.isEmpty
                                ? 'Комментарий не указан'
                                : _lastReceipt!.note,
                            icon: Icons.info_outline_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(
    BuildContext context,
    BankingActionDefinition definition,
  ) async {
    final dashboardProvider = context.read<DashboardProvider>();
    final notificationProvider = context.read<NotificationProvider>();
    final cardId = _selectedCardId ??
        (dashboardProvider.cards.isEmpty
            ? null
            : dashboardProvider.cards.first.id);
    final amount = _parseAmount(_amountController.text);

    if (cardId == null) {
      _showSnackBar(context, 'Выберите карту для операции.');
      return;
    }

    if (amount == null || amount <= 0) {
      _showSnackBar(context, 'Введите корректную сумму.');
      return;
    }

    if (definition.type != BankingActionType.topUp &&
        !dashboardProvider.hasEnoughBalance(cardId, amount)) {
      _showSnackBar(
        context,
        'Недостаточно средств на выбранной карте.',
      );
      return;
    }

    final option = definition.options[_selectedOptionIndex];
    switch (definition.type) {
      case BankingActionType.topUp:
        await dashboardProvider.topUp(
          cardId: cardId,
          amount: amount,
          source: option.title,
          note: _noteController.text,
        );
        break;
      case BankingActionType.pay:
        await dashboardProvider.pay(
          cardId: cardId,
          amount: amount,
          target: option.title,
          note: _noteController.text,
        );
        break;
      case BankingActionType.transfer:
        await dashboardProvider.transfer(
          cardId: cardId,
          amount: amount,
          recipient: option.title,
          note: _noteController.text,
        );
        break;
    }

    notificationProvider.pushNotification(
      title: definition.successTitle,
      subtitle:
          '${option.title} · ${AppFormatters.formatBalance(amount)} успешно обработано',
    );

    final updatedCard = dashboardProvider.cardById(cardId);
    if (updatedCard != null) {
      setState(() {
        _lastReceipt = _ActionReceipt(
          amount: amount,
          targetTitle: option.title,
          note: _noteController.text.trim(),
          cardMaskedNumber: updatedCard.maskedNumber,
          date: DateTime.now(),
        );
      });
    }

    _showSnackBar(context, 'Операция успешно выполнена.');
  }

  double? _parseAmount(String rawAmount) {
    final normalized = rawAmount.replaceAll(',', '.').trim();
    return double.tryParse(normalized);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }
}

class _ActionReceipt {
  const _ActionReceipt({
    required this.amount,
    required this.targetTitle,
    required this.note,
    required this.cardMaskedNumber,
    required this.date,
  });

  final double amount;
  final String targetTitle;
  final String note;
  final String cardMaskedNumber;
  final DateTime date;
}
