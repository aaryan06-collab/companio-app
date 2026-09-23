import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../data/local/app_database.dart';
import '../../data/models/enums.dart';
import '../../domain/entities/activity_content.dart';
import '../../shared/widgets/app_button.dart';
import '../../shared/widgets/app_cards.dart';

/// Runs any catalog activity with a gentle, elderly-friendly engine.
/// Never a "test": every miss is answered with soft encouragement and the
/// app celebrates effort, not score.
class ActivityRunnerScreen extends ConsumerStatefulWidget {
  const ActivityRunnerScreen({
    super.key,
    required this.activity,
    this.difficulty,
  });

  final Activity activity;

  /// Optional level chosen by the patient (Easy/Medium/Hard). Falls back to
  /// the activity's seeded difficulty so session records stay honest.
  final Difficulty? difficulty;

  @override
  ConsumerState<ActivityRunnerScreen> createState() => _ActivityRunnerState();
}

enum _Phase { intro, playing, celebrating }

class _ActivityRunnerState extends ConsumerState<ActivityRunnerScreen> {
  late final ActivityContent content;
  late final List<String> shuffledVariants;
  late final List<String> shuffledSteps;
  late final List<String> shuffledRight;
  _Phase _phase = _Phase.intro;

  // generic counters
  int _correct = 0;
  int _hints = 0;
  int _wrongTries = 0;
  bool _answered = false;
  bool _answeredCorrect = false;
  String? _selected;

  // matching
  String? _selectedLeft;
  final Set<int> _matchedIndices = {};

  // sequence / kitchen
  int _expectedIndex = 0;
  final List<int> _tappedIndices = [];

  // shopping
  final Set<String> _basket = {};
  bool _checkoutAttempted = false;

  // find the pairs
  late final List<String> _pairsDeck;
  final Set<int> _pairsMatched = {};
  bool _pairsMemorising = true;
  int? _pairsFirst;
  int? _pairsSecond;
  bool _pairsLocked = false;

  // remember the sequence
  static const List<int> _seqRounds = [3, 4, 5];
  late final List<String> _seqPool;
  int _seqRound = 0;
  late List<int> _seqRoundCards;
  late List<int> _seqOrder;
  final Set<int> _seqTapped = {};
  int _seqRevealTick = 0;
  bool _seqRepeating = false;
  int _seqCumDone = 0;

  // what changed?
  static const List<int> _changeRounds = [3, 4];
  late final List<MatchPair> _changePool;
  int _changeRound = 0;
  late List<int> _changeRoundCards;
  int _changeSwap = -1;
  int _changeCompleted = 0;
  bool _changeSolved = false;
  bool _changeMemorising = true;
  bool _changeLocked = false;

  Timer? _gameTimer;

  ActivityType get _type => ActivityType.fromString(widget.activity.type);

  @override
  void initState() {
    super.initState();
    content = ref
        .read(depsProvider)
        .activityRepository
        .contentOf(widget.activity);
    shuffledVariants = List.of(content.variants)..shuffle(Random.secure());
    shuffledSteps = List.of(content.steps)..shuffle(Random.secure());
    shuffledRight = content.pairs.map((e) => e.right).toList()
      ..shuffle(Random.secure());
    _pairsDeck = [...content.variants, ...content.variants]
      ..shuffle(Random.secure());
    _seqPool = List.of(content.variants);
    _changePool = List.of(content.pairs);
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    if (text.isEmpty) return;
    try {
      await ref.read(depsProvider).voiceService.speak(text);
    } catch (_) {}
  }

