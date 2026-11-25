# Level Up

A daily progress tracker that works like a game. Add your daily tasks (gym, running, push-ups, eating healthy, steps, work), tick them off every day, and give a reason for anything you didn't do. Earn XP to climb the ranks from **Top 100%** to **Top 1%**, and lose XP when you miss.

**Live app:** https://buildwithayanc-png.github.io/level-up/

## How it works

- **Weight:** a card at the top of the Today screen where you log your weight (kg) each day. It shows how much it went up or down since your last entry, over 7 days and over 30 days, with a 30-day trend line. **History and chart** opens a full page with a bigger chart (1 month, 3 months, 1 year or all), your start, lowest and highest weight, and every entry with its change. You can edit or delete any day, or add a past date.
  - **Goal weight:** set a target on the Weight page (for example 72 kg). Changes toward it show in green and changes away from it in red. A progress bar shows how many kg are left to lose or gain, the chart draws a dashed goal line, and once you have a week of entries the app estimates the date you'll reach it at your 30-day pace. You get a message when you reach it. Change or remove the goal any time.
- **Today:** tick each task, or press *Didn't do it* and pick a reason (too tired, no time, work overload, sick, forgot, and more).
- **Log sets:** tap a task's name to open it. Give it a daily goal, like 100 push-ups, then add each set as you finish it (12, 10, 15…). Each set is saved with the time and an optional note, and a progress bar shows how much is left. The task ticks itself when you reach the goal, and un-ticks if you delete a set and drop below it. Tasks without a goal can log notes too.
- **To-do:** a list under your tasks on the Today screen for one-off things, like "Pay the electricity bill". Type it and press Add. Anything you don't tick by midnight moves to the next day by itself, marked with the day it came from ("From yesterday", "From Sat · 4 days"). Past days show what you finished that day and what moved on. You can tick a past day's to-do if you did it that day, and add to-dos for a future day to plan ahead. To-dos don't give or take XP.
- **Wins:** at the end of each day, write the best things you did that day ("Finished the report early", "Called my parents"). Add them under your tasks on the Today screen, or in the **Wins** tab. Writing at least one win earns +1 XP for that day. The Wins tab shows which days this week you wrote something, how many days in a row, and every past day's wins, newest first and grouped by week. Tap a past day to open it and add more.
- **Week strip:** Monday to Sunday, with a progress ring per day. Tap any day or go back through past weeks.
- **History:** weekly results, streaks, XP lost to misses, your most common reasons for missing, and each task's hit rate over the last 30 days.
- **Tasks:** add tasks by category (Fitness, Health, Work, Mind, Other) with a target, an optional daily goal (a number and a unit, like 100 reps or 10,000 steps), difficulty and repeat days, or for one day only.
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
| Wrote at least one win for the day | +1 |

XP never goes below 0, but it can drop, and your rank can drop with it.

## Where your data lives

Your progress is always saved in your browser (`localStorage`), so the app works offline.

**Sync (optional):** tap **Sync off** at the top, then **Turn on sync**. Your log is copied online under a private 32-character sync code. Open **Copy link for another device** on your phone or laptop to connect it. Changes reach your other devices within a minute. No account or password is needed, but anyone with your code can see and change your log, so keep it private.

Sync runs on Supabase. The database stores only a SHA-256 hash of each sync code, the data table is in a private schema the public API can't reach, and the app can only read and write through two functions (`levelup_pull`, `levelup_push`) that check the code, the document name and its size. The setup is in [`supabase/levelup_sync.sql`](supabase/levelup_sync.sql).

The whole app is one file, [`index.html`](index.html), with no build step.
