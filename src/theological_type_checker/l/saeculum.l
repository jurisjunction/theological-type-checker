layer libraries

```clingo
% ===================================================================
%  The saeculum: one library for time (TTC-SAECULUM)
```

library

```clingo
%
%  Time is an order of events, partial and without cycle: the kernel's
%  before/2. Calendars are measures laid on the order, not the order. A
%  distributed system keeps no global clock: time is the happens-before
%  order of events (Lamport, 1978), each event dated by whoever records
%  it, as a commit's date is typed by whoever commits and a stamp anchors
%  it (rule 12).
%
%    the calendar   Gregorian; a date is a day, the integer YYYYMMDD
%    the clock      now/1: today/1, or the last day of an asof year
%    the measures   eternity for God alone; a beginning for every
%                   creature; Thomas's aevum, carried as his
%    the bounds     creation and the return: nothing before the
%                   beginning; the end neither dated nor past
%
%  The Church's computation of time is law (cc. 8 §1, 97 §1, 202-203):
%  canon_law.lp, under @norm, with this calendar. Reception is the
%  authority layer's (icon_authority.lp).
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot custom_asof/0
  means "an asof part sets the clock, not today/1"
  say "an asof part sets the clock"

slot end_event(E: event)
  means "end_event(E): the return and the judgment, which take no date"
  say "{E} takes no date"

slot month_days(M: number, N: number)
  means "month_days(M, N): the days of month M"
  say "month {M} has {N} days"

slot promulgated(Act: law, Date: date)
  means "promulgated(Act, Date): a law, or an authentic interpretation in the form of law, published (cc. 7-8, 16 §2)"
  say "{Act} was promulgated on {Date}"

slot today(Date: date)
  means "today(Date): the evaluation date, YYYYMMDD"
  say "the evaluation date is {Date}"

use before/2 "from the kernel: the order of events (next/2, transitive)"

use ind_sort/2 "from the kernel: div or cr"

use angel/1 "from the kernel's sorts"

use o_edge/3 "from the kernel: an origination edge and its act"

use orig_div/2 "from the kernel: an origination in God"

use happens_at/2 "happens_at(E, Point): an event placed at a point of the order"

use interprets/3 "from the authority graph"

use cites/2 "from the authority graph"

use claims_tier/3 "from the authority graph (rule 14)"

use oum_claimant/2 "from the authority graph (rule 14)"

```clingo

% ---------- The calendar (Gregorian) ----------------------------------
% A year the law asks about (cal_year/1) gets its months' lengths. Dates
% before 15 October 1582 are Julian in the record; nothing here converts.
```

use cal_year/1 "a year the law asks about (canon_law.lp: c. 203's counts)"

```clingo
month_days((1;3;5;7;8;10;12),31).
month_days((4;6;9;11),30).
leap(Y) :- cal_year(Y), Y \ 4 = 0, Y \ 100 != 0.
leap(Y) :- cal_year(Y), Y \ 400 = 0.
days_in(Y,M,L)  :- cal_year(Y), month_days(M,L).
days_in(Y,2,29) :- cal_year(Y), leap(Y).
days_in(Y,2,28) :- cal_year(Y), not leap(Y).

