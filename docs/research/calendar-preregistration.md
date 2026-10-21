# TTC-CALENDAR(7)

## NAME

**ttc-calendar** — the liturgical day, its precedence, its evening, and the
Sunday obligation met; predictions, committed before encoding

## DESCRIPTION

Read as the rules stand (the base at `db97848`, committed just before these
predictions):

- **No liturgical day.** Nothing encodes the Table of Liturgical Days, the
  precedence of celebrations, First Vespers, or the evening on which a
  Sunday or a solemnity begins. `liturgy.lp` is silent on the calendar.
- **No Sunday obligation.** cc. 1246-1248 are not encoded. A question about
  a Saturday evening Mass is out of coverage: entered only as readings of a
  law the case invents, and decided only by what the case types (c. 18).
- **c. 14 is silent.** A doubt of law narrows an obliging law's reading
  through a constraint (`doubt_binds_strictly/1`) and leaves no atom saying
  so. On a case of a Saturday 1 p.m. Mass the narrower reading of "evening"
  is the only one read, and the output does not show it.
- **No date arithmetic.** The saeculum gives months' lengths
  (`days_in/3`); nothing gives a date's weekday or the day before it.

The case that found this: Our Lady of Guadalupe on Saturday 12 December
2026, before the Third Sunday of Advent. On the General Calendar it is an
optional memorial on an Advent weekday (gcatholic.org, General 2026); in the
United States, a Feast (USCCB, Proper Calendar).

## THE TEXTS

| Text | What it says |
| --- | --- |
| GNLY 3 | The liturgical day runs from midnight to midnight; the celebration of Sunday and of Solemnities begins already on the evening of the previous day. |
| GNLY 5 | Sunday gives way only to Solemnities and Feasts of the Lord; the Sundays of Advent, Lent and Easter take precedence over all Feasts of the Lord and all Solemnities. |
| GNLY 11 | Solemnities begin with First Vespers on the preceding day; some have their own Vigil Mass, "which is to be used on the evening of the preceding day, if an evening Mass is celebrated". |
| GNLY 13 | Feasts are celebrated within the limits of the natural day, and have no First Vespers (save Feasts of the Lord on a Sunday in Ordinary Time or Christmas Time). |
| GNLY 59-60 and the Table | Precedence is governed solely by the Table (ranks 1-13); of several celebrations on one day, the highest rank is observed and the others are omitted, save an impeded Solemnity, which is transferred. Optional Memorials (12) may be kept even on the days of no. 9. |
| GNLY 61 | Of Vespers of the current day and First Vespers of the next, the higher rank takes precedence; at equal rank, the current day. |
| c. 1246 §1 | Sunday is to be observed in the universal Church as the primordial holy day of obligation; ten other days are named. |
| c. 1247 | "On Sundays and other holy days of obligation, the faithful are obliged to participate in the Mass." |
| c. 1248 §1 | "A person who assists at a Mass celebrated anywhere in a Catholic rite either on the feast day itself or in the evening of the preceding day satisfies the obligation of participating in the Mass." |
| c. 1248 §2 | Where participation is impossible for want of a sacred minister or another grave cause, a liturgy of the word, or prayer, is "strongly recommended": a recommendation, not the obligation met. |
| c. 14 | Laws, even invalidating and disqualifying ones, do not oblige when there is a doubt of law. |
| Browne, *Letter & Spirit* (1995) 702; Peters, canonlaw.info (30 Nov 2008) | The evening of the previous day begins at noon; others place it at 2 p.m. (Huels, *CLSA New Commentary* (2001) 1445, is cited by Peters as contrary). |

The norms are quoted from the official English text published by the
Liturgy Office of England and Wales (`GNLY.pdf`), the canons from vatican.va.

## PREDICTIONS

### CD: the date

- **CD1.** A date's weekday and the day before it are computed (the
  Gregorian calendar, the saeculum's month lengths), never entered: 12
  December 2026 is a Saturday, 13 December 2026 a Sunday, 1 March 2024
  follows 29 February.

### CP: precedence (GNLY 59-60)

- **CP1.** A new slot, `celebration_on/3`: a celebration inscribed on a
  date with its rank in the Table, entered from the calendar in use. The
  celebration of the day is the one of highest rank (lowest number); the
  others are omitted. An Optional Memorial may be kept on a day whose
  celebration ranks 9 or below. An impeded Solemnity is a frontier
  (transfer is not encoded).
- **CP2.** The same date on two calendars: on the General Calendar the
  Advent Saturday is the day's celebration and OLOG may be kept; on the US
  calendar OLOG (a Feast, rank 8) is the day's celebration.

### CE: the evening (GNLY 3, 11, 13, 61)

- **CE1.** A Sunday or a Solemnity begins on the evening before; a Feast
  does not.
- **CE2.** An evening Mass on the eve of a Solemnity with its own Vigil
  Mass, celebrated with another formulary, is a violation (GNLY 11).
- **CE3.** No such rule binds the eve of a Sunday. An evening Mass on
  Saturday may be of the Sunday, or of the Saturday's own celebration: the
  base encodes no reading by which the evening belongs to the Sunday. A case
  may enter that reading and dispute it.
- **CE4.** Evening Prayer on the Saturday before the Third Sunday of Advent
  is the Sunday's (rank 2 over 8 or 13); at equal rank, the current day's.

### CO: the obligation (cc. 1247-1248, 14)

- **CO1.** New slots: `attends/2` and `mass_at/3` (a Mass, its date, its
  time). Any Mass in a Catholic rite on a Sunday, or on the evening before,
  meets that Sunday's obligation, whatever its formulary.
- **CO2.** "Evening" has two readings, from noon and from 2 p.m. A doubt of
  law (c. 14) reads the obligation narrowly: a Mass at 1 p.m. on the eve
  meets it. A new atom under c. 14 says so.
- **CO3.** A morning Mass on the eve, or a service that is not a Mass,
  meets nothing (c. 1248 §2 recommends, and obliges to nothing). Nothing is said of the person: the checker says when a
  Mass meets the obligation, never that anyone failed it (rule 3).

No other expectation of the suite changes, and CL1 stays clean.

## BUGS

The calendar is entered, not computed: Easter, Advent and their Sundays
come from a published calendar. The norms' English text is cited from the
Liturgy Office of England and Wales, not vatican.va (rule 4); vatican.va
has the approving motu proprio (*Mysterii paschalis*, 14 February 1969).
Huels's hour for "evening" was not read; his position enters only as
Peters cites it.