  void _showHint() {
    setState(() {
      _hints += 1;
      _phase = _Phase.playing;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content.hint ?? ''),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _finish({required bool completed}) async {
    final total = switch (_type) {
      ActivityType.matching => content.pairs.length,
      ActivityType.sequence || ActivityType.kitchen => content.steps.length,
      ActivityType.shopping =>
        content.requiredProductIds.isEmpty
            ? content.products.length
            : content.requiredProductIds.length,
      ActivityType.pairs => content.variants.length,
      ActivityType.sequenceRecall => _seqRounds.fold(0, (sum, r) => sum + r),
      ActivityType.findChanged => _changeRounds.length,
      _ => content.variants.length,
    };
    try {
      await completeActivityFlow(
        ref,
        activityId: widget.activity.id,
        correctCount: _correct,
        totalCount: max(total, _correct),
        hintCount: _hints,
        difficulty: widget.difficulty ?? widget.activity.baseDifficulty,
        completed: completed,
        result: {'wrongTries': _wrongTries, 'hints': _hints},
      );
    } catch (_) {}
    if (mounted) setState(() => _phase = _Phase.celebrating);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.creamCard,
        title: Text(l10n.t(widget.activity.titleKey)),
        leading: _phase == _Phase.playing
            ? IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: switch (_phase) {
          _Phase.intro => _buildIntro(l10n),
          _Phase.playing => _buildPlay(l10n),
          _Phase.celebrating => _CelebrationView(
            onDone: () => Navigator.of(context).pop(),
          ),
        },
      ),
    );
  }