% ---------- The week, and the days either side (TTC-CALENDAR CD1) -------
% Of a day the law asks about (day_asked/1): its weekday, by Zeller's
% congruence for the Gregorian calendar (January and February counted as
% the 13th and 14th months of the year before; 0 is Saturday), and the day
% before and after it. Computed, never entered.
```

use day_asked/1 "a day the law asks about (canon_law.lp: the liturgical day, the Sunday obligation)"

slot weekday_name(N: number, W: category)
  means "weekday_name(N, W): Zeller's number N of a weekday (0 is Saturday)"
  say "weekday {N} is {W}"

```clingo
cal_year(Y) :- day_asked(D), Y = D/10000.
weekday_name(0,saturday).
weekday_name(1,sunday).
weekday_name(2,monday).
weekday_name(3,tuesday).
weekday_name(4,wednesday).
weekday_name(5,thursday).
weekday_name(6,friday).
zeller(D,D\100,M,D/10000)        :- day_asked(D), M = (D/100)\100, M >= 3.
zeller(D,D\100,M+12,D/10000 - 1) :- day_asked(D), M = (D/100)\100, M <= 2.
weekday(D,W) :- zeller(D,Q,M,Y), K = Y\100, J = Y/100, H = (Q + 13*(M+1)/5 + K + K/4 + J/4 + 5*J)\7, weekday_name(H,W).
day_before(D,D-1) :- day_asked(D), D\100 > 1.
day_before(D,P)   :- day_asked(D), D\100 = 1, M = (D/100)\100, M > 1, Y = D/10000, days_in(Y,M-1,L), P = Y*10000 + (M-1)*100 + L.
day_before(D,P)   :- day_asked(D), D\100 = 1, (D/100)\100 = 1, P = (D/10000 - 1)*10000 + 1231.
day_after(D,D+1)  :- day_asked(D), M = (D/100)\100, days_in(D/10000,M,L), D\100 < L.
day_after(D,N)    :- day_asked(D), M = (D/100)\100, M < 12, days_in(D/10000,M,L), D\100 = L, N = (D/10000)*10000 + (M+1)*100 + 1.
day_after(D,N)    :- day_asked(D), (D/100)\100 = 12, D\100 = 31, N = (D/10000 + 1)*10000 + 101.

% ---------- The clock (CA1) --------------------------------------------
% One evaluation date for both layers: the day a case gives (today/1), or
% the last day of an asof year. With today and no asof, the authority
% layer reads today's year; with neither, every source entered (9999).
clocked :- today(_).
now(T)     :- today(T), not custom_asof.
now(T)     :- custom_asof, asof(Y), T = Y*10000 + 1231.
asof(Y)    :- today(T), not custom_asof, Y = T / 10000.
asof(9999) :- not custom_asof, not clocked.

% ---------- One act, one date (CA2) -------------------------------------
% An act dated in both layers carries one year.
violation(dates_disagree(S,Y,D)) :- source(S,_,_,Y), promulgated(S,D), D / 10000 != Y.

% ---------- The order first (OR1) ---------------------------------------
% What interprets, cites or makes a claim about an act comes after it: a
% measure laid against that order is refused.
depends_on(S2,S1) :- interprets(S2,S1,_).
depends_on(S2,S1) :- cites(S2,S1).
depends_on(C,S)   :- claims_tier(C,S,_).
depends_on(C,S)   :- oum_claimant(S,C).
violation(measure_against_order(S2,S1)) :- depends_on(S2,S1), source(S2,_,_,Y2), source(S1,_,_,Y1), Y2 < Y1.

% ---------- The bounds (OR2, OR3) ---------------------------------------
% The saeculum runs from creation to the return (the kernel's economy).
% "Of that day and hour no one knows" (Mt 24:36); "it is not for you to
% know times or seasons which the Father has fixed" (Acts 1:7; CCC 673);
% "only the Father knows the day and the hour" (CCC 1040). Refused too:
% "holding that the resurrection is past already" (2 Tim 2:18). God made
% both orders of creatures "from the beginning of time" (DH 800): the
% world was made not in time but with time (Augustine, De civ. Dei XI.6).
% The age of the world is the empirical step's.
```

slot date_claim(E: event, Year: year)
  means "date_claim(E, Year): a calendar year laid on an event of the order"
  say "the year {Year} is laid on the event {E}"

```clingo
end_event(return). end_event(judgment).
measured(E) :- date_claim(E,_).
measured(E) :- event_date(E,_).
measured(S) :- source(S,_,_,_).
violation(end_dated(E))            :- end_event(E), measured(E).
violation(end_past(E,X))           :- end_event(E), before(E,X), measured(X).
violation(before_the_beginning(X)) :- before(X,creation).

% ---------- The measures (MD) -------------------------------------------
% Eternity, "the simultaneously-whole and perfect possession of
% interminable life" (Boethius; ST I q. 10 a. 1), is God's alone (a. 3;
% DH 800, 3001). Every creature began (DH 800; DH 3002); that the world
% did not always exist "by faith alone do we hold" (ST I q. 46 a. 2). Time
% numbers motion "by before and after" (q. 10 a. 1). The aevum, between,
% measures spiritual creatures (a. 5): Thomas's, not the deposit's, and
% nothing is refused on it.
```

slot measured_by(X: entity, M: category)
  means "measured_by(X, M): a claim that X's duration is measured by M (eternity, aevum, time)"
  say "the duration of {X} is claimed measured by {M}"

slot without_beginning(X: entity)
  means "a claim that X had no beginning"
  say "{X} is claimed to have had no beginning"

```clingo
measure(X,eternity) :- ind_sort(X,div).
measure(X,aevum)    :- angel(X).                        % Thomas, ST I q. 10 a. 5
measure(X,time)     :- ind_sort(X,cr), not angel(X).
measure(X,M)        :- measured_by(X,M).
begins(X)           :- ind_sort(X,cr).
violation(eternal_with_beginning(X))     :- measure(X,eternity), begins(X).
violation(creature_without_beginning(X)) :- without_beginning(X), ind_sort(X,cr).
% The Son is co-eternal with the Father (ST I q. 42 a. 2); Nicaea
% anathematizes "there was when he was not" (DH 126). A procession in God
% is no event of the order and bears no date (MD2).
procession(A) :- o_edge(P,Z,A), orig_div(P,Z), not in_nature(A,hum).
in_order(E) :- next(E,_).
in_order(E) :- next(_,E).
in_order(E) :- happens_at(E,_).
violation(procession_in_time(A)) :- procession(A), in_order(A).
violation(procession_in_time(A)) :- procession(A), measured(A).
% "To God, all moments of time are present in their immediacy" (CCC 600;
% ST I q. 14 a. 13): God's act is not dated, its effects are (MD4).
violation(divine_act_in_time(A)) :- act_of(G,A), god(G), in_order(A).
violation(divine_act_in_time(A)) :- act_of(G,A), god(G), measured(A).

