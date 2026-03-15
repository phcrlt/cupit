import 'package:flutter/material.dart';

enum BankingActionType {
  topUp,
  pay,
  transfer,
}

class ActionTemplateOption {
  const ActionTemplateOption({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;
}

class BankingActionDefinition {
  const BankingActionDefinition({
    required this.id,
    required this.route,
    required this.title,
    required this.subtitle,
    required this.submitLabel,
    required this.successTitle,
    required this.successSubtitle,
    required this.amountHint,
    required this.targetLabel,
    required this.noteLabel,
    required this.icon,
    required this.type,
    required this.amountPresets,
    required this.options,
  });

  final String id;
  final String route;
  final String title;
  final String subtitle;
  final String submitLabel;
  final String successTitle;
  final String successSubtitle;
  final String amountHint;
  final String targetLabel;
  final String noteLabel;
  final IconData icon;
  final BankingActionType type;
  final List<int> amountPresets;
  final List<ActionTemplateOption> options;
}

const bankingActionDefinitions = [
  BankingActionDefinition(
    id: 'top-up',
    route: '/actions/top-up',
    title: 'Пополнить',
    subtitle:
        'Пополнение карты или счета без комиссии внутри демонстрационного приложения.',
    submitLabel: 'Пополнить сейчас',
    successTitle: 'Средства уже в пути',
    successSubtitle: 'Баланс обновлен, операция добавлена в историю.',
    amountHint: 'Введите сумму пополнения',
    targetLabel: 'Источник пополнения',
    noteLabel: 'Комментарий к пополнению',
    icon: Icons.add_circle_outline_rounded,
    type: BankingActionType.topUp,
    amountPresets: [1000, 3000, 5000, 10000],
    options: [
      ActionTemplateOption(
        title: 'СБП из другого банка',
        subtitle: 'Мгновенное пополнение по номеру телефона',
      ),
      ActionTemplateOption(
        title: 'Перевод между своими счетами',
        subtitle: 'Перенос денег с накопительного счета',
      ),
      ActionTemplateOption(
        title: 'Пополнение с карты партнера',
        subtitle: 'Имитированное пополнение из внешней сети',
      ),
    ],
  ),
  BankingActionDefinition(
    id: 'pay',
    route: '/actions/pay',
    title: 'Оплатить',
    subtitle: 'Готовые шаблоны платежей для повседневных трат.',
    submitLabel: 'Оплатить',
    successTitle: 'Платеж принят',
    successSubtitle: 'Квитанция сохранена, уведомление отправлено.',
    amountHint: 'Введите сумму платежа',
    targetLabel: 'Куда платим',
    noteLabel: 'Назначение платежа',
    icon: Icons.qr_code_2_rounded,
    type: BankingActionType.pay,
    amountPresets: [350, 890, 1500, 4200],
    options: [
      ActionTemplateOption(
        title: 'ЖКУ и дом',
        subtitle: 'Коммунальные платежи, домофон, обслуживание',
      ),
      ActionTemplateOption(
        title: 'Мобильная связь',
        subtitle: 'Связь, интернет, подписки оператора',
      ),
      ActionTemplateOption(
        title: 'Городской транспорт',
        subtitle: 'Пополнение проездного и сервисы поездок',
      ),
    ],
  ),
  BankingActionDefinition(
    id: 'transfer',
    route: '/actions/transfer',
    title: 'Перевести',
    subtitle: 'Перевод по шаблону с моментальным отражением в истории.',
    submitLabel: 'Отправить перевод',
    successTitle: 'Перевод выполнен',
    successSubtitle: 'Получатель увидит деньги в течение пары минут.',
    amountHint: 'Введите сумму перевода',
    targetLabel: 'Получатель',
    noteLabel: 'Сообщение получателю',
    icon: Icons.swap_horiz_rounded,
    type: BankingActionType.transfer,
    amountPresets: [500, 1000, 2500, 7000],
    options: [
      ActionTemplateOption(
        title: 'Анна Петрова',
        subtitle: 'По номеру телефона, часто используемый контакт',
      ),
      ActionTemplateOption(
        title: 'Илья Смирнов',
        subtitle: 'Семейный перевод между близкими',
      ),
      ActionTemplateOption(
        title: 'Счет в другом банке',
        subtitle: 'Демонстрационный перевод по номеру счета',
      ),
    ],
  ),
];

BankingActionDefinition? bankingActionById(String actionId) {
  for (final definition in bankingActionDefinitions) {
    if (definition.id == actionId) {
      return definition;
    }
  }

  return null;
}