  Widget _buildIntro(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content.promptEmoji, style: const TextStyle(fontSize: 72)),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.t(widget.activity.titleKey),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.t(widget.activity.subtitleKey ?? ''),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: AppColors.inkSoft),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppPrimaryButton(
            label: l10n.t('activityNext'),
            icon: Icons.play_arrow_rounded,
            onPressed: () {
              setState(() => _phase = _Phase.playing);
              switch (_type) {
                case ActivityType.pairs:
                  _pairsStartMemorising();
                case ActivityType.sequenceRecall:
                  _seqStartRound(0);
                case ActivityType.findChanged:
                  _changeStartRound(0);
                default:
                  break;
              }
              _speak(_prompt(l10n));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlay(AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        _buildProgressHeader(),
        const SizedBox(height: AppSpacing.md),
        _PromptCard(
          text: _prompt(l10n),
          emoji: content.promptEmoji,
          onSpeak: () => _speak(_prompt(l10n)),
        ),
        if (content.hint != null && !_answered) ...[
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: _showHint,
            icon: const Icon(Icons.lightbulb_outline_rounded),
            label: Text(l10n.t('activityHint')),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        switch (_type) {
          ActivityType.matching => _buildMatching(l10n),
          ActivityType.sequence || ActivityType.kitchen => _buildSequence(l10n),
          ActivityType.shopping => _buildShopping(l10n),
          ActivityType.pairs => _buildPairs(l10n),
          ActivityType.sequenceRecall => _buildSequenceRecall(l10n),
          ActivityType.findChanged => _buildFindChanged(l10n),
          _ => _buildChoice(l10n),
        },
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  Widget _buildChoice(AppLocalizations l10n) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final variant in shuffledVariants)
          SizedBox(
            width: double.infinity,
            child: _ChoiceTile(
              label: variant,
              selected: _answered && variant == _selected,
              correct: _answered && variant == content.correctLabel,
              onTap: _answered ? null : () => _answerChoice(variant),
            ),
          ),
        if (_answered && _answeredCorrect) ...[
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.t('activityFinish'),
            onPressed: () => _finish(completed: true),
          ),
        ],
      ],
    );
  }

  void _answerChoice(String variant) {
    final correct = variant == content.correctLabel;
    setState(() {
      _answered = true;
      _answeredCorrect = correct;
      _selected = variant;
      if (correct) {
        _correct += 1;
      } else {
        _wrongTries += 1;
      }
    });
    _speak(correct ? l10nOf('activityPraise') : l10nOf('activityTryAgain'));
  }

  String l10nOf(String key) {
    final resolved = key.contains(':')
        ? key
        : AppLocalizations.of(context).t(key);
    return resolved;
  }

  Widget _buildMatching(AppLocalizations l10n) {
    if (_matchedIndices.length == content.pairs.length) {
      return Column(
        children: [
          Text('🎉', style: TextStyle(fontSize: 56)),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.t('activityFinish'),
            onPressed: () => _finish(completed: true),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.t('activityTapToMatch'),
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: AppColors.inkSoft),
        ),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < content.pairs.length; i++)
          SectionCard(
            onTap: _matchedIndices.contains(i) ? null : () => _tapLeft(i, l10n),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${content.pairs[i].left}${_matchedIndices.contains(i) ? ' ✓' : ''}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (i == _selectedLeftIndex)
                  Icon(
                    Icons.arrow_right_alt_rounded,
                    color: AppColors.terracotta,
                    size: 30,
                  ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.t('activityOptionsHint'),
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: AppColors.inkSoft),
        ),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (var i = 0; i < shuffledRight.length; i++)
              if (!_isRightMatched(shuffledRight[i]))
                _ChoiceTile(
                  label: shuffledRight[i],
                  selected: false,
                  correct: false,
                  onTap: () => _tapRight(shuffledRight[i], l10n),
                ),
          ],
        ),
      ],
    );
  }

  int? get _selectedLeftIndex {
    if (_selectedLeft == null) return null;
    for (var i = 0; i < content.pairs.length; i++) {
      if (content.pairs[i].left == _selectedLeft) return i;
    }
    return null;
  }

  bool _isRightMatched(String right) {
    for (final i in _matchedIndices) {
      if (content.pairs[i].right == right) return true;
    }
    return false;
  }

  void _tapLeft(int index, AppLocalizations l10n) {
    setState(() => _selectedLeft = content.pairs[index].left);
  }

  void _tapRight(String right, AppLocalizations l10n) {
    final leftIndex = _selectedLeftIndex;
    if (leftIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.t('activityOptionsHint')),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }
    if (content.pairs[leftIndex].right == right) {
      setState(() {
        _matchedIndices.add(leftIndex);
        _correct += 1;
        _selectedLeft = null;
      });
      _speak(l10n.t('activityGreatJob'));
    } else {
      setState(() {
        _wrongTries += 1;
        _selectedLeft = null;
      });
      _speak(l10n.t('activityTryAgain'));
    }
  }

  Widget _buildSequence(AppLocalizations l10n) {
    final allTapped = _tappedIndices.length == content.steps.length;
    if (allTapped) {
      return Column(
        children: [
          Text('🎉', style: TextStyle(fontSize: 56)),
          const SizedBox(height: AppSpacing.md),
          AppPrimaryButton(
            label: l10n.t('activityFinish'),
            onPressed: () => _finish(completed: true),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.t('kitchenTapInOrder'),
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: AppColors.inkSoft),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (var i = 0; i < shuffledSteps.length; i++)
              if (!_tappedIndices.contains(
                content.steps.indexOf(shuffledSteps[i]),
              ))
                _ChoiceTile(
                  label: shuffledSteps[i],
                  selected: false,
                  correct: false,
                  onTap: () => _tapStep(shuffledSteps[i], l10n),
                ),
          ],
        ),
      ],
    );
  }

  void _tapStep(String step, AppLocalizations l10n) {
    final originalIndex = content.steps.indexOf(step);
    if (originalIndex == _expectedIndex) {
      setState(() {
        _tappedIndices.add(originalIndex);
        _expectedIndex += 1;
        _correct += 1;
      });
      _speak(l10n.t('activityGreatJob'));
    } else {
      setState(() => _wrongTries += 1);
      _speak(l10n.t('activityTryAgain'));
    }
  }

  Widget _buildPairs(AppLocalizations l10n) {
    if (_pairsMatched.length == _pairsDeck.length) {
      return _doneColumn(l10n);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_pairsMemorising) ...[
          Text(
            l10n.t('pairsRemember'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge
                ?.copyWith(color: AppColors.inkSoft),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          alignment: WrapAlignment.center,
          children: [
            for (var i = 0; i < _pairsDeck.length; i++)
              _MemoryTile(
                text: _pairsDeck[i],
                shown:
                    _pairsMemorising ||
                    _pairsMatched.contains(i) ||
                    i == _pairsFirst ||
                    i == _pairsSecond,
                matched: _pairsMatched.contains(i),
                selected:
                    !_pairsMemorising &&
                    (i == _pairsFirst || i == _pairsSecond),
                onTap: _pairsMemorising ? null : () => _pairsTap(i, l10n),
              ),
          ],
        ),
        if (_pairsMemorising) ...[
          const SizedBox(height: AppSpacing.lg),
          AppPrimaryButton(
            label: l10n.t('pairsStart'),
            onPressed: _endMemorise,
          ),
        ],
      ],
    );
  }

  bool _seqCardLit(int cardIndex) =>
      !_seqRepeating && _seqOrder.indexOf(cardIndex) < _seqRevealTick;

  Widget _buildSequenceRecall(AppLocalizations l10n) {
    final allDone =
        _seqRound == _seqRounds.length - 1 &&
        _seqTapped.length == _seqOrder.length;
    if (allDone) {
      return _doneColumn(l10n);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _seqRepeating ? l10n.t('seqRecallRepeat') : l10n.t('seqRecallWatch'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: AppColors.inkSoft),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          alignment: WrapAlignment.center,
          children: [
            for (var i = 0; i < _seqRoundCards.length; i++)
              _MemoryTile(
                text: _seqPool[_seqRoundCards[i]],
                shown: true,
                matched: _seqTapped.contains(i),
                selected: _seqCardLit(i),
                onTap: _seqRepeating ? () => _seqTap(i, l10n) : null,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildFindChanged(AppLocalizations l10n) {
    if (_changeCompleted >= _changeRounds.length) {
      return _doneColumn(l10n);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _changeMemorising ? l10n.t('changeRemember') : l10n.t('changeFind'),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(color: AppColors.inkSoft),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          alignment: WrapAlignment.center,
          children: [
            for (var i = 0; i < _changeRoundCards.length; i++)
              _MemoryTile(
                text: _changeMemorising
                    ? _changePool[_changeRoundCards[i]].left
                    : (i == _changeSwap
                          ? _changePool[_changeRoundCards[i]].right
                          : _changePool[_changeRoundCards[i]].left),
                shown: true,
                matched: _changeSolved && i == _changeSwap,
                onTap: _changeMemorising ? null : () => _changeTap(i, l10n),
              ),
          ],
        ),
        if (_changeMemorising) ...[
          const SizedBox(height: AppSpacing.lg),
          AppPrimaryButton(
            label: l10n.t('pairsStart'),
            onPressed: _endMemorise,
          ),
        ],
      ],
    );
  }

  Widget _buildShopping(AppLocalizations l10n) {
    final total = content.products
        .where((p) => _basket.contains(p.id))
        .fold<int>(0, (sum, p) => sum + p.price);
    final withinBudget = total <= content.budget;
    final allRequired = content.requiredProductIds.every(
      (id) => _basket.contains(id),
    );
    if (_checkoutAttempted) {
      return Column(
        children: [
          Text(
            withinBudget && allRequired ? '🛍️' : '🛒',
            style: TextStyle(fontSize: 64),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            withinBudget && allRequired
                ? l10n.t('shopWithinBudget')
                : l10n.t('shopOverBudget'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          if (withinBudget && allRequired)
            AppPrimaryButton(
              label: l10n.t('activityFinish'),
              onPressed: () => _finish(completed: true),
            )
          else
            AppPrimaryButton(
              label: l10n.t('activityTryAgain'),
              filledColor: AppColors.terracotta,
              onPressed: () => setState(() {
                _checkoutAttempted = false;
                _wrongTries += 1;
              }),
            ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '💵 ${content.budget}',
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: AppColors.terracotta),
            ),
            Text(
              '${l10n.t('shopTotal')}: $total',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final product in content.products)
              _ProductTile(
                product: product,
                inBasket: _basket.contains(product.id),
                onTap: () => setState(() {
                  if (!_basket.add(product.id)) {
                    _basket.remove(product.id);
                  }
                }),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.t('shopCheckout'),
          icon: Icons.shopping_bag_rounded,
          onPressed: () {
            setState(() => _checkoutAttempted = true);
          },
        ),
      ],
    );
  }

  String _prompt(AppLocalizations l10n) =>
      content.prompt == null ? '' : l10n.t(content.prompt!);

  Widget _doneColumn(AppLocalizations l10n) {
    return Column(
      children: [
        const Text('🎉', style: TextStyle(fontSize: 56)),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.t('activityFinish'),
          onPressed: () => _finish(completed: true),
        ),
      ],
    );
  }

  void _pairsStartMemorising() {
    _gameTimer?.cancel();
    _gameTimer = Timer(const Duration(seconds: 8), () {
      if (!mounted) return;
      setState(() => _pairsMemorising = false);
    });
  }

  void _endMemorise() {
    _gameTimer?.cancel();
    setState(() {
      if (_type == ActivityType.pairs) {
        _pairsMemorising = false;
      } else if (_type == ActivityType.findChanged) {
        _changeMemorising = false;
      }
    });
  }

  void _pairsTap(int index, AppLocalizations l10n) {
    if (_pairsLocked || _pairsMemorising) return;
    if (_pairsMatched.contains(index)) return;
    if (_pairsFirst == null) {
      setState(() => _pairsFirst = index);
      _speak(_pairsDeck[index]);
    } else if (_pairsSecond == null && _pairsFirst != index) {
      setState(() {
        _pairsSecond = index;
        _pairsLocked = true;
      });
      _speak(_pairsDeck[index]);
      _gameTimer?.cancel();
      if (_pairsDeck[_pairsFirst!] == _pairsDeck[index]) {
        _gameTimer = Timer(const Duration(milliseconds: 650), () {
          if (!mounted) return;
          setState(() {
            _pairsMatched
              ..add(_pairsFirst!)
              ..add(_pairsSecond!);
            _pairsFirst = null;
            _pairsSecond = null;
            _pairsLocked = false;
            _correct += 1;
          });
          _speak(l10n.t('pairsFound'));
        });
      } else {
        setState(() => _wrongTries += 1);
        _speak(l10n.t('activityTryAgain'));
        _gameTimer = Timer(const Duration(milliseconds: 1200), () {
          if (!mounted) return;
          setState(() {
            _pairsFirst = null;
            _pairsSecond = null;
            _pairsLocked = false;
          });
        });
      }
    }
  }

  void _seqStartRound(int round) {
    _gameTimer?.cancel();
    final poolIndices = List.generate(_seqPool.length, (i) => i)
      ..shuffle(Random.secure());
    final cards = poolIndices.take(_seqRounds[round]).toList();
    final order = List.generate(cards.length, (i) => i)
      ..shuffle(Random.secure());
    setState(() {
      _seqRound = round;
      _seqRoundCards = cards;
      _seqOrder = order;
      _seqTapped.clear();
      _seqRevealTick = 0;
      _seqRepeating = false;
    });
    _speak(l10nOf('seqRecallWatch'));
    _seqRevealStep();
  }

  void _seqRevealStep() {
    _gameTimer?.cancel();
    _gameTimer = Timer(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() => _seqRevealTick += 1);
      if (_seqRevealTick >= _seqOrder.length) {
        _gameTimer?.cancel();
        _gameTimer = Timer(const Duration(milliseconds: 700), () {
          if (!mounted) return;
          setState(() => _seqRepeating = true);
          _speak(l10nOf('seqRecallRepeat'));
        });
      } else {
        _seqRevealStep();
      }
    });
  }

  void _seqTap(int cardIndex, AppLocalizations l10n) {
    if (!_seqRepeating || _seqTapped.contains(cardIndex)) return;
    if (_seqOrder[_seqTapped.length] == cardIndex) {
      setState(() {
        _seqTapped.add(cardIndex);
        _seqCumDone += 1;
        _correct += 1;
      });
      _speak(l10n.t('activityGreatJob'));
      if (_seqTapped.length == _seqOrder.length &&
          _seqRound + 1 < _seqRounds.length) {
        Future.delayed(const Duration(milliseconds: 800), () {
          if (!mounted) return;
          _seqStartRound(_seqRound + 1);
        });
      }
    } else {
      setState(() => _wrongTries += 1);
      _speak(l10n.t('activityTryAgain'));
    }
  }

  void _changeStartRound(int round) {
    _gameTimer?.cancel();
    final idx = List.generate(_changePool.length, (i) => i)
      ..shuffle(Random.secure());
    final cards = idx.take(_changeRounds[round]).toList();
    setState(() {
      _changeRound = round;
      _changeRoundCards = cards;
      _changeSwap = Random.secure().nextInt(cards.length);
      _changeSolved = false;
      _changeMemorising = true;
      _changeLocked = false;
    });
    _speak(l10nOf('changeRemember'));
    _gameTimer = Timer(const Duration(seconds: 8), () {
      if (!mounted) return;
      setState(() => _changeMemorising = false);
    });
  }

  void _changeTap(int index, AppLocalizations l10n) {
    if (_changeMemorising || _changeLocked) return;
    if (index == _changeSwap) {
      setState(() {
        _changeSolved = true;
        _changeLocked = true;
        _changeCompleted += 1;
        _correct += 1;
      });
      _speak(l10n.t('changeCorrect'));
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (!mounted) return;
        if (_changeRound + 1 < _changeRounds.length) {
          _changeStartRound(_changeRound + 1);
        } else {
          setState(() => _changeLocked = false);
        }
      });
    } else {
      setState(() => _wrongTries += 1);
      _speak(l10n.t('activityTryAgain'));
    }
  }

  Widget _buildProgressHeader() {
    final done = switch (_type) {
      ActivityType.matching => _matchedIndices.length,
      ActivityType.sequence || ActivityType.kitchen => _tappedIndices.length,
      ActivityType.shopping =>
        (_basket.where((id) => content.products.any((p) => p.id == id)).length +
            (_checkoutAttempted ? 0 : 0)),
      ActivityType.pairs => _pairsMatched.length ~/ 2,
      ActivityType.sequenceRecall => _seqCumDone,
      ActivityType.findChanged => _changeCompleted,
      _ => (_answered && _answeredCorrect ? 1 : 0),
    };
    final total = switch (_type) {
      ActivityType.matching => content.pairs.length,
      ActivityType.sequence || ActivityType.kitchen => content.steps.length,
      ActivityType.shopping =>
        content.requiredProductIds.isEmpty
            ? content.products.length
            : content.requiredProductIds.length,
      ActivityType.pairs => content.variants.length,
      ActivityType.sequenceRecall => _seqRounds.fold(0, (sum, r) => sum + r),
      ActivityType.findChanged => _changeRounds.length,
      _ => 1,
    };
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: total == 0 ? 0 : (done / total).clamp(0.0, 1.0),
        minHeight: 8,
        backgroundColor: AppColors.line,
        color: AppColors.deepGreen,
      ),
    );
  }
}

