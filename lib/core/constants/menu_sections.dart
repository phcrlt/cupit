import 'package:flutter/material.dart';

import '../../data/models/transaction_model.dart';

class SectionServiceItem {
  const SectionServiceItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.actionLabel,
  });

  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final String actionLabel;
}

class MenuSectionItem {
  const MenuSectionItem({
    required this.id,
    required this.title,
    required this.route,
    required this.icon,
    required this.subtitle,
    required this.highlightTitle,
    required this.highlightValue,
    required this.highlightCaption,
    required this.secondaryTitle,
    required this.secondaryValue,
    required this.secondaryCaption,
    required this.accentColor,
    required this.transactionTypes,
    required this.services,
  });

  final String id;
  final String title;
  final String route;
  final IconData icon;
  final String subtitle;
  final String highlightTitle;
  final String highlightValue;
  final String highlightCaption;
  final String secondaryTitle;
  final String secondaryValue;
  final String secondaryCaption;
  final Color accentColor;
  final List<TransactionType> transactionTypes;
  final List<SectionServiceItem> services;
}

const menuSectionItems = [
  MenuSectionItem(
    id: 'home-comfort',
    title: 'Мой дом и комфорт',
    route: '/sections/home-comfort',
    icon: Icons.home_rounded,
    subtitle: 'Все для бытовых платежей, домашних сервисов и спокойствия дома.',
    highlightTitle: 'Ближайший платеж',
    highlightValue: '6 420 ₽',
    highlightCaption: 'ЖКУ до 25 марта без комиссии',
    secondaryTitle: 'Активные сервисы',
    secondaryValue: '4',
    secondaryCaption: 'Домофон, страхование, клининг, подписки',
    accentColor: Color(0xFF4B7BFF),
    transactionTypes: [TransactionType.other],
    services: [
      SectionServiceItem(
        title: 'Коммунальные услуги',
        subtitle: 'Свет, вода, отопление и квитанции дома',
        description:
            'Собранные счета за квартиру, напоминания об оплате и быстрый переход к истории начислений.',
        icon: Icons.receipt_long_rounded,
        actionLabel: 'Посмотреть квитанции',
      ),
      SectionServiceItem(
        title: 'Домашние сервисы',
        subtitle: 'Уборка, мастер, интернет и домофон',
        description:
            'Подборка сервисов для дома с готовыми шаблонами платежей и удобным календарем визитов.',
        icon: Icons.miscellaneous_services_rounded,
        actionLabel: 'Открыть сервисы',
      ),
      SectionServiceItem(
        title: 'Страхование жилья',
        subtitle: 'Защита квартиры и имущества',
        description:
            'Демонстрационный блок с расчетом страховки, датой продления и списком покрываемых рисков.',
        icon: Icons.shield_outlined,
        actionLabel: 'Смотреть полис',
      ),
    ],
  ),
  MenuSectionItem(
    id: 'transport-communication',
    title: 'Транспорт и связь',
    route: '/sections/transport-communication',
    icon: Icons.commute_rounded,
    subtitle: 'Заправки, поездки, связь и ежемесячные подписки в одном разделе.',
    highlightTitle: 'Траты за неделю',
    highlightValue: '3 040 ₽',
    highlightCaption: 'Такси, бензин и мобильная связь',
    secondaryTitle: 'Подключенные шаблоны',
    secondaryValue: '5',
    secondaryCaption: 'Автоплатеж связи и транспортная карта',
    accentColor: Color(0xFF3ED3A1),
    transactionTypes: [TransactionType.transport],
    services: [
      SectionServiceItem(
        title: 'Мобильная связь',
        subtitle: 'Автоплатеж и напоминания по номеру',
        description:
            'Управление пополнением связи, лимитами и push-напоминаниями о списаниях.',
        icon: Icons.phone_iphone_rounded,
        actionLabel: 'Управлять номером',
      ),
      SectionServiceItem(
        title: 'Транспортная карта',
        subtitle: 'Пополнение проездного и история поездок',
        description:
            'Показывает последние пополнения, остаток поездок и рекомендованный платеж на неделю.',
        icon: Icons.directions_bus_rounded,
        actionLabel: 'Пополнить карту',
      ),
      SectionServiceItem(
        title: 'Авто и топливо',
        subtitle: 'АЗС, парковки и расходы на машину',
        description:
            'Демонстрационная аналитика по поездкам, парковкам и заправкам с кратким финансовым итогом.',
        icon: Icons.local_gas_station_rounded,
        actionLabel: 'Посмотреть расходы',
      ),
    ],
  ),
  MenuSectionItem(
    id: 'travel-leisure',
    title: 'Путешествия и досуг',
    route: '/sections/travel-leisure',
    icon: Icons.flight_takeoff_rounded,
    subtitle: 'Билеты, отели, события и страховка для отдыха и поездок.',
    highlightTitle: 'Бюджет поездки',
    highlightValue: '48 000 ₽',
    highlightCaption: 'На апрельскую поездку в Санкт-Петербург',
    secondaryTitle: 'Бонусы на отдых',
    secondaryValue: '12 400',
    secondaryCaption: 'Миль и кешбэка доступны к списанию',
    accentColor: Color(0xFFFFB84D),
    transactionTypes: [TransactionType.entertainment],
    services: [
      SectionServiceItem(
        title: 'Билеты и отели',
        subtitle: 'Собранные предложения и история бронирований',
        description:
            'Подборка демонстрационных предложений с ценами, бонусами и напоминаниями о ближайших поездках.',
        icon: Icons.luggage_rounded,
        actionLabel: 'Выбрать поездку',
      ),
      SectionServiceItem(
        title: 'Страховка путешествий',
        subtitle: 'Полис перед выездом за пару минут',
        description:
            'Короткая карточка с покрытием, датами поездки и статусом оформления страхового полиса.',
        icon: Icons.health_and_safety_outlined,
        actionLabel: 'Проверить полис',
      ),
      SectionServiceItem(
        title: 'Афиша и развлечения',
        subtitle: 'Концерты, кино и семейный досуг',
        description:
            'Имитированный каталог билетов с рекомендованным бюджетом на неделю и избранными событиями.',
        icon: Icons.celebration_rounded,
        actionLabel: 'Открыть афишу',
      ),
    ],
  ),
  MenuSectionItem(
    id: 'savings-future',
    title: 'Сбережения и будущее',
    route: '/sections/savings-future',
    icon: Icons.savings_rounded,
    subtitle: 'Накопления, цели, инвестиционные подборки и финансовый резерв.',
    highlightTitle: 'Финансовая цель',
    highlightValue: '72%',
    highlightCaption: 'Ноутбук для работы будет накоплен к маю',
    secondaryTitle: 'Доход за месяц',
    secondaryValue: '+8 540 ₽',
    secondaryCaption:
        'Проценты и инвестиционный рост по демонстрационному портфелю',
    accentColor: Color(0xFF7D8CFF),
    transactionTypes: [TransactionType.income, TransactionType.other],
    services: [
      SectionServiceItem(
        title: 'Накопительные цели',
        subtitle: 'Разбивка целей по срокам и суммам',
        description:
            'Готовые цели с автопополнением, расчетом срока накопления и прогнозом баланса.',
        icon: Icons.track_changes_rounded,
        actionLabel: 'Посмотреть цели',
      ),
      SectionServiceItem(
        title: 'Инвестиционные идеи',
        subtitle: 'Спокойный портфель для долгого горизонта',
        description:
            'Синтетическая подборка инструментов с ожидаемой доходностью и пояснением уровня риска.',
        icon: Icons.show_chart_rounded,
        actionLabel: 'Открыть подборку',
      ),
      SectionServiceItem(
        title: 'Финансовая подушка',
        subtitle: 'Резерв на 6 месяцев расходов',
        description:
            'Визуальная оценка запаса средств и совет по комфортному ежемесячному взносу.',
        icon: Icons.safety_check_rounded,
        actionLabel: 'Рассчитать резерв',
      ),
    ],
  ),
  MenuSectionItem(
    id: 'loans-finance',
    title: 'Кредиты и финансы',
    route: '/sections/loans-finance',
    icon: Icons.account_balance_wallet_rounded,
    subtitle: 'Кредитные продукты, лимиты, финздоровье и ежемесячная нагрузка.',
    highlightTitle: 'Платеж по кредиту',
    highlightValue: '18 900 ₽',
    highlightCaption: 'Следующее списание 28 марта',
    secondaryTitle: 'Финансовый рейтинг',
    secondaryValue: 'Очень хороший',
    secondaryCaption: 'Рекомендация: удерживать нагрузку ниже 35%',
    accentColor: Color(0xFFE66A8D),
    transactionTypes: [TransactionType.other, TransactionType.income],
    services: [
      SectionServiceItem(
        title: 'Кредитный график',
        subtitle: 'Следующие платежи и остаток долга',
        description:
            'Демонстрационный календарь с суммой ближайших списаний, процентной частью и телом долга.',
        icon: Icons.calendar_month_rounded,
        actionLabel: 'Открыть график',
      ),
      SectionServiceItem(
        title: 'Лимиты и рассрочка',
        subtitle: 'Покупки в рассрочку и доступный лимит',
        description:
            'Краткая сводка по доступному лимиту, условиям и рекомендуемой комфортной сумме.',
        icon: Icons.credit_score_rounded,
        actionLabel: 'Проверить лимит',
      ),
      SectionServiceItem(
        title: 'Финансовое здоровье',
        subtitle: 'Сравнение доходов и кредитной нагрузки',
        description:
            'Показывает, как меняется долговая нагрузка и что можно улучшить в привычках трат.',
        icon: Icons.monitor_heart_outlined,
        actionLabel: 'Смотреть советы',
      ),
    ],
  ),
  MenuSectionItem(
    id: 'details-payments',
    title: 'Платежи по реквизитам',
    route: '/sections/details-payments',
    icon: Icons.receipt_long_rounded,
    subtitle: 'Переводы по счету, налоги, штрафы и деловые платежи без шаблонов.',
    highlightTitle: 'Готовые шаблоны',
    highlightValue: '9',
    highlightCaption: 'Налоги, аренда, подрядчики и разовые переводы',
    secondaryTitle: 'Средний чек',
    secondaryValue: '14 800 ₽',
    secondaryCaption: 'По платежам за последние 30 дней',
    accentColor: Color(0xFF00A7C4),
    transactionTypes: [TransactionType.other],
    services: [
      SectionServiceItem(
        title: 'Перевод по реквизитам',
        subtitle: 'Для счетов юрлиц и физических лиц',
        description:
            'Пошаговый сценарий с проверкой реквизитов, шаблонами и историей отправок.',
        icon: Icons.account_balance_rounded,
        actionLabel: 'Создать платеж',
      ),
      SectionServiceItem(
        title: 'Налоги и штрафы',
        subtitle: 'Поиск начислений и сохраненные документы',
        description:
            'Раздел с синтетическими начислениями, QR-квитанциями и напоминаниями по срокам.',
        icon: Icons.gavel_rounded,
        actionLabel: 'Посмотреть начисления',
      ),
      SectionServiceItem(
        title: 'Деловые шаблоны',
        subtitle: 'Регулярные переводы контрагентам',
        description:
            'Готовые формы для аренды, поставщиков и разовых выплат с напоминанием о датах.',
        icon: Icons.business_center_rounded,
        actionLabel: 'Открыть шаблоны',
      ),
    ],
  ),
  MenuSectionItem(
    id: 'services-help',
    title: 'Сервисы и помощь',
    route: '/sections/services-help',
    icon: Icons.support_agent_rounded,
    subtitle: 'Поддержка, офисы, безопасность и полезные сервисы рядом.',
    highlightTitle: 'Статус поддержки',
    highlightValue: 'Онлайн',
    highlightCaption: 'Среднее время ответа в чате меньше 2 минут',
    secondaryTitle: 'Уровень защиты',
    secondaryValue: 'Высокий',
    secondaryCaption: 'Включены push-коды и уведомления о входе',
    accentColor: Color(0xFF3F7D5F),
    transactionTypes: [TransactionType.other],
    services: [
      SectionServiceItem(
        title: 'Чат с банком',
        subtitle: 'Быстрые ответы и сохраненные обращения',
        description:
            'Демонстрационный чат с подборкой популярных тем и последними ответами службы поддержки.',
        icon: Icons.chat_bubble_outline_rounded,
        actionLabel: 'Открыть чат',
      ),
      SectionServiceItem(
        title: 'Безопасность',
        subtitle: 'Устройства, входы и лимиты по операциям',
        description:
            'Показывает список доверенных устройств, лимиты операций и советы по защите аккаунта.',
        icon: Icons.lock_outline_rounded,
        actionLabel: 'Проверить защиту',
      ),
      SectionServiceItem(
        title: 'Офисы и банкоматы',
        subtitle: 'График работы и ближайшие точки',
        description:
            'Синтетический справочник точек обслуживания с фильтрами по услугам и времени работы.',
        icon: Icons.place_outlined,
        actionLabel: 'Найти рядом',
      ),
    ],
  ),
];

MenuSectionItem? menuSectionById(String sectionId) {
  for (final item in menuSectionItems) {
    if (item.id == sectionId) {
      return item;
    }
  }

  return null;
}