% ---------- An evaluation date, and candidates (all HYPOTHETICAL) --------
```

part switch

```clingo
#program today_20261010.           % an evaluation date given as a day (CA1)
today(20261010).
```

part candidate

```clingo
#program cand_dates_disagree.      % HYPOTHETICAL: one act given two years (CA2)
source(act_d,3,juridical,2001). promulgated(act_d,20000505).
```

part candidate

```clingo
#program cand_end_dated.           % HYPOTHETICAL: a year laid on the return; a day on the judgment
date_claim(return,2100). act_date(judgment,21000101).
```

part candidate

```clingo
#program cand_end_past.            % HYPOTHETICAL: the return placed before a dated event and a dated source (2 Tim 2:18)
next(return,council_x). date_claim(council_x,1545).
next(return,council_y). source(council_y,3,juridical,1546).
```

part candidate

```clingo
#program cand_before_creation.     % HYPOTHETICAL: an event ordered before the beginning
next(first_motion,creation).
```

part candidate

```clingo
#program cand_generation_dated.    % HYPOTHETICAL: the Son's begetting placed after creation; the spiration dated (load with trinity, creed)
next(creation,begetting). date_claim(spiration,33).
```

part candidate

```clingo
#program cand_world_eternal.       % HYPOTHETICAL: a world without beginning (Aristotle, Physics VIII.1)
inanimate(world). without_beginning(world).
```

part candidate

```clingo
#program cand_light_eternal.       % HYPOTHETICAL: light given eternity's mode for its zero proper time
inanimate(light). measured_by(light,eternity).
```

part candidate

```clingo
#program cand_decree_dated.        % HYPOTHETICAL: God's decrees placed at a moment, before an event, at a year (load with world, creed)
act_of(god,decree_of_election). happens_at(decree_of_election,annunciation).
act_of(god,decree_of_mission). next(decree_of_mission,pentecost).
act_of(god,decree_of_end). date_claim(decree_of_end,2100).
```

part candidate

```clingo
#program cand_dated_before.        % HYPOTHETICAL: glosses dated before the texts they cite, interpret, grade, or claim for the OUM
source(text_t,3,juridical,2000). source(gloss_g,3,juridical,1990). cites(gloss_g,text_t).
source(text_i,3,juridical,2000). source(gloss_i,3,juridical,1990). interprets(gloss_i,text_i,r).
source(text_c,3,juridical,2000). source(gloss_c,3,juridical,1990). claims_tier(gloss_c,text_c,3).
source(text_o,3,juridical,2000). source(gloss_o,3,juridical,1990). oum_claimant(text_o,gloss_o).
```
