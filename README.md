# Level Up

A daily progress tracker that works like a game. Add your daily tasks (gym, running, push-ups, eating healthy, steps, work), tick them off every day, and give a reason for anything you didn't do. Earn XP to climb the ranks from **Top 100%** to **Top 1%**, and lose XP when you miss.

**Live app:** https://buildwithayanc-png.github.io/level-up/

## How it works

- **Today:** tick each task, or press *Didn't do it* and pick a reason (too tired, no time, work overload, sick, forgot, and more).
- **Week strip:** Monday to Sunday, with a progress ring per day. Tap any day or go back through past weeks.
- **History:** weekly results, streaks, XP lost to misses, your most common reasons for missing, and each task's hit rate over the last 30 days.
- **Tasks:** add tasks by category (Fitness, Health, Work, Mind, Other) with a target, difficulty and repeat days, or for one day only.
- **Ranks:** 12 levels from Top 100% (Starter) to Top 1% (Legend).

## XP rules

| Event | XP |
|---|---|
| Easy / Medium / Hard task done | +1 / +2 / +3 |
| Easy / Medium / Hard task missed | −2 / −4 / −6 |
| Task still unanswered when the day ends | counts as missed |
| Every task answered that day | +1 |
| Perfect day (every task done) | +3 |
| Streak day (80% or more done) | +1 per day in the streak, max +5 |

XP never goes below 0, but it can drop, and your rank can drop with it.

## Where your data lives

This GitHub Pages version saves your progress in your browser (`localStorage`) on the device you use. Use the same browser every day, and don't clear its site data, or your log is lost.

The whole app is one file, [`index.html`](index.html), with no build step.