class _ChoiceTile extends StatelessWidget {
  const _ChoiceTile({
    required this.label,
    required this.selected,
    required this.correct,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool correct;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = correct
        ? AppColors.successSoft
        : (selected ? AppColors.roseSoft : AppColors.creamCard);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: selected || correct ? AppColors.lineStrong : AppColors.line,
            width: selected || correct ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _MemoryTile extends StatelessWidget {
  const _MemoryTile({
    required this.text,
    this.onTap,
    this.shown = true,
    this.matched = false,
    this.selected = false,
  });

  final String text;
  final VoidCallback? onTap;
  final bool shown;
  final bool matched;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final bg = matched
        ? AppColors.sageMist
        : (selected ? AppColors.roseSoft : AppColors.creamCard);
    final border = matched
        ? AppColors.deepGreen
        : (selected ? AppColors.terracotta : AppColors.line);
    final width = matched || selected ? 2.0 : 1.0;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        width: 96,
        height: 100,
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: border, width: width),
        ),
        alignment: Alignment.center,
        child: Text(
          shown ? text : '❓',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: shown ? 28 : 42),
        ),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({
    required this.product,
    required this.inBasket,
    required this.onTap,
  });

  final Product product;
  final bool inBasket;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Container(
        width: 112,
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: inBasket ? AppColors.sageMist : AppColors.creamCard,
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(
            color: inBasket ? AppColors.deepGreen : AppColors.line,
            width: inBasket ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              product.emoji.isEmpty ? '🛍️' : product.emoji,
              style: const TextStyle(fontSize: 34),
            ),
            const SizedBox(height: 6),
            Text(
              product.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 4),
            Text(
              '₹${product.price}',
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppColors.terracotta),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({
    required this.text,
    required this.emoji,
    required this.onSpeak,
  });

  final String text;
  final String emoji;
  final VoidCallback onSpeak;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (emoji.isNotEmpty) ...[
            Text(emoji, style: const TextStyle(fontSize: 34)),
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.titleLarge),
          ),
          InkWell(
            onTap: onSpeak,
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.skySoft,
              child: Icon(
                Icons.volume_up_rounded,
                color: AppColors.deepGreenDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Positive closing view: garden grew, mystery unlocked, words of praise.
class _CelebrationView extends ConsumerWidget {
  const _CelebrationView({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌼', style: TextStyle(fontSize: 84)),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.t('activityGreatJob'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge
                  ?.copyWith(color: AppColors.deepGreen),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.t('activityPraise'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppPrimaryButton(
              label: l10n.t('done'),
              icon: Icons.check_rounded,
              onPressed: onDone,
            ),
          ],
        ),
      ),
    );
  }
}
