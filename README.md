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

Your progress is always saved in your browser (`localStorage`), so the app works offline.

**Sync (optional):** tap **Sync off** at the top, then **Turn on sync**. Your log is copied online under a private 32-character sync code. Open **Copy link for another device** on your phone or laptop to connect it. Changes reach your other devices within a minute. No account or password is needed, but anyone with your code can see and change your log, so keep it private.

Sync runs on Supabase. The database stores only a SHA-256 hash of each sync code, the data table is in a private schema the public API can't reach, and the app can only read and write through two functions (`levelup_pull`, `levelup_push`) that check the code, the document name and its size. The setup is in [`supabase/levelup_sync.sql`](supabase/levelup_sync.sql).

The whole app is one file, [`index.html`](index.html), with no build step.
