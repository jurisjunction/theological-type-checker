layer canon

-- Sorts first used in this layer (TTC-L, TY): closed, then open

sort table_rank 1..13
  means "a number of the Table of Liturgical Days, in order of precedence (GNLY 59)"

sort celebration
  means "a celebration of the liturgical year, by the name of its day in the calendar in use"

sort formulary
  means "a Mass formulary of the Roman Missal, by its celebration"

sort legal_matter
  means "a matter of law (c. 19)"

sort norm
  means "a canon of the rule base, by its id"

sort penalty
  means "a penalty or censure"

sort situation
  means "an outward situation of a person (c. 915)"

```clingo
% ===================================================================
%  Canon law as rules: binary, dated, and graphed.
%
%  Given the facts and the norm in force, a juridical effect follows or
%  it does not. Nothing here is weighed. Uncertainty enters only in
%  three ways:
%    1. a disputed fact      disputed(F): the checker computes F and not-F
%    2. a disputed reading   canon_reading/2, used only where no authentic
%                            interpretation exists (c. 16 §1)
%    3. the internal forum   imputability, intention, belief: never
%                            computed, only supplied as input
%  Doctrine (the opinion of canonists) is not weight here. It may fill a
%  lacuna (c. 19), and never in a penal case.
%
%  Conventions (read by norms.py, the norm graph):
%    % @norm <id> | <citation> | <source URL>   rules below belong to <id>
%    % @input <name>/<arity> | <meaning>        a fact a case supplies
%  Dates are integers YYYYMMDD. Texts: Code of Canon Law, Book VI as
%  revised by Pascite gregem Dei (in force 8 December 2021); earlier
%  canons where an event predates the revision.
% ===================================================================

```

-- Slots this layer reads first (TTC-L, SO): what a case enters

slot age_clause(D: law, N: norm)
  means "age_clause(D, N): D's clause that the error about the age does not excuse from delict N (c. 1398 §1 n. 1; art. 6 n. 1)"
  say "{D} says the error about the age does not excuse from {N}"

slot censure_barring(K: penalty)
  means "censure_barring(K): a censure that bars from Holy Communion (c. 915)"
  say "the censure {K} bars from Holy Communion"

slot eastern_church(C: church)
  means "eastern_church(C): an Eastern Church sui iuris in full communion"
  say "{C} is an Eastern Church in full communion"

slot eastern_noncatholic_church(C: church)
  means "eastern_noncatholic_church(C): an Eastern Church not in full communion"
  say "{C} is an Eastern Church not in full communion"

slot element_of(N: norm, C: circumstance)
  means "element_of(N, C): C is an element of the matter of delict N"
  say "{C} is an element of the matter of {N}"

slot excusing(C: circumstance)
  means "excusing(C): a circumstance that exempts when believed invincibly (c. 1323 n. 7)"
  say "{C}, believed invincibly, exempts"

slot lapse_date(L: law, Date: date)
  means "lapse_date(L, Date): the date a law lapses by its own terms"
  say "{L} lapses on {Date}"

slot latae_sententiae(N: norm)
  means "latae_sententiae(N): the penalty of delict N is incurred by the act (c. 1314)"
  say "the penalty of {N} is incurred by the act"

slot narrower(R1: reading, R2: reading)
  means "narrower(R1, R2): reading R1 reaches less than R2"
  say "the reading {R1} reaches less than {R2}"

slot penalty(N: norm, K: penalty)
  means "penalty(N, K): the penalty of delict N"
  say "the penalty of {N} is {K}"

slot reorders(L2: law, B: law)
  means "reorders(L2, B): L2 reorders the whole matter of B (c. 20)"
  say "{L2} reorders the whole matter of {B}"

slot revokes(L2: law, B: law, Way: category)
  means "revokes(L2, B, Way): L2 revokes B expressly, by contrary law, or by reordering (c. 20)"
  say "{L2} revokes {B} by {Way}"

```clingo

% ---------- Inputs ---------------------------------------------------------
```

use priest/1 "a priest"

use bishop/1 "a bishop"

slot in_class(Person: person, Class: class)
  means "in_class(Person, Class): e.g. the clergy of a society"
  say "{Person} is of the class {Class}"

slot consecration(Event: act, PrincipalConsecrator: person, Consecrated: person, Date: date)
  means "consecration(Event, PrincipalConsecrator, Consecrated, Date)"
  say "{PrincipalConsecrator} consecrated {Consecrated} on {Date} ({Event})"

slot co_consecrator(Event: act, Bishop: person)
  means "co_consecrator(Event, Bishop)"
  say "{Bishop} co-consecrated at {Event}"

slot pontifical_mandate(E: act)
  means "the consecration had a pontifical mandate"
  say "the consecration {E} had a pontifical mandate"

slot against_explicit_papal_will(A: act)
  means "the act was done against the pope's expressed will"
  say "the act {A} was done against the pope's expressed will"

slot decree(Decree: act, Issuer: authority, Date: date)
  means "decree(Decree, Issuer, Date)"
  say "{Issuer} issued the decree {Decree} on {Date}"

slot declares(Decree: act, Person: person, Norm: norm)
  means "declares(Decree, Person, Norm): names a person and declares a penalty"
  say "{Decree} declares {Person} under {Norm}"

slot heard(D: act, P: person)
  means "c. 1720 n. 1: accused informed of accusation and proofs, able to defend"
  say "before {D}, {P} was informed of the accusation and the proofs, and could defend himself"

slot summoned_absent(D: act, P: person)
  means "duly summoned and failed to appear"
  say "{P} was duly summoned before {D} and failed to appear"

slot recourse(Decree: act, Person: person, Date: date)
  means "recourse(Decree, Person, Date)"
  say "{Person} took recourse against {Decree} on {Date}"

slot recourse_decided(Decree: act, Date: date)
  means "recourse_decided(Decree, Date)"
  say "the recourse against {Decree} was decided on {Date}"

slot recourse_upheld(Decree: act)
  means "the decree was annulled on recourse"
  say "{Decree} was annulled on recourse"

slot notified(Decree: act, Person: person, Date: date)
  means "notified(Decree, Person, Date): the decree made known to the person by the authority of its author (c. 54 §1)"
  say "{Decree} was made known to {Person} on {Date}"

slot approved_in_specific_form(Decree: act)
  means "a curial decree approved by the Roman Pontiff in specific form, and so his own act"
  say "{Decree} was approved by the Roman Pontiff in specific form"

slot decides_recourse(Decision: act, Decree: act)
  means "decides_recourse(Decision, Decree): the decision on the recourse against the decree"
  say "{Decision} decides the recourse against {Decree}"

slot reserved_to_ddf(N: norm)
  means "reserved_to_ddf(N): the delict of N is reserved to the Dicastery for the Doctrine of the Faith (SST 2021)"
  say "the delict of {N} is reserved to the Dicastery for the Doctrine of the Faith"

slot remission(Act: act, Person: person, Norm: norm, Date: date)
  means "remission(Act, Person, Norm, Date): a censure remitted"
  say "{Act} remitted to {Person} the censure of {Norm} on {Date}"

slot issuer(Act: act, Authority: authority)
  means "issuer(Act, Authority)"
  say "{Authority} issued {Act}"

slot authority(A: authority, Rank: rank)
  means "authority(A, Rank): 4 pope (or by papal mandate/approval), 3 dicastery, 1 ordinary"
  say "{A} holds authority of rank {Rank}"

slot grant(G: act, Issuer: person, Faculty: category, Class: class, Date: date)
  means "grant(G, Issuer, Faculty, Class, Date)"
  say "{Issuer} granted {Class} the faculty {Faculty} on {Date} ({G})"

slot permission(P: act, Issuer: authority, Class: class, Date: date)
  means "permission(P, Issuer, Class, Date): ordinaries may delegate for this class"
  say "by {P}, {Issuer} let ordinaries delegate for {Class} from {Date}"

slot revocation(Act: act, Grant: act, Date: date)
  means "revocation(Act, Grant, Date): an act purporting to revoke a grant"
  say "on {Date}, {Act} purports to revoke {Grant}"

slot absolution(A: act, Priest: person, Penitent: person, Date: date)
  means "absolution(A, Priest, Penitent, Date)"
  say "{Priest} absolved {Penitent} on {Date} ({A})"

slot marriage(M: act, AssistingPriest: person, Date: date)
  means "marriage(M, AssistingPriest, Date)"
  say "the marriage {M} was celebrated on {Date}, {AssistingPriest} assisting"

slot delegation(D: act, Ordinary: person, Priest: person, Scope: act, Date: date)
  means "delegation(D, Ordinary, Priest, MarriageOrGeneral, Date)"
  say "{Ordinary} delegated {Priest} for {Scope} on {Date} ({D})"

slot ordinary(P: person)
  means "a local ordinary"
  say "{P} is a local ordinary"

slot pastor_of(P: person, T: place)
  means "pastor_of(P, T): P holds the office of pastor of the parish T"
  say "{P} is the pastor of {T}"

slot ordinary_of(P: person, T: place)
  means "ordinary_of(P, T): P is the local ordinary of the territory T"
  say "{P} is the local ordinary of {T}"

slot held_in(M: act, T: place)
  means "held_in(M, T): the marriage M was celebrated within the territory T"
  say "the marriage {M} was celebrated within {T}"

slot within(T: place, D: place)
  means "within(T, D): the territory T lies within D (a parish within a diocese)"
  say "{T} lies within {D}"

slot witnesses(M: act, N: number)
  means "witnesses(M, N): the number of witnesses present at the marriage M (c. 1108 §1)"
  say "{N} witnesses were present at {M}"

slot danger_of_death(Penitent: person, Date: date)
  means "danger_of_death(Penitent, Date)"
  say "{Penitent} was in danger of death on {Date}"

slot just_cause_request(Penitent: person, Priest: person, Date: date)
  means "just_cause_request(Penitent, Priest, Date)"
  say "on {Date}, {Penitent} asked {Priest} for absolution for a just cause"

slot common_error(A: act)
  means "c. 144: common error or positive and probable doubt about this act"
  say "in {A} there was common error, or positive and probable doubt"

slot appears_otherwise(P: person, A: act)
  means "the external presumption of imputability is rebutted on the facts"
  say "on the facts, the presumption of imputability for {P} in {A} is rebutted"

use promulgated/2 "promulgated(Act, Date): a law, or an authentic interpretation in the form of law, published (cc. 7-8, 16 §2)"

slot vacatio_set(Law: law, Date: date)
  means "vacatio_set(Law, Date): the law names its own date of force (c. 8 §1, another vacatio)"
  say "{Law} names its own date of force, {Date}"

slot aas_issue(Law: law, Date: date)
  means "aas_issue(Law, Date): the date the issue of the Acta Apostolicae Sedis carrying the law bears (c. 8 §1)"
  say "the issue of the Acta carrying {Law} is dated {Date}"

slot aas_volume(Law: law, Year: year, Given: date)
  means "aas_volume(Law, Year, Given): the issue unread; its volume's year and the date the act was given"
  say "{Law} is in the Acta's volume for {Year}, the issue unread; the act was given {Given}"

slot born(Person: person, Date: date)
  means "born(Person, Date): a birth date (c. 97, with c. 203)"
  say "{Person} was born on {Date}"

slot enacted_by(Body: law, Law: law)
  means "enacted_by(Body, Law): a body of norms enacted by this law"
  say "{Body} is enacted by {Law}"

slot part_of(Norm: canon, Body: law)
  means "part_of(Norm, Body)"
  say "{Norm} is part of {Body}"

slot interpretation_form(Act: act, Form: category)
  means "interpretation_form(Act, law | particular): an authentic interpretation's form (c. 16 §§2-3)"
  say "the interpretation {Act} is in the form {Form}"

slot particular_matter(Act: act, Event: act)
  means "particular_matter(Act, Event): the matter an act in a particular matter concerns (c. 16 §3)"
  say "the act {Act} concerns the particular matter {Event}"

slot applies_reading(Act: act, Canon: canon, Reading: reading)
  means "applies_reading(Act, Canon, Reading): an act that applies this reading of a canon"
  say "the act {Act} applies the reading {Reading} of {Canon}"

slot needs_reading(Law: canon, Context: entity)
  means "needs_reading(Law, Context): the law's reading decides something here"
  say "the reading of {Law} decides something for {Context}"

slot legislator(Law: law, Authority: authority)
  means "legislator(Law, Authority)"
  say "{Authority} gave {Law}"

slot contrary_to_law(L: law, H: law)
  means "contrary_to_law(L, H): a juridical finding that human law L contradicts human law H"
  say "{L} contradicts {H}"

slot contrary_to_provision(L: law, P: act)
  means "contrary_to_provision(L, P): a juridical finding that the law L cannot be reconciled with the provision P of an executive act"
  say "{L} cannot be reconciled with the provision {P}"

slot invalidating(L: law)
  means "an invalidating or disqualifying law (c. 10)"
  say "{L} is an invalidating or disqualifying law"

slot obliging(L: law)
  means "a law that imposes an obligation"
  say "{L} imposes an obligation"

slot permits(L: law)
  means "a law that grants a permission"
  say "{L} grants a permission"

slot fact_for(Law: law, X: entity, Fact: fact)
  means "fact_for(Law, X, Fact): whether the law reaches X turns on this fact"
  say "whether {Law} reaches {X} turns on {Fact}"

slot lacuna(Matter: legal_matter)
  means "lacuna(Matter): no custom and no express prescript (c. 19)"
  say "on {Matter} there is no custom and no express prescript"

slot penal_matter(Matter: legal_matter)
  means "the matter is penal"
  say "{Matter} is penal"

slot equity_rule(Matter: legal_matter, Rule: category)
  means "equity_rule(Matter, Rule): a rule drawn by c. 19's means; supplied, never computed"
  say "on {Matter}, the rule {Rule} is drawn by c. 19's means"

slot dispensation(Act: act, Law: law, X: entity)
  means "dispensation(Act, Law, X): a dispensation from Law for X"
  say "{Act} dispenses {X} from {Law}"

slot defines_essentials(L: law)
  means "the law defines what essentially constitutes an institute or juridic act (c. 86)"
  say "{L} defines what essentially constitutes an institute or a juridic act"

slot doubtful_revocation(Later: law, Earlier: law)
  means "doubtful_revocation(Later, Earlier): whether the later revokes the earlier is in doubt"
  say "whether {Later} revokes {Earlier} is in doubt"

use age_at/3 "age_at(Person, Act, Years): the agent's age when the act was placed, where no birth date is given"

slot juridic_act(Act: act, Person: person)
  means "juridic_act(Act, Person): a juridic act placed by the person (c. 124)"
  say "{Person} placed the juridic act {Act}"

slot spouse(Marriage: act, Person: person)
  means "spouse(Marriage, Person): one who gave consent to the marriage"
  say "{Person} gave consent to the marriage {Marriage}"

use claims_necessity/2 "the agent publicly claims a state of necessity for the act"

slot asserts(Text: source, Claim: claim, Date: date)
  means "asserts(Text, Claim, Date): a text's claim about the juridical situation"
  say "from {Date}, {Text} asserts {Claim}"

use disputed/1 "a fact whose truth is disputed"

use today/1 "the evaluation date when no asof is given"

slot authentic_reading(Canon: canon, Reading: reading, Act: act)
  means "authentic_reading(Canon, Reading, Act): the legislator's own reading (c. 16 §1)"
  say "the legislator reads {Canon} as {Reading}, by the act {Act}"

use of_kind/2 "from the theological side (pair.lp): in this branch the event is classified as of this kind"

slot punishes_culpa(N: norm)
  means "c. 1321 §3: the law punishes this delict also when committed by culpability"
  say "{N} punishes its delict committed by culpability too"

slot communion(C: act, Person: person, Date: date)
  means "communion(C, Person, Date): holy communion received, or sought"
  say "{Person} received or sought Holy Communion on {Date} ({C})"

slot situation(Person: person, S: situation)
  means "situation(Person, S): an outward situation of the person"
  say "{Person} is in the situation {S}"

slot situation_kind(S: situation, Kind: kind)
  means "situation_kind(S, Kind): the kind of act or state the situation is"
  say "the situation {S} is of the kind {Kind}"

slot manifest(S: situation)
  means "manifest(S): the situation is publicly known"
  say "the situation {S} is publicly known"

slot persisting(S: situation)
  means "persisting(S): the situation endures and is not ended"
  say "the situation {S} endures"

slot confession_impossible(P: person, C: act)
  means "confession_impossible(P, C): a grave reason, and no opportunity to confess (c. 916)"
  say "for {P}, before {C}, there was grave reason and no chance to confess"

use grave_by_matter/1 "moral.lp: a kind grave by its matter, from the theological side"

use not_of_kind/2 "from the theological side (pair.lp): in this branch the event is classified as not of this kind"

use notoriety_substitutes/2 "candidate only: notoriety treated as the hearing"

slot treated_as_declaring(Text: source, Class: class)
  means "candidate only: a text's class statement treated as a declaration"
  say "{Text} is treated as declaring the class {Class}"

slot unbaptized(P: person)
  means "the person is recorded as not baptized (c. 842 §1)"
  say "{P} is recorded as not baptized"

slot dissolution(D: act, Marriage: act, Way: category, Date: date)
  means "dissolution(D, Marriage, non_consummation | favour_of_faith | Other, Date): an act that dissolves a bond"
  say "{D} dissolves the marriage {Marriage} by {Way} on {Date}"

slot consummated(M: act)
  means "the marriage was consummated (c. 1061 §1)"
  say "the marriage {M} was consummated"

slot nullity_sentence(S: act, Marriage: act, Date: date)
  means "nullity_sentence(S, Marriage, Date): a sentence declaring a marriage null"
  say "{S} declared the marriage {Marriage} null on {Date}"

slot sentence_effective(S: act)
  means "the sentence has become effective (c. 1679)"
  say "the sentence {S} has become effective"

slot prohibited_to_marry(P: person)
  means "a prohibition attached to the sentence or set by the local ordinary (c. 1682 §1)"
  say "{P} is prohibited to marry"

slot delict_act(Person: person, Norm: norm, Act: act)
  means "delict_act(Person, Norm, Act): an external violation of the norm, as a case records it (a delict that need not be a consecration, absolution or marriage)"
  say "{Person} violated {Norm} outwardly by {Act}"

slot act_date(Act: act, Date: date)
  means "act_date(Act, Date): the date of an act a case records"
  say "the act {Act} is dated {Date}"

slot seal_lifted(Act: act, Why: ground)
  means "seal_lifted(Act, Why): a candidate's claim that something released the confessor"
  say "the seal over {Act} is claimed released by {Why}"

slot baptized_in(Person: person, Church: church)
  means "baptized_in(Person, catholic | Community): a baptism the case records, its validity presumed"
  say "{Person} was baptized in the {Church} Church"

slot received_into(P: person)
  means "the person was received into the Catholic Church"
  say "{P} was received into the Catholic Church"

slot ascribed(Person: person, Church: church)
  means "ascribed(Person, Church): a recorded ascription to a Church sui iuris (latin, or an Eastern Church)"
  say "{Person} is ascribed to the {Church} Church"

slot father(Child: person, Father: person)
  means "father(Child, Father)"
  say "{Father} is the father of {Child}"

slot mother(Child: person, Mother: person)
  means "mother(Child, Mother)"
  say "{Mother} is the mother of {Child}"

slot agreed(Child: person, Church: church)
  means "agreed(Child, Church): both parents agree that the child be baptized in that Church (c. 111 §1; CCEO c. 29 §1)"
  say "the parents of {Child} agree that the child be baptized in the {Church} Church"

slot deacon(P: person)
  means "a deacon"
  say "{P} is a deacon"

slot faculty_to_confirm(P: person)
  means "a presbyter has the faculty to confirm, by universal law or special grant (c. 882)"
  say "the presbyter {P} has the faculty to confirm"

slot promulgated_elsewhere(Law: law, Date: date)
  means "promulgated_elsewhere(Law, Date): promulgated by another publication than the Acta (c. 8 §1)"
  say "{Law} was published outside the Acta on {Date}"

slot formal_defection(Person: person, Date: date)
  means "formal_defection(Person, Date): a formal act of defection (cc. 1086 §1, 1117, 1124, 1983-2009)"
  say "{Person} defected by a formal act on {Date}"

slot communion_at_issue(P: person)
  means "the case asks after the person's communion"
  say "the case asks after the communion of {P}"

use professes/4 "professes(Person, Act, Q, V): in the act the person publicly holds V on Q (faith.lp)"

use doubts/3 "doubts(Person, Act, Q): in the act the person publicly doubts the question"

use repudiates/3 "repudiates(Person, Act, christian_faith): an outward repudiation of the faith as a whole"

slot warned(Person: person, Act: act, By: category)
  means "warned(Person, Act, apostolic_see | ordinary): a warning given about the act"
  say "{Person} was warned about {Act} by the {By}"

slot retracted(Person: person, Act: act)
  means "retracted(Person, Act)"
  say "{Person} retracted {Act}"

use owed/2 "from the authority graph: the assent a canon attaches to a teaching act by reference (cc. 750, 752)"

use supports/3 "from the authority graph"

use law_kind/2 "law.lp: the kind of a law"

use interior/3 "act.lp: a claim about the agent (here, pertinacious)"

slot born_of_noncatholics(P: person)
  means "born of non-Catholic parents (CIC 1917 c. 1099 §2)"
  say "{P} was born of non-Catholic parents"

slot raised_outside(P: person)
  means "from infancy grew up in heresy, schism, unbelief or no religion (CIC 1917 c. 1099 §2)"
  say "{P} grew up from infancy outside the Church"

slot act_kind(Act: act, K: category)
  means "act_kind(Act, general_decree | general_executory_decree | instruction): the kind of an act (cc. 29, 31, 34)"
  say "the act {Act} is of the kind {K}"

slot executes(Act: act, Law: law)
  means "executes(Act, Law): the executive act was given to apply or clarify this law (cc. 31-34)"
  say "the act {Act} executes {Law}"

slot effective_from(Act: act, Date: date)
  means "effective_from(Act, Date): the date from which an executive act takes effect"
  say "the act {Act} takes effect from {Date}"

slot executive_power_only(Act: act)
  means "the act's issuer has executive power alone (c. 30)"
  say "the issuer of {Act} has executive power alone"

slot express_grant(Act: act)
  means "the competent legislator expressly granted the power to issue this general decree, its conditions observed (c. 30)"
  say "the legislator expressly granted the power to issue {Act}"

slot provision(Act: act, P: act)
  means "provision(Act, P): a provision of an executive act"
  say "{P} is a provision of {Act}"

slot contrary_provision(P: act, Law: law)
  means "contrary_provision(P, Law): the provision cannot be reconciled with the law (a juridical finding; cc. 33 §1, 34 §2)"
  say "the provision {P} cannot be reconciled with {Law}"

slot doc_at_issue(X: law)
  means "the case asks after the force of this body of texts or act"
  say "the case asks after the force of {X}"

slot collection(Body: law, Kind: category)
  means "collection(Body, private | authentic): a body gathering texts from other sources"
  say "{Body} is a {Kind} collection"

use attribution/3 "sources.lp: attribution(Text, Author, Claimant), a claim"

use attribution_refused/2 "sources.lp: the order refuses the attribution"

use celebration_date/2 "sacrament.lp: the date of a celebration a case records"

slot porrection(E: act)
  means "the instruments were handed over in the ordination (Florence, Exultate Deo, DH 1326)"
  say "in {E} the instruments were handed over"

slot alters(E: act, Part: rite_part)
  means "alters(E, Part): the minister added, omitted or altered a part of the rite that is not its form, on his own authority"
  say "in {E} the minister altered {Part} on his own authority"

slot indulgence(G: act, Kind: category, Date: date)
  means "indulgence(G, partial | plenary, Date): a grant of an indulgence"
  say "{G} grants a {Kind} indulgence on {Date}"

use in_days/2 "in_days(G, N): the grant designates its partial indulgence in days (or their equivalent)"

slot confirmed(G: act, Date: date)
  means "confirmed(G, Date): an older grant confirmed under Indulgentiarum doctrina's transitional norms"
  say "the grant {G} was confirmed on {Date}"

use doubt_one_or_more/2 "doubt_one_or_more(E, Date): a birth at which it is doubted whether one human being or several (CIC 1917 c. 748)"

slot born_together(E: event, Child: person)
  means "born_together(E, Child): a child of that birth, as the record names it"
  say "{Child} was born of the birth {E}"

```clingo

event_date(E,T) :- consecration(E,_,_,T).
event_date(A,T) :- absolution(A,_,_,T).
event_date(M,T) :- marriage(M,_,T).
event_date(E,T) :- act_date(E,T).
event_date(G,T) :- indulgence(G,_,T).
event_date(E,T) :- doubt_one_or_more(E,T).
eval_date(T) :- now(T).                         % the one clock (saeculum.lp)
past(E) :- event_date(E,TE), eval_date(T), TE <= T.
% the instants at which status is computed: each act's date, and the evaluation date
instant(T) :- event_date(_,T).
instant(T) :- eval_date(T).
instant(T) :- celebration_date(_,T).                % a sacrament's date, for the laws that bear on its validity
instant(D) :- narrows(L,_), promulgated(L,D).        % a narrowing law's day, on which c. 135 §2 tests it (rs2004:21)
instant(D) :- contrary_to_provision(L,_), promulgated(L,D).   % likewise a law contrary to a provision (cic:135)
% what the law asks of the calendar (c. 203): c. 8 §1's three months from
% an issue, or from each end of an unread issue's span; and completed years
months_asked(D,3)             :- aas_issue(_,D).
months_asked(G,3)             :- aas_volume(_,_,G).
months_asked(Y*10000+1231,3)  :- aas_volume(_,Y,_).
months_asked(D,3)             :- promulgated_elsewhere(_,D).
months_asked(D,1)             :- particular_law(L), promulgated(L,D), not vacatio_set(L,_).   % c. 8 §2's month
years_asked(B,T)              :- born(_,B), event_date(_,T), B <= T.
years_asked(B,T)              :- born(_,B), eval_date(T), B <= T.
issued(D) :- decree(D,_,TD), eval_date(T), TD <= T.
asserted(S,X) :- asserts(S,X,TS), eval_date(T), TS <= T.
% c. 965: only a priest absolves; a bishop has the priesthood
priest(P) :- bishop(P).

% Disputed facts: each is computed both ways, and the branch says which.
{ heard(D,P) } :- disputed(heard(D,P)), issued(D).
{ common_error(A) } :- disputed(common_error(A)).
{ appears_otherwise(P,E) } :- disputed(appears_otherwise(P,E)).
{ interpretation_form(A,law) } :- disputed(interpretation_form(A,law)).
{ equity_rule(M,R) } :- disputed(equity_rule(M,R)).
{ excluded_reading(L,R) } :- disputed(excluded_reading(L,R)).
{ declaratory(A) } :- disputed(declaratory(A)), interpretation_form(A,law).
{ necessary_assistance(P,A) } :- disputed(necessary_assistance(P,A)).
{ issuer(D,A) } :- disputed(issuer(D,A)).
{ penal_use(L) } :- disputed(penal_use(L)).
assumed_fact(F)      :- disputed(F), F = penal_use(L), penal_use(L).
assumed_fact(false(F)) :- disputed(F), F = penal_use(L), not penal_use(L).
assumed_fact(F)      :- disputed(F), F = declaratory(A), interpretation_form(A,law), declaratory(A).
assumed_fact(false(F)) :- disputed(F), F = declaratory(A), interpretation_form(A,law), not declaratory(A).
assumed_fact(F)      :- disputed(F), F = necessary_assistance(P,A), necessary_assistance(P,A).
assumed_fact(false(F)) :- disputed(F), F = necessary_assistance(P,A), not necessary_assistance(P,A).
assumed_fact(F)      :- disputed(F), F = issuer(D,A), issuer(D,A).
assumed_fact(false(F)) :- disputed(F), F = issuer(D,A), not issuer(D,A).
assumed_fact(F)      :- disputed(F), F = interpretation_form(A,law), interpretation_form(A,law).
assumed_fact(false(F)) :- disputed(F), F = interpretation_form(A,law), not interpretation_form(A,law).
assumed_fact(F)      :- disputed(F), F = excluded_reading(L,R), excluded_reading(L,R).
assumed_fact(false(F)) :- disputed(F), F = excluded_reading(L,R), not excluded_reading(L,R).
assumed_fact(F)      :- disputed(F), F = heard(D,P), issued(D), heard(D,P).
assumed_fact(false(F)) :- disputed(F), F = heard(D,P), issued(D), not heard(D,P).
assumed_fact(F)      :- disputed(F), F = common_error(A), common_error(A).
assumed_fact(false(F)) :- disputed(F), F = common_error(A), not common_error(A).
assumed_fact(F)      :- disputed(F), F = appears_otherwise(P,E), appears_otherwise(P,E).
assumed_fact(false(F)) :- disputed(F), F = appears_otherwise(P,E), not appears_otherwise(P,E).

% The Churches sui iuris a case may name (data; the list is not complete),
% and the Eastern Churches not in full communion (TTC-CCEO).
eastern_church((ukrainian;ruthenian;maronite;melkite;syro_malabar;syro_malankara;chaldean;coptic_catholic;romanian;armenian_catholic)).
eastern_noncatholic_church((orthodox_church;oriental_orthodox_church)).
% De concordia inter Codices (31 May 2016), promulgated in L'Osservatore Romano
% (the edition of 16 September 2016), then in the Acta, AAS 108 (2016), the
% issue unread. It names no date of force.
promulgated(dc2016,20160531). promulgated_elsewhere(dc2016,20160916). aas_volume(dc2016,2016,20160531).
enacted_by(c1108_3_text,dc2016). part_of(n1108_3,c1108_3_text).

% The form of marriage in its texts (TTC-SOURCES TX). The Code of 1917, given on
% Pentecost, 27 May 1917 (Providentissima Mater Ecclesia), binding "a die
% decima nona mensis Maii anni millesimi nongentesimi duodevicesimi" (AAS 9/II):
% c. 1094 (the form) and c. 1099 (who is bound). Pius XII struck the clause of
% c. 1099 §2 on those born of non-Catholics (motu proprio Decretum Ne temere,
% 1 August 1948; AAS 40 (1948) 305-306), from 1 January 1949.
promulgated(code1917,19170527). vacatio_set(code1917,19180519).
enacted_by(form_text_1917,code1917). part_of(n1094_1917,form_text_1917).
enacted_by(c1099_2_clause_1917,code1917). part_of(n1099_2_1917,c1099_2_clause_1917).
promulgated(pxii1948,19480801). vacatio_set(pxii1948,19490101).
% The Code of 1983: c. 1108 §1 with c. 1111; c. 1117 with its clause on formal
% defection until Omnium in mentem.
enacted_by(form_text_1983,code1983). part_of(n1108_1,form_text_1983).
enacted_by(c1117_text_1983,code1983). part_of(n1117_1983,c1117_text_1983).

% An instruction and the law it executes (TTC-SOURCES GN4). Summorum Pontificum
% (7 July 2007), "observed from the fourteenth day of September"; Universae
% Ecclesiae (30 April 2011), "hanc Instructionem edit, ad normam canonis 34"
% (n. 12); Traditionis custodes (16 July 2021), promulgated in L'Osservatore
% Romano, "eodem die vim obtinentes".
promulgated(sp2007,20070707). vacatio_set(sp2007,20070914). enacted_by(sp_text,sp2007).
act_kind(ue2011,instruction). executes(ue2011,sp2007). effective_from(ue2011,20110430).
promulgated(tc2021,20210716). vacatio_set(tc2021,20210716).

% The penal norms, the bodies they belong to, and the laws that enacted them.
promulgated(code1983,19830125). vacatio_set(code1983,19831127).     % Sacrae disciplinae leges: the First Sunday of Advent
promulgated(pgd2021,20210601).  vacatio_set(pgd2021,20211208).      % Pascite gregem Dei, art. 2: Book VI revised
enacted_by(book6_1983,code1983). enacted_by(book6_2021,pgd2021).
part_of(n1382_1983,book6_1983). part_of(n1364_1983,book6_1983).
part_of(n1387,book6_2021). part_of(n1364,book6_2021). part_of(n1379,book6_2021). part_of(n1386,book6_2021).
part_of(n1365,book6_2021).
part_of(n1398_1983,book6_1983). part_of((n1397;n1398_1;n1399),book6_2021).
% each of these canons says "latae sententiae": 1983 cc. 1382, 1364 §1, 1398;
% 2021 cc. 1387, 1364 §1, 1379 §1, 1386 §1, 1397 §2
latae_sententiae(n1382_1983;n1364_1983;n1387;n1364;n1379;n1386;n1398_1983;n1397).
% Abortion: the term's readings (c. 17), and the authentic interpretation of
% 1988 (c. 16 §2): extensive, on the canonists' common reading and on its own
% text (asked whether abortion is only the expulsion of the immature fetus, it
% answers "Negative"), so not declaratory and not retroactive (TTC-PENAL AB8).
reading_option(abortion,expulsion). reading_option(abortion,killing). narrower(expulsion,killing).
penal_use(abortion).
needs_reading(abortion,A) :- killing_of_unborn(A), event_date(A,_).
applies_reading(pclt1988,abortion,killing). issuer(pclt1988,john_paul_ii). authority(john_paul_ii,4).
interpretation_form(pclt1988,law).
promulgated(pclt1988,19880523). aas_volume(pclt1988,1988,19880523).  % AAS 80 (1988) 1818-1819, the issue's date unread (c. 8 §1)
% c. 1371 n. 1: the Code's text until Ad tuendam fidem, the amended text until Pascite gregem Dei
promulgated(atf1998,19980518). aas_volume(atf1998,1998,19980518).   % names no date; AAS 90 (1998) 457-461, the issue's date unread (c. 8 §1)
enacted_by(c1371_text_1983,code1983). enacted_by(c1371_text_1998,atf1998).
part_of(n1371_1983,c1371_text_1983). part_of(n1371_1998,c1371_text_1998).
% c. 751: one act, or a lasting state? Its reading decides schism.
reading_option(c751,act_suffices). reading_option(c751,lasting_state).
narrower(lasting_state,act_suffices).
needs_reading(c751,E) :- consecration(E,_,_,_), against_explicit_papal_will(E).
% c. 1321 §4: does the presumption reach mere imputability, the source (dolus
% or culpa) then to be found in the acts, or dolus itself, as CIC/17 c. 2200
% §2 had it? No authentic interpretation: both are read (rule 2), once, and
% only where it decides something (TTC-REPAIRS2 CI1).
reading_option(c1321_4,presumes_imputability).
reading_option(c1321_4,presumes_dolus).
% Whether c. 18 reaches §4 itself: since 2021 §4 stands as an exception to
% §1's presumption of innocence, and it is odious to the accused. Disputed,
% and computed both ways wherever §4's reading is asked (TTC-REPAIRS3 SI1).
narrower(presumes_imputability,presumes_dolus).
disputed(penal_use(c1321_4)) :- needs_reading(c1321_4,all).
% c. 1325: what gross ignorance supplies, read three ways, once, where it
% attends a delict: nothing (a bar to cc. 1323-1324 only); dolus for all three
% kinds; or dolus for affected ignorance, directly willed, and culpa for crass
% or supine, indirectly willed (ST I-II q. 6 a. 8; TTC-REPAIRS3 IG1).
reading_option(c1325,bar_only).
reading_option(c1325,as_dolus).
reading_option(c1325,affected_as_dolus).
needs_reading(c1325,all) :- gross_ignorance(P,E,_), delict(P,_,E).
needs_reading(c1321_4,all) :- unsourced_latae(_,_,_).
% c. 915: "manifest grave sin", objectively or subjectively? The Pontifical
% Council's declaration (24 June 2000) applies the objective reading; it is not
% an authentic interpretation (c. 16 §1; Pastor bonus art. 155). Whether the
% subjective reading is admissible at all is disputed.
reading_option(c915,objective). reading_option(c915,subjective).
narrower(subjective,objective).
applies_reading(pclt2000,c915,objective). issuer(pclt2000,pclt). authority(pclt,3).
disputed(excluded_reading(c915,subjective)) :- needs_reading(c915,_).
needs_reading(c915,S) :- situation(_,S), manifest(S), persisting(S).
% c. 1248 §1: "in the evening of the preceding day". From noon (Browne,
% Letter & Spirit (1995) 702; Peters, canonlaw.info, 30 November 2008), or
% from two in the afternoon; no authentic interpretation. The obligation of
% c. 1247, as c. 1248 §1 measures it, reaches less on the first. A Mass
% between the two hours needs a reading; c. 14 gives it (TTC-CALENDAR CO2).
evening_from(evening_from_noon,1200).
evening_from(evening_from_two,1400).
reading_option(c1247,R) :- evening_from(R,_).
narrower(evening_from_noon,evening_from_two).
obliging(c1247).
needs_reading(c1247,M) :- on_the_eve(M,_), evening_possible(M), not evening_certain(M).

% ---------- Book I: general norms ------------------------------------------
```

norm cic:7 | c. 7: a law is established when it is promulgated; c. 8 §1: universal laws are promulgated in the Acta Apostolicae Sedis and take force only after three months have elapsed from the date of that issue, unless they bind at once from the nature of the matter or the law sets a shorter or longer vacatio | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

```clingo
% The issue's date counts as a whole day (c. 203 §1, its beginning the
% day's): the months end at the close of the day before the day of the same
% number, and the law binds from that day. So a canonist computes Omnium in
% mentem, issue of 8 January 2010, in force 8 April 2010 (TTC-SAECULUM CT1).
in_force_from(L,T) :- promulgated(L,_), vacatio_set(L,T), not void_decree(L).
in_force_from(L,T) :- aas_issue(L,D), not vacatio_set(L,_), same_number_after(D,3,T), not void_decree(L).
% An issue unread lies between the act's own date and its volume's last
% day; force, between three months after each. Inside that span the date
% is a fact not fixed by the record, computed both ways (rule 2; CT3).
force_window(L,T1,T2) :- aas_volume(L,Y,G), not aas_issue(L,_), not vacatio_set(L,_), not in_force_from(L,_), not void_decree(L),
                         same_number_after(G,3,T1), same_number_after(Y*10000+1231,3,T2).
% A law promulgated otherwise than in the Acta ("unless another manner of
% promulgation has been prescribed"): its three months run from that
% publication, or from the issue of the Acta? One canonist reads the first
% (De concordia inter Codices, in force 16 December 2016); no authentic
% interpretation settles it, so where the readings differ on a date the case
% needs, the reading is disputed and computed both ways (rule 2; TTC-CCEO IM1).
elsewhere_dates(L,TP,W1,W2) :- promulgated_elsewhere(L,D), aas_volume(L,Y,G), same_number_after(D,3,TP), not void_decree(L),
                               same_number_after(G,3,W1), same_number_after(Y*10000+1231,3,W2).
reading_needed_c8(L) :- elsewhere_dates(L,TP,_,W2), instant(T), TP <= T, T < W2.
reading_needed_c8(L) :- elsewhere_dates(L,TP,W1,_), instant(T), W1 <= T, T < TP.
{ from_acta(L) } :- reading_needed_c8(L).
in_force_from(L,TP) :- elsewhere_dates(L,TP,_,_), not from_acta(L).
assumed_fact(reading(c8_elsewhere,L,from_acta))        :- from_acta(L).
assumed_fact(reading(c8_elsewhere,L,from_publication)) :- reading_needed_c8(L), not from_acta(L).
has_force_date(L) :- in_force_from(L,_).
has_force_date(L) :- force_window(L,_,_).
force_at(L,T) :- in_force_from(L,F), instant(T), F <= T.
force_at(L,T) :- force_window(L,_,T2), instant(T), T2 <= T.
{ force_at(L,T) } :- force_window(L,T1,T2), instant(T), T1 <= T, T < T2.
:- force_at(L,T), instant(T2), T < T2, not force_at(L,T2).      % once in force, in force after
assumed_fact(force_by(L,T))        :- force_window(L,T1,T2), instant(T), T1 <= T, T < T2, force_at(L,T).
assumed_fact(false(force_by(L,T))) :- force_window(L,T1,T2), instant(T), T1 <= T, T < T2, not force_at(L,T).
norm_in_force(N,T) :- part_of(N,B), enacted_by(B,L), force_at(L,T), event_date(_,T), not abrogated_at(B,T).
abrogated_at(B,T)  :- revokes(L2,B,_), force_at(L2,T).

```

norm cic:8 | c. 8 §2: particular laws are promulgated in the manner determined by the legislator and begin to oblige a month after the day of promulgation unless the law itself establishes another time | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

slot particular_law(Law: law)
  means "particular_law(Law): a law given for a particular territory or community (c. 13), promulgated as its legislator determines (c. 8 §2)"
  say "{Law} is a particular law"

```clingo
% A month from the day of promulgation, counted as c. 8 §1's three months
% are: the day counts whole, and the law binds from the day of the same
% number, or the first of the next month where the month lacks it (c. 203;
% CT5). A law that sets its own time keeps it (vacatio_set, c. 7 above).
in_force_from(L,T) :- particular_law(L), promulgated(L,D), not vacatio_set(L,_), not aas_issue(L,_),
                      same_number_after(D,1,T), not void_decree(L).

```

norm cic:203 | cc. 200-203: time is computed by these canons unless the law provides otherwise; a day is 24 hours from midnight, continuous months and years as in the calendar (c. 202); the day a quo is not counted unless its beginning coincides with the beginning of the day; a term of months or years ends at the close of the last day of the same number or, if the month lacks it, of the last day of the month (c. 203) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann200-203_en.html

```clingo
% The day of the same number N calendar months after D; where the month
% lacks it, its term closes with the month and the next day is the first.
cal_year(Y2) :- months_asked(D,N), Y2 = D/10000 + ((D/100)\100 - 1 + N)/12.
same_number_after(D,N,R) :- months_asked(D,N), M2 = (D/100)\100 - 1 + N, Y2 = D/10000 + M2/12, M3 = M2\12 + 1,
                            days_in(Y2,M3,L), D\100 <= L, R = Y2*10000 + M3*100 + D\100.
same_number_after(D,N,R) :- months_asked(D,N), M2 = (D/100)\100 - 1 + N, Y2 = D/10000 + M2/12, M3 = M2\12 + 1,
                            days_in(Y2,M3,L), D\100 > L, R = Y2*10000 + (M3+1)*100 + 1.   % never December, which lacks no day
% Years completed at a date: the day of birth is not counted (birth does
% not begin with the day), and a year closes with the day of the same
% number; on the birthday itself it is not yet completed. One born on 29
% February completes a year in a common year at the close of 28 February.
completed_years(B,T,N) :- years_asked(B,T), T\10000 <= B\10000, N = T/10000 - B/10000 - 1.
completed_years(B,T,N) :- years_asked(B,T), T\10000 >  B\10000, N = T/10000 - B/10000.

```

norm cic:97 | c. 97 §1: one who has completed the eighteenth year of age is an adult; below this age, a minor; ages are counted under c. 203 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html

```clingo
age_at(P,A,N) :- born(P,B), event_date(A,T), completed_years(B,T,N).
age_now(P,N)  :- born(P,B), eval_date(T), completed_years(B,T,N).

```

norm cic:6 | c. 6 §1: when this Code takes force, the following are abrogated: 1° the Code of Canon Law promulgated in 1917; 2° other universal or particular laws contrary to its prescripts, unless other provision is expressly made for particular laws; 3° universal or particular penal laws of the Apostolic See not contained in it; 4° other universal disciplinary laws on matter it completely reorders; §2: insofar as they repeat former law, its canons are assessed also in accord with canonical tradition | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann1-6_en.html

```clingo
revokes(code1983,B,expressly) :- enacted_by(B,code1917).

```

norm cic:20 | c. 20: a later law abrogates or derogates from an earlier one if it says so expressly, is directly contrary to it, or completely reorders the entire matter of the earlier law | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

slot directly_contrary(Later: law, Body: law)
  means "directly_contrary(Later, Body): the later law and the body cannot both stand (a juridical finding)"
  say "{Later} and {Body} cannot both stand"

```clingo
% Three ways, one fact each (TTC-SOURCES GN2). A way open to doubt yields to
% c. 21: in doubt the revocation is not presumed, so the earlier text stays in
% force and nothing branches.
revokes(L2,B,reorders) :- reorders(L2,B), not doubtful_revocation(L2,B).
revokes(L2,B,contrary) :- directly_contrary(L2,B), not doubtful_revocation(L2,B).
reorders(pgd2021,book6_1983).                                       % Pascite gregem Dei: Book VI anew
reorders(pgd2021,c1371_text_1998).
revokes(atf1998,c1371_text_1983,expressly).                         % Ad tuendam fidem: c. 1371 n. 1 to read so
revokes(oim2009,c1117_text_1983,expressly).                         % Omnium in mentem: the clause on formal defection removed
revokes(pxii1948,c1099_2_clause_1917,expressly).                    % Decretum Ne temere (1948)
directly_contrary(tc2021,sp_text).   % art. 1 of each: "the unique expression of the lex orandi" against an extraordinary one

```

norm cic:21 | c. 21: in doubt the revocation of a pre-existing law is not presumed, but later laws are related to earlier ones and, insofar as possible, harmonized with them | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

```clingo
info(revocation_not_presumed(L2,L)) :- doubtful_revocation(L2,L).

```

norm cic:29 | c. 29: general decrees, by which a competent legislator issues common prescripts for a community capable of receiving law, are laws properly speaking, governed by the canons on laws; c. 30: one who possesses only executive power cannot issue such a decree unless, in particular cases, a competent legislator has expressly granted it and the conditions of the grant are observed | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann29-34_en.html

```clingo
% A general decree is a law and takes force by c. 8 §1; given by executive
% power alone without the grant, it is void and takes none (TTC-SOURCES GN6).
void_decree(D) :- act_kind(D,general_decree), executive_power_only(D), not express_grant(D).
violation(general_decree_without_power(D)) :- void_decree(D).

```

norm cic:33 | c. 33 §1: general executory decrees do not derogate from laws, and their prescripts contrary to laws lack all force; §2: they cease with the cessation of the law for whose execution they were given; c. 34 §2: the ordinances of instructions do not derogate from laws, and those that cannot be reconciled with them lack all force; §3: instructions cease also by the cessation of the law for whose clarification or execution they were given | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann29-34_en.html

```clingo
% An executive act stands below the law it executes: in force from its date
% while the law stands, a provision contrary to a law without force (GN4, GN5).
executive_act(A) :- act_kind(A,general_executory_decree).
executive_act(A) :- act_kind(A,instruction).
law_ceased(L,T)    :- enacted_by(B,L), abrogated_at(B,T).
exec_ceased(A,T)   :- executive_act(A), executes(A,L), law_ceased(L,T).
exec_in_force(A,T) :- executive_act(A), effective_from(A,D), instant(T), D <= T, not exec_ceased(A,T).
provision_in_force(P,T) :- provision(A,P), exec_in_force(A,T), not contrary_provision(P,_).

```

norm collections | Gregory IX, Rex pacificus (5 September 1234): "ut hac tantum compilatione universi utantur in iudiciis et in scholis": an authentic collection's texts have force from its promulgation, whatever their origin; a private collection's texts (Gratian's Decretum, never recognized as an official collection) have their sources' authority and no more; custom is a route of its own (cc. 23-28) | https://www.iuscangreg.it/diritto_anteriore.php

```clingo
% A text's force in a private collection rests on its attribution, a claim
% (sources.lp); refused by the order, the text has no force of its own. In an
% authentic collection the attribution changes nothing (TTC-SOURCES CO1).
from_promulgation(N,L)          :- part_of(N,B), collection(B,authentic), enacted_by(B,L).
rests_on_attribution(N,A)       :- part_of(N,B), collection(B,private), attribution(N,A,_), not attribution_refused(N,A).
without_force_of_its_own(N,B)   :- part_of(N,B), collection(B,private), attribution(N,A,_), attribution_refused(N,A).
```

end

```clingo
info(force_from_promulgation(N,L))    :- from_promulgation(N,L).
info(force_rests_on_attribution(N,A)) :- rests_on_attribution(N,A).
info(without_force_of_its_own(N,B))   :- without_force_of_its_own(N,B).
info(text_in_force(B))  :- doc_at_issue(B), enacted_by(B,L), eval_date(T), force_at(L,T), not abrogated_at(B,T).
info(text_of_void_decree(B,D)) :- doc_at_issue(B), enacted_by(B,D), void_decree(D).
info(text_revoked(B,L2,W)) :- doc_at_issue(B), revokes(L2,B,W), eval_date(T), force_at(L2,T).
info(act_in_force(A))   :- doc_at_issue(A), exec_in_force(A,T), eval_date(T).
info(ceased_with_law(A,L)) :- doc_at_issue(A), executes(A,L), exec_ceased(A,T), eval_date(T).
info(provision_in_force(P))   :- provision(A,P), doc_at_issue(A), provision_in_force(P,T), eval_date(T).
info(provision_without_force(P,L)) :- provision(A,P), executive_act(A), contrary_provision(P,L).

```

norm cic:16 | c. 16 §§1-3: the legislator interprets authentically; in the form of law the interpretation has the force of law and must be promulgated; if it only declares words certain in themselves it is retroactive, if it restricts, extends or explains a doubtful law it is not; in a sentence or an administrative act in a particular matter it binds only the persons and matters for which it was given; with c. 9: laws regard the future, not the past, unless they expressly provide for the past | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

slot declaratory(A: act)
  means "c. 16 §2: the interpretation only declares words of the law certain in themselves (so retroactive)"
  say "the interpretation {A} only declares words certain in themselves"

```clingo
authentic_reading(N,R,D) :- applies_reading(D,N,R), issuer(D,A), authority(A,4).
interpretation_form(A,particular) :- authentic_reading(_,_,A), not interpretation_form(A,law).
% In the form of law it reaches the acts placed from its force on (c. 8 §1),
% and an earlier act only where it is declaratory: the past is the exception
% (c. 9). A lasting situation with no date of its own is judged now.
% (TTC-PENAL AB8: the dates were recorded, never compared.)
dated(E) :- event_date(E,_).
reaches_act(A,E) :- force_at(A,T), needs_reading(_,E), event_date(E,T).
reaches_act(A,E) :- force_at(A,T), needs_reading(_,E), not dated(E), eval_date(T).
reaches_act(A,E) :- has_force_date(A), needs_reading(_,E), not dated(E), not has_eval_date.   % no clock: the present
has_eval_date :- eval_date(_).
reaches_act(A,E) :- declaratory(A), needs_reading(_,E).
reading_binds(N,R,E) :- authentic_reading(N,R,A), interpretation_form(A,law), needs_reading(N,E), reaches_act(A,E).
reading_binds(N,R,E) :- authentic_reading(N,R,A), interpretation_form(A,particular), particular_matter(A,E), needs_reading(N,E).
info(not_retroactive(A,E)) :- authentic_reading(N,_,A), interpretation_form(A,law), needs_reading(N,E), not reaches_act(A,E).
% So of a superior's decision on recourse (c. 1739): it reaches no other law,
% though that law narrow the same matter (TTC-REPAIRS RD2).
info(not_reached_by(L2,D)) :- decision_on_recourse(D,L,_), narrows(L,M), narrows(L2,M), L2 != L.
violation(interpretation_without_force(A)) :- authentic_reading(_,_,A), interpretation_form(A,law), not has_force_date(A).
authentically_read(N,E) :- reading_binds(N,_,E).
read_for(N,R,E) :- reading_binds(N,R,E).
% So of every law, not only of an interpretation: it binds an act placed
% while it is in force (c. 9), not one placed before its force begins
% (cc. 7-8), nor one placed after its text is revoked (c. 20). A law with no
% date of force entered is not computed here. (TTC-LAW WB3: binds_on/2 read
% the reading and the reach, never the date; found on a diocesan decree.)
out_of_force_for(L,X) :- event_date(X,T), has_force_date(L), not force_at(L,T).
out_of_force_for(B,X) :- event_date(X,T), enacted_by(B,L), has_force_date(L), not force_at(L,T).
out_of_force_for(B,X) :- event_date(X,T), abrogated_at(B,T).

```

norm cic:17 | c. 17: laws are understood by the proper meaning of their words in text and context; if the meaning remains doubtful, by parallel places, purpose and circumstances, and the mind of the legislator | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

```clingo
% A disputed reading with no authentic interpretation branches (rule 2). The
% mind of the supreme legislator is presumed in harmony with the higher law:
% a reading on which his law contradicts it is excluded. A lower legislator's
% law keeps that reading, and on it does not bind (c. 135 §2; ST I-II q. 96 a. 4).
supreme_law(L) :- legislator(L,A), authority(A,4).
excluded_reading(L,R) :- reading_contrary(L,R,H), higher(H,L), supreme_law(L).
1 { read_for(L,R,E) : admissible(L,R) } 1 :- needs_reading(L,E), not authentically_read(L,E).

```

norm cic:18 | c. 18: laws which establish a penalty, restrict the free exercise of rights, or contain an exception are subject to strict interpretation | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

slot penal_use(L: canon)
  means "the law's terms set a penalty (or make an exception)"
  say "the terms of {L} set a penalty"

slot restricts_rights(L: canon)
  means "the law restricts the free exercise of a right"
  say "{L} restricts the free exercise of a right"

```clingo
strict(L) :- penal_use(L).
strict(L) :- restricts_rights(L).
:- read_for(L,R,E), strict(L), not authentically_read(L,E), admissible(L,R2), narrower(R2,R).
penal_use(c751).                                   % c. 1364 punishes the schismatic
info(declined_by_strict_interpretation(L,R,E)) :- needs_reading(L,E), strict(L), not authentically_read(L,E),
                                                  admissible(L,R), admissible(L,R2), narrower(R2,R).

```

norm cic:14 | c. 14: laws, even invalidating and disqualifying ones, do not oblige when there is a doubt about the law; in a doubt of fact ordinaries can dispense | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

```clingo
:- read_for(L,R,E), doubt_binds_strictly(L), not authentically_read(L,E), admissible(L,R2), narrower(R2,R).
doubt_binds_strictly(L) :- invalidating(L).
doubt_binds_strictly(L) :- obliging(L).
% The narrowing is said, as c. 18's is (TTC-CALENDAR CO2: it was silent).
info(declined_in_doubt_of_law(L,R,E)) :- needs_reading(L,E), doubt_binds_strictly(L), not authentically_read(L,E),
                                         admissible(L,R), admissible(L,R2), narrower(R2,R).
doubt_of_fact(L,X) :- fact_for(L,X,F), disputed(F).
info(ordinary_may_dispense(L,X)) :- doubt_of_fact(L,X), dispensable(L).

```

norm cic:19 | c. 19: where custom and express law are lacking, a case, unless it is penal, is resolved by laws in similar matters, general principles applied with canonical equity, the jurisprudence and practice of the Roman Curia, and the common opinion of the learned | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

```clingo
resolved_by(M,R) :- lacuna(M), equity_rule(M,R), not penal_matter(M).
violation(penalty_without_law(M)) :- lacuna(M), penal_matter(M), equity_rule(M,_).

```

norm cic:85 | c. 85: dispensation relaxes a merely ecclesiastical law in a particular case; c. 86: laws defining what essentially constitutes an institute or juridic act are not subject to dispensation | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann85-93_en.html

```clingo
dispensable(L) :- law_kind(L,ecclesiastical), not defines_essentials(L).
dispensed(L,X) :- dispensation(_,L,X), dispensable(L).
violation(dispensing_divine_law(D,L))  :- dispensation(D,L,_), divine_law(L).
violation(dispensing_essentials(D,L))  :- dispensation(D,L,_), defines_essentials(L).
```

end

-- Results this layer computes (TTC-L, SY): what ttc-say(1) says of them

result reading_excluded(L: canon, R: reading)
  say "the reading {R} of {L} is excluded"

result excluded_reading(L: canon, R: reading)
  say "the reading {R} of {L} is excluded"

result presumption_read(R: reading)
  say "c. 1321 §4 is read as {R}"

result c1325_read(R: reading)
  say "c. 1325 is read as {R}"

result no_formal_delict(P: person, E: act)
  say "the subjective element is absent: {P}'s external violation in {E} is no delict in the formal sense"

result delict_stands_exempt(P: person, E: act)
  say "{P}'s delict in {E} stands, and the law exempts it from the penalty (c. 1323)"

result aggravated(P: person, E: act, W: category)
  say "{P}'s delict in {E} is aggravated ({W}): a more serious punishment is due (c. 1326 §1)"

result voluntary_in_cause(P: person, E: act)
  say "{P}'s deed in {E}, done without the use of reason, is voluntary in its cause: the lack of reason was brought on culpably or sought (c. 1323 n. 6, reserved)"

result source_not_established(P: person, N: norm, E: act)
  say "no source of imputability (dolus or culpa) is established for {P} in {E}, so on this reading of c. 1321 §4 the penalty of {N} is not incurred"

result effect_from_decree_date(D: act)
  say "no notification of {D} is entered for someone it names: the effect is dated from the decree (c. 54 §1)"

result no_recourse_against_papal_act(D: act)
  say "{D} is the Roman Pontiff's own act: no recourse lies against it (c. 333 §3)"

result no_further_recourse(D: act)
  say "{D} decides a recourse in a reserved delict: no further recourse lies (SST art. 24 §1)"

result permitted(X: entity, L: law)
  say "{L} permits {X}"

result obliged(X: entity, L: law)
  say "{X} is bound by {L}"

result invalid(X: entity, L: law)
  say "{X} is invalid under {L}"

result dispensed(L: law, X: entity)
  say "{X} is dispensed from {L}"

result declined_by_strict_interpretation(L: canon, R: reading, E: entity)
  say "read strictly (c. 18), {L} is not given the wider reading {R} in {E}"

result narrows_higher_choice(L: law, H: law, G: ground)
  say "{L} narrows a choice {H} leaves open, against higher ius ({G})"

result against_higher_provision(L: law, P: act)
  say "{L} is contrary to {P}, a higher authority's provision that had force when the law was given (c. 135 §2)"

result provision_without_force_on_the_day(L: law, P: act)
  say "{L} is not tested against {P}: that provision had no force on the day the law was given (cc. 33-34)"

result provision_in_force(P: act)
  say "{P} is in force"

result provision_without_force(P: act, L: law)
  say "{P} lacks force: it cannot be reconciled with {L} (c. 34 §2)"

result act_in_force(A: act)
  say "{A} is in force"

result ceased_with_law(A: act, L: law)
  say "{A} ceased with {L}, the law it executed (cc. 33 §2, 34 §3)"

result text_in_force(B: law)
  say "{B} is in force as a text"

result text_revoked(B: law, L: law, W: category)
  say "{B} is revoked by {L} ({W})"

result narrows_own_choice(L: law, H: law)
  say "{L} exercises a choice that {H} leaves to the law's own legislator, rather than contradicting higher ius"

result regulates_right(L: law, M: category)
  say "{L} directs the exercise of a right of the faithful in {M} for the common good, and so is not against higher ius (c. 223 §2)"

result confirmed_on_recourse(L: law, D: act)
  say "{L} was confirmed on recourse by {D}, a higher authority's decision (c. 1739)"

result not_reached_by(L2: law, D: act)
  say "{L2} is not reached by {D}, a decision given in another matter (c. 16 §3)"

result revocation_not_presumed(L2: law, L: law)
  say "{L2} is not taken to revoke {L}: revocation is not presumed (c. 21)"

result contrary_provision_undated(L: law)
  say "{L} has no day of promulgation entered, so it is not tested against the provision it contradicts"

result narrowing_without_ground(L: law)
  say "{L} narrows a choice a higher law leaves open, but no ground in force on its day is encoded"

result declined_in_doubt_of_law(L: canon, R: reading, E: entity)
  say "in a doubt of law (c. 14), {L} is not given the wider reading {R} in {E}"

result day_celebration(D: date, C: celebration)
  say "the celebration of {D} is {C} (GNLY 60)"

result omitted(D: date, C: celebration)
  say "{C} is omitted on {D} (GNLY 60)"

result may_be_kept(D: date, C: celebration)
  say "{C} may be kept on {D} (GNLY 14; the Table, no. 12)"

result impeded_solemnity(D: date, C: celebration)
  say "{C}, a Solemnity, is impeded on {D}; its transfer (GNLY 60) is not encoded"

result begins_evening_before(C: celebration, P: date)
  say "{C} begins on the evening of {P} (GNLY 3)"

result vespers_of(P: date, C: celebration)
  say "Evening Prayer on {P} is of {C} (GNLY 61)"

result vigil_mass_not_used(M: entity, C: celebration)
  say "{M}, an evening Mass on the eve of {C}, is not its Vigil Mass (GNLY 11)"

result meets_obligation(M: entity, D: date)
  say "{M} meets the obligation of {D} (c. 1248 §1)"

result satisfies_obligation(P: person, D: date, M: entity)
  say "assisting at {M}, {P} satisfies the obligation of {D} (c. 1248 §1)"

label c135_2 "c. 135 §2"

label c1247 "cc. 1247-1248 §1"

label evening_from_noon "evening from noon"

label evening_from_two "evening from 2 p.m."

label rs21 "RS 21"

```clingo
info(reading_excluded(L,R))  :- excluded_reading(L,R).
info(does_not_bind(L))       :- does_not_bind(L).
info(permitted(X,L))         :- permits(L), binds_on(L,X).
info(obliged(X,L))           :- obliging(L), binds_on(L,X).
info(invalid(X,L))           :- invalidating(L), binds_on(L,X).
info(resolved_by(M,R))       :- resolved_by(M,R).
info(dispensed(L,X))         :- dispensed(L,X).

```

norm cic:135 | c. 135 §2: a lower authority cannot validly act contrary to a higher one | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann129-144_en.html

```clingo
higher(H,L) :- law_kind(H,ecclesiastical), law_kind(L,ecclesiastical), legislator(H,AH), legislator(L,AL),
               authority(AH,KH), authority(AL,KL), KH > KL.
% "Lex iuri superiori contraria": the lower act must be a law, but the
% measure is ius, which includes a higher authority's executive norms. A
% diocesan bishop "could not validly enact a law contrary to a provision of
% an instruction of the Roman Curia" (Huels, StC 32 (1998) 360 n. 77, citing
% Labandeira; Worship 74 (2000) 126 n. 24; Liturgy and Law (2006) 47). The
% force is borrowed: a provision counts only while it has force, reconciled
% with the law (c. 34 §2) and its law not ceased (§3), tested on the day the
% lower law is promulgated (LW12; found in discussion, 20 October 2026).
higher(P,L) :- provision(A,P), executive_act(A), issuer(A,AH), law_kind(L,ecclesiastical), legislator(L,AL),
               authority(AH,KH), authority(AL,KL), KH > KL.
contrary(L,P) :- contrary_to_provision(L,P), promulgated(L,D), provision_in_force(P,D).
info(against_higher_provision(L,P)) :- contrary_to_provision(L,P), promulgated(L,D), provision_in_force(P,D), higher(P,L).
info(provision_without_force_on_the_day(L,P)) :- contrary_to_provision(L,P), provision(_,P), promulgated(L,D), instant(D),
                                                not provision_in_force(P,D).
frontier(canon,contrary_provision_undated(L)) :- contrary_to_provision(L,_), not promulgated(L,_).
contrary(L,H) :- contrary_to_law(L,H).
competent_revocation(R,G) :- revocation(R,G,_), issuer(R,A1), issuer(G,A2), authority(A1,K1), authority(A2,K2), K1 >= K2.
violation(ineffective_revocation(R,G)) :- revocation(R,G,_), not competent_revocation(R,G).

```

norm rs2004:21 | Redemptionis Sacramentum 21 (2004), with c. 838 §4: within the limits of his competence the diocesan bishop issues liturgical norms by which all are bound; still, he must take care not to allow the removal of that liberty foreseen by the norms of the liturgical books | https://www.vatican.va/roman_curia/congregations/ccdds/documents/rc_con_ccdds_doc_20040423_redemptionis-sacramentum_en.html

slot option_of(Law: law, Matter: category, Holder: category)
  means "option_of(Law, Matter, Holder): the law leaves the choice in Matter to Holder (a liturgical book's choice left to the celebrant)"
  say "{Law} leaves the choice in {Matter} to {Holder}"

slot narrows(Law: law, Matter: category)
  means "narrows(Law, Matter): the law limits, reserves or removes the choice in Matter"
  say "{Law} narrows the choice in {Matter}"

slot withdraws_option(Law: law, Matter: category)
  means "withdraws_option(Law, Matter): the law takes the choice in Matter from its holder"
  say "{Law} withdraws the choice in {Matter}"

slot holds_as(A: authority, Holder: category)
  means "holds_as(A, Holder): the authority A holds a choice as Holder, one of the holders option_of/3 names (a diocesan bishop as diocesan_bishop)"
  say "{A} holds a choice as {Holder}"

```clingo
% The diocesan bishop may legislate on the liturgy in every area (cc. 381 §1,
% 838 §4), never contrary to higher ius (c. 135 §2): he "could not ... impose
% limitations on the freedom of choice permitted in the liturgical books (RS
% 21)" (Huels, Liturgy and Law (2006) 47). GIRM 387's list adds to that power
% only Communion under both kinds (48): a matter's being unlisted is not the
% test; narrowing a choice the higher law leaves open is.
% The rule is dated. c. 135 §2 governs new law, so a narrowing law is tested on
% the day it is promulgated (Huels, Worship 74 (2000) 128; Worship 78 (2004)
% 410 n. 14), against a choice then open, on each ground then in force: c. 135
% §2 from 27 November 1983, RS 21's provision while it has force (cc. 33-34),
% from the instruction's publication, 23 April 2004. A choice
% the supreme authority withdraws is open no longer, from that law's force; a
% law already without force on its day is not revived by it (LW11).
act_kind(rs2004,instruction). effective_from(rs2004,20040423). issuer(rs2004,cdwds). authority(cdwds,3). provision(rs2004,rs2004_21).
option_withdrawn(M,D) :- withdraws_option(L2,M), force_at(L2,D).
option_open(H,M,D) :- option_of(H,M,_), force_at(H,D), not option_withdrawn(M,D).
narrowing_ground(c135_2,D) :- narrows(L,_), promulgated(L,D), force_at(code1983,D).
narrowing_ground(rs21,D)   :- narrows(L,_), promulgated(L,D), provision_in_force(rs2004_21,D).
% Whose choice it is decides (TTC-REPAIRS RH): a choice the higher law leaves
% to the narrowing law's own legislator is his to exercise, not higher ius he
% contradicts. The GIRM leaves Communion under both kinds, and so the mode of
% intinction, to the diocesan bishop's norms (GIRM 283, 387; Huels, Liturgy
% and Law (2006) 48). A right of the faithful whose exercise the law directs
% for the common good is regulated, not contradicted (c. 223 §2; RR).
own_choice(L,H,M) :- narrows(L,M), option_of(H,M,Hd), legislator(L,A), holds_as(A,Hd).
contrary_by(L,H,G) :- narrows(L,M), promulgated(L,D), option_open(H,M,D), narrowing_ground(G,D), L != H,
                      not own_choice(L,H,M), not regulated(L,M).
info(narrows_own_choice(L,H)) :- own_choice(L,H,M), promulgated(L,D), option_open(H,M,D).
contrary(L,H) :- contrary_by(L,H,_).
info(narrows_higher_choice(L,H,G)) :- contrary_by(L,H,G), higher(H,L).
% Before 1983 no ground is encoded: the narrowing is left to be read.
frontier(canon,narrowing_without_ground(L)) :- narrows(L,M), promulgated(L,D), option_of(H,M,_), force_at(H,D),
                                               not option_withdrawn(M,D), not narrowing_ground(_,D),
                                               not own_choice(L,H,M).

```

norm cic:223 | c. 223 §2: in view of the common good, ecclesiastical authority can direct the exercise of rights which are proper to the Christian faithful | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann208-329_en.html

slot right_of_the_faithful(M: category)
  means "right_of_the_faithful(M): the choice in M is a right proper to the Christian faithful (c. 223 §2), as receiving on the tongue (RS 92) or kneeling (RS 91)"
  say "the choice in {M} is a right of the faithful"

slot regulates_exercise(L: law, M: category)
  means "regulates_exercise(L, M): the law directs the exercise of the right in M in view of the common good (c. 223 §2); a prudential judgment, entered as a claim or disputed, never computed"
  say "{L} directs the exercise of the right in {M} in view of the common good"

```clingo
% "In view of the common good, ecclesiastical authority can direct the
% exercise of rights which are proper to the Christian faithful" (c. 223 §2).
% In a pandemic, provisional norms "must be obeyed" and "expire when the
% situation returns to normal", the right not limited beyond the norms of
% hygiene (CDW, letter to the presidents of the conferences, 15 August 2020).
% Whether a law does so is a judgment the checker never makes (rule 2): the
% claim is entered, or disputed and computed both ways. It rescues only a
% right of the faithful, never a choice the books leave to a minister (RR3).
{ regulates_exercise(L,M) } :- disputed(regulates_exercise(L,M)).
assumed_fact(F)        :- disputed(F), F = regulates_exercise(L,M), regulates_exercise(L,M).
assumed_fact(false(F)) :- disputed(F), F = regulates_exercise(L,M), not regulates_exercise(L,M).
regulated(L,M) :- regulates_exercise(L,M), right_of_the_faithful(M), narrows(L,M).
info(regulates_right(L,M)) :- regulated(L,M).
```

norm cic:1739 | c. 1739: the superior who deals with the recourse may confirm the decree or declare it invalid, rescind or revoke it, or emend, replace or modify it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1732-1752_en.html

slot decision_on_recourse(D: act, L: law, Outcome: category)
  means "decision_on_recourse(D, L, Outcome): the superior's decision D on a recourse against L: confirmed (c. 1739)"
  say "the decision {D} on recourse against {L}: {Outcome}"

```clingo
% A higher authority that confirms a law on recourse has judged it within
% power: a regulation disputed for that law is settled, for that law alone.
% The decision binds only the parties and the matter (c. 16 §2-3; RD2).
decides_above(D,L) :- decision_on_recourse(D,L,_), issuer(D,A), authority(A,K), legislator(L,AL), authority(AL,KL), K > KL.
regulates_exercise(L,M) :- decision_on_recourse(D,L,confirmed), decides_above(D,L), disputed(regulates_exercise(L,M)).
info(confirmed_on_recourse(L,D)) :- decision_on_recourse(D,L,confirmed), decides_above(D,L).
```

norm gnly:59 | GNLY 59-60 and the Table of Liturgical Days (General Norms for the Liturgical Year and the Calendar, 1969): precedence is governed solely by the Table; of several celebrations on one day, the one of highest rank is observed; a Solemnity impeded by a day of higher precedence is transferred, the others omitted; Optional Memorials (12) may be celebrated even on the days of no. 9; n. 14: of several Optional Memorials on one day, only one is celebrated | https://www.liturgyoffice.org/Calendar/Info/GNLY.pdf

slot celebration_on(D: date, C: celebration, R: table_rank)
  means "celebration_on(D, C, R): the calendar in use inscribes C on the date D, at number R of the Table of Liturgical Days (GNLY 59); entered from that calendar, the General or a proper one"
  say "{C} falls on {D}, at number {R} of the Table"

slot solemnity(C: celebration)
  means "solemnity(C): C is of the degree of a Solemnity (GNLY 10-11)"
  say "{C} is a Solemnity"

```clingo
% "If several celebrations fall on the same day, the one that holds the
% highest rank according to the Table of Liturgical Days is observed"
% (GNLY 60). An Optional Memorial (no. 12) displaces nothing: it may be
% kept on a day of no. 9 or 13, and is omitted on a day of any higher number
% (an obligatory memorial, 10-11, is observed over it). An impeded
% Solemnity is transferred (60): the transfer is not encoded.
day_asked(D) :- celebration_on(D,_,_).
optional_memorial(D,C) :- celebration_on(D,C,12).
outranked(D,C) :- celebration_on(D,C,R), R != 12, celebration_on(D,_,R2), R2 != 12, R2 < R.
day_celebration(D,C) :- celebration_on(D,C,R), R != 12, not outranked(D,C).
memorial_impeded(D) :- celebration_on(D,_,R), R <= 11, R != 9.
info(day_celebration(D,C)) :- day_celebration(D,C).
info(omitted(D,C)) :- outranked(D,C), not solemnity(C).
info(omitted(D,C)) :- optional_memorial(D,C), memorial_impeded(D).
info(may_be_kept(D,C)) :- optional_memorial(D,C), not memorial_impeded(D).
frontier(canon,impeded_solemnity(D,C)) :- outranked(D,C), solemnity(C).
```

norm gnly:3 | GNLY 3: the liturgical day runs from midnight to midnight, but the celebration of Sunday and of Solemnities begins already on the evening of the previous day; 11: Solemnities begin with First Vespers on the preceding day; 13: Feasts are celebrated within the limits of the natural day, and so have no First Vespers | https://www.liturgyoffice.org/Calendar/Info/GNLY.pdf

```clingo
% A Sunday or a Solemnity begins on the evening of the day before; a Feast
% keeps the natural day (13), save a Feast of the Lord on a Sunday, which
% begins as the Sunday does (CE1). The weekday is computed (saeculum.lp).
begins_on_eve(D,C) :- day_celebration(D,C), weekday(D,sunday).
begins_on_eve(D,C) :- day_celebration(D,C), solemnity(C).
info(begins_evening_before(C,P)) :- begins_on_eve(D,C), day_before(D,P).
```

norm gnly:61 | GNLY 61: if on the same day Vespers of the current Office and First Vespers of the following day are to be celebrated, the Vespers of the celebration of higher rank take precedence; in cases of equal rank, Vespers of the current day | https://www.liturgyoffice.org/Calendar/Info/GNLY.pdf

```clingo
% The evening of the eve belongs to the higher in the Table (the lower
% number); at equal rank, to the current day (CE4). Where the next day's
% celebration does not begin on the eve, the evening is the day's own.
evening_prevails(P,C) :- begins_on_eve(D,C), day_before(D,P), celebration_on(D,C,R), day_celebration(P,C0),
                         celebration_on(P,C0,R0), R < R0.
evening_prevails(P,C0) :- day_celebration(P,C0), celebration_on(P,C0,R0), day_after(P,D), begins_on_eve(D,C),
                          celebration_on(D,C,R), R >= R0.
evening_prevails(P,C0) :- day_celebration(P,C0), day_after(P,D), celebration_on(D,_,_), not begins_on_eve(D,_).
info(vespers_of(P,C)) :- evening_prevails(P,C).
```

norm gnly:11 | GNLY 11: some Solemnities are also endowed with their own Vigil Mass, which is to be used on the evening of the preceding day, if an evening Mass is celebrated | https://www.liturgyoffice.org/Calendar/Info/GNLY.pdf

slot vigil_mass(C: celebration, F: formulary)
  means "vigil_mass(C, F): the Solemnity C has its own Vigil Mass, the formulary F (GNLY 11)"
  say "{C} has its own Vigil Mass, {F}"

slot mass_formulary(M: entity, F: formulary)
  means "mass_formulary(M, F): the Mass M is celebrated with the formulary F"
  say "{M} is celebrated with the formulary {F}"

```clingo
% Of a Solemnity whose evening it is (61, above), an evening Mass on the
% eve is its Vigil Mass (CE2). Between noon and two the hour is evening on
% one reading only (c. 1248, below), and in a doubt of law the requirement
% does not oblige (c. 14): only a Mass evening on every reading is held to
% it. No such rule is written of a Sunday's eve (CE3).
violation(vigil_mass_not_used(M,C)) :- vigil_mass(C,F), evening_prevails(P,C), day_after(P,D), begins_on_eve(D,C),
                                       mass_at(M,P,_), evening_certain(M), mass_formulary(M,F2), F2 != F.
```

norm cic:1248 | cc. 1246-1248: Sunday is to be observed in the universal Church as the primordial holy day of obligation, and ten other days (c. 1246 §1); on Sundays and other holy days of obligation the faithful are obliged to participate in the Mass (c. 1247); a person who assists at a Mass celebrated anywhere in a Catholic rite either on the feast day itself or in the evening of the preceding day satisfies the obligation of participating in the Mass (c. 1248 §1) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1244-1253_en.html

slot holy_day_of_obligation(D: date)
  means "holy_day_of_obligation(D): a day other than Sunday kept as a holy day of obligation where the case is (c. 1246, as the conference has it under §2)"
  say "{D} is a holy day of obligation"

slot mass_at(M: entity, D: date, T: number)
  means "mass_at(M, D, T): a Mass celebrated in a Catholic rite on the date D at the hour T (HHMM)"
  say "{M} is celebrated on {D} at {T}"

slot assists_at(P: person, M: entity)
  means "assists_at(P, M): the person assists at the Mass M (c. 1248 §1); an outward fact, the canon side's (attends/2 is the authority layer's)"
  say "{P} assists at {M}"

slot evening_from(R: reading, H: number)
  means "evening_from(R, H): on the reading R of c. 1248 §1's \"evening\", the evening begins at the hour H (HHMM)"
  say "read as {R}, the evening begins at {H}"

```clingo
% Any Mass in a Catholic rite on the day, or in the evening of the day
% before, whatever its formulary (CO1). A Mass between noon and two meets
% it on the reading c. 14 gives (the readings, above); a morning Mass on
% the eve, or a service that is not a Mass (c. 1248 §2 recommends and
% obliges to nothing), meets nothing (CO3). Of a person, the checker says
% only that assisting at a Mass meets the obligation, never that anyone
% failed it (rule 3).
day_asked(D) :- mass_at(_,D,_).
day_asked(N) :- mass_at(_,P,_), day_after(P,N).
obligation_day(D) :- day_asked(D), weekday(D,sunday).
obligation_day(D) :- holy_day_of_obligation(D).
on_the_eve(M,D) :- mass_at(M,P,_), day_after(P,D), obligation_day(D).
early_on(M,R) :- mass_at(M,P,T), day_after(P,_), evening_from(R,H), T < H.
evening_possible(M) :- mass_at(M,P,_), day_after(P,_), evening_from(R,_), not early_on(M,R).
evening_certain(M) :- mass_at(M,P,_), day_after(P,_), not early_on(M,_).
meets_obligation(M,D) :- mass_at(M,D,_), obligation_day(D).
meets_obligation(M,D) :- on_the_eve(M,D), evening_certain(M).
meets_obligation(M,D) :- on_the_eve(M,D), read_for(c1247,R,M), not early_on(M,R).
info(meets_obligation(M,D)) :- meets_obligation(M,D).
info(satisfies_obligation(P,D,M)) :- assists_at(P,M), meets_obligation(M,D).
```

norm cic:333 | c. 333 §3: no appeal or recourse against a decision of the Roman Pontiff | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann330-367_en.html

stratum cic:333 supreme

```clingo
papal_act(D) :- issuer(D,A), authority(A,4).
% A curial decree approved in specific form is the Pontiff's own act, as the
% authority side already ranks it (in_forma_specifica, rank 4; TTC-REPAIRS2 PA1).
papal_act(D) :- approved_in_specific_form(D).

```

norm cic:113 | c. 113: the Catholic Church and the Apostolic See have the character of a moral person by divine ordinance itself; in the Church, besides physical persons, there are juridic persons, subjects of obligations and rights which correspond to their nature; c. 114 §1: constituted by law or by decree; c. 118: represented by those whose competence is acknowledged; c. 120 §1: perpetual by nature | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html

```clingo
% A juridic person is a unity of order, not a substance (In I Ethic. lect. 1;
% CCC 1880): it acts through those who represent it (act.lp), and bears no
% interior, no sin, no delict. Innocent IV, Romana ecclesia (VI 5.11.5): "In
% universitatem vel collegium proferri excommunicationis sententiam penitus
% prohibemus." (TTC-PENAL FL)
moral_person(catholic_church). moral_person(apostolic_see).
violation(delict_of_fiction(J,N,E)) :- fiction(J), delict(J,N,E).

```

norm cic:125 | c. 125: an act placed out of force from without which could not be resisted is considered never to have taken place; one placed out of grave fear unjustly inflicted is valid unless the law provides otherwise, but can be rescinded by a judge | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann124-128_en.html

```clingo
act_of(P,J) :- juridic_act(J,P).
never_placed(J) :- juridic_act(J,P), removes_voluntary(P,J,violence).
info(juridic_act(J,never_placed)) :- never_placed(J).
info(juridic_act(J,rescindable))  :- juridic_act(J,P), actus_humanus(P,J), grave_fear(P,J), fear_unjust(P,J).

% ---------- Book I: which code (TTC-CCEO) ----------------------------------
```

norm cic:111 | c. 1: the canons of this Code regard only the Latin Church; c. 111 §1 (as amended by De concordia inter Codices, 2016): by baptism the child of parents who belong to the Latin Church is ascribed to it, or, if one does not, when both agree that the child be baptized in it; failing agreement, to the Church sui iuris of the father (so CCEO c. 29 §1 for a child under fourteen) | https://www.vatican.va/content/francesco/la/motu_proprio/documents/papa-francesco-motu-proprio_20160531_de-concordia-inter-codices.html

```clingo
% Ascription selects the code. A Catholic whose ascription the case does not
% record is Latin: silence ascribes to the Latin Church, as c. 11 reads
% silence as binding (a convention; every case of the base is Latin). Each
% Latin delict carries the gate of c. 1 (not eastern_faithful).
church_of(P,C)      :- ascribed(P,C).
church_of(P,C)      :- child_ascribed(P,C), not ascribed(P,_).
church_of(P,latin)  :- in_catholic_church(P), not ascribed(P,_), not child_ascribed(P,_).
eastern_faithful(P) :- church_of(P,C), eastern_church(C), in_catholic_church(P).
latin_faithful(P)   :- church_of(P,latin), in_catholic_church(P).
parent_church(P,C)  :- father(P,F), church_of(F,C).
parent_church(P,C)  :- mother(P,M), church_of(M,C).
child_ascribed(P,C) :- father(P,F), mother(P,M), church_of(F,C), church_of(M,C).
child_ascribed(P,C) :- father(P,F), mother(P,M), church_of(F,CF), church_of(M,CM), CF != CM, agreed(P,C), parent_church(P,C).
child_ascribed(P,CF) :- father(P,F), mother(P,M), church_of(F,CF), church_of(M,CM), CF != CM, not agreed_any(P).
agreed_any(P) :- agreed(P,_).
eastern_noncatholic(P) :- baptized_in(P,C), eastern_noncatholic_church(C), not received_into(P).
```

end

```clingo
info(ascribed_to(P,C)) :- child_ascribed(P,C).

% ---------- Books I and II: who is bound; incorporation; communion (TTC-COMMUNION) ----
```

norm cic:11 | c. 11: merely ecclesiastical laws bind those baptized in the Catholic Church or received into it, who have the sufficient use of reason and, unless the law expressly provides otherwise, have completed seven years of age | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann7-22_en.html

```clingo
% Read negatively: a case's silence binds; what it records can exclude. The
% habitual lack of reason (c. 99) is act.lp's: no human act, and no law reaches it.
in_catholic_church(P) :- baptized_in(P,catholic).
in_catholic_church(P) :- received_into(P).
outside(P) :- unbaptized(P).
outside(P) :- baptized_in(P,C), C != catholic, not received_into(P).
unbound(P,L)      :- law_kind(L,ecclesiastical), outside(P).
unbound_at(P,L,A) :- law_kind(L,ecclesiastical), age_at(P,A,Y), Y < 7.
unbound_now(P,L)  :- law_kind(L,ecclesiastical), age_now(P,Y), Y < 7.       % a person's age taken now (TTC-CCEO WB1)
```

norm cic:96 | c. 96: by baptism one is incorporated into the Church of Christ and is constituted a person in it, with the duties and rights proper to Christians, insofar as they are in ecclesiastical communion and unless a lawfully issued sanction stands in the way | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann96-123_en.html

```clingo
incorporated(P) :- baptized_in(P,_).
```

norm cic:205 | c. 205: those baptized are fully in the communion of the Catholic Church on this earth who are joined with Christ in its visible structure by the bonds of the profession of faith, the sacraments, and ecclesiastical governance | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann204-207_en.html

```clingo
% c. 751's offences break the bonds (heresy and apostasy the profession,
% schism governance); no other delict does (the encoder's reading of the two).
bond_broken(P,profession) :- c751_offence(P,heresy,_).
bond_broken(P,profession) :- c751_offence(P,apostasy,_).
bond_broken(P,governance) :- schismatic_act(P,_).
full_communion(P) :- incorporated(P), in_catholic_church(P), not bond_broken(P,_).
```

end

```clingo
info(incorporated(P))            :- communion_at_issue(P), incorporated(P).
info(in_full_communion(P))       :- communion_at_issue(P), full_communion(P).
info(bond_broken(P,B))           :- communion_at_issue(P), bond_broken(P,B).
info(outside_the_church(P))      :- communion_at_issue(P), incorporated(P), not in_catholic_church(P).

% ---------- Book VI: delicts -----------------------------------------------
% Co-consecrators truly consecrate (Pius XII, Episcopalis consecrationis, 1944),
% so "a Bishop who consecrates" includes them on the plain meaning.
consecrates(E,B) :- consecration(E,B,_,_).
consecrates(E,B) :- co_consecrator(E,B).

```

norm cic1983:1382 | c. 1382 (1983): consecration without pontifical mandate | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
delict(B,n1382_1983,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1382_1983,T), not outside(B), not eastern_faithful(B).
delict(R,n1382_1983,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1382_1983,T), not outside(R), not eastern_faithful(R).
penalty(n1382_1983,excommunication).

```

norm cic2021:1387 | c. 1387: consecrator and consecrated without pontifical mandate incur latae sententiae excommunication reserved to the Apostolic See | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
delict(B,n1387,E) :- consecrates(E,B), event_date(E,T), not pontifical_mandate(E), norm_in_force(n1387,T), not outside(B), not eastern_faithful(B).
delict(R,n1387,E) :- consecration(E,_,R,T), not pontifical_mandate(E), norm_in_force(n1387,T), not outside(R), not eastern_faithful(R).
penalty(n1387,excommunication).

```

norm cic:751 | c. 751: schism is the refusal of submission to the Supreme Pontiff | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib3-cann747-755_en.html

```clingo
% Whether one act can constitute schism, or only a lasting state, is a
% reading of c. 751. Ecclesia Dei adflicta 3 (papal) applies it to the act.
schismatic_act(P,E) :- consecrates(E,P), against_explicit_papal_will(E), read_for(c751,act_suffices,E), not not_of_kind(E,schism).
schismatic_act(P,E) :- consecration(E,_,P,_), against_explicit_papal_will(E), read_for(c751,act_suffices,E), not not_of_kind(E,schism).

```

norm cic:751h | c. 751: heresy is the obstinate denial or obstinate doubt after the reception of baptism of some truth which is to be believed by divine and catholic faith; apostasy is the total repudiation of the Christian faith | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib3-cann747-755_en.html

```clingo
% "To be believed by divine and catholic faith" is c. 750 §1's object, which
% the authority graph joins to teaching by reference (binds/3, owed/2; B15):
% no new link (TTC-COMMUNION). The obstinacy is the claim faith.lp reads as
% pertinacity (II-II q. 11 a. 2 ad 3); apostasy's definition has none.
owed_as(Q,V,O) :- owed(S,O), supports(S,Q,V).
heresy_matter(E) :- professes(_,E,Q,W), owed_as(Q,V,divine_and_catholic_faith), V != W.
heresy_matter(E) :- doubts(_,E,Q), owed_as(Q,_,divine_and_catholic_faith).
c751_offence(P,heresy,E)   :- professes(P,E,_,_), heresy_matter(E), incorporated(P), interior(P,E,pertinacious).
c751_offence(P,heresy,E)   :- doubts(P,E,_), heresy_matter(E), incorporated(P), interior(P,E,pertinacious).
c751_offence(P,apostasy,E) :- repudiates(P,E,christian_faith), incorporated(P).

```

norm cic2021:1364 | c. 1364 §1: an apostate from the faith, a heretic or a schismatic incurs a latae sententiae excommunication | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
delict(P,n1364,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364,T), not outside(P), not eastern_faithful(P).
delict(P,n1364_1983,E) :- schismatic_act(P,E), event_date(E,T), norm_in_force(n1364_1983,T), not outside(P), not eastern_faithful(P).
delict(P,n1364,E) :- c751_offence(P,_,E), event_date(E,T), norm_in_force(n1364,T), not outside(P), not eastern_faithful(P).
delict(P,n1364_1983,E) :- c751_offence(P,_,E), event_date(E,T), norm_in_force(n1364_1983,T), not outside(P), not eastern_faithful(P).
penalty(n1364,excommunication). penalty(n1364_1983,excommunication).

% Rejection of teaching owed firm assent (c. 750 §2, from 1998) or religious
% submission (c. 752), obstinately, warned and not retracting, apart from c. 1364.
% Ferendae sententiae: a penalty to be imposed, never incurred.
rejects(P,E,c752)   :- professes(P,E,Q,W), owed_as(Q,V,religious_submission), V != W.
rejects(P,E,c750_2) :- professes(P,E,Q,W), owed_as(Q,V,firm_assent), V != W.
obstinate_rejection(P,E,Of) :- rejects(P,E,Of), interior(P,E,pertinacious), warned(P,E,_),
                               not retracted(P,E), not heresy_matter(E).
```

norm cic1983:1371 | c. 1371 n. 1 (1983): one who, apart from the case of c. 1364 §1, teaches a doctrine condemned by the Roman Pontiff or an ecumenical council, or obstinately rejects the doctrine mentioned in c. 752, and does not retract when warned by the Apostolic See or the ordinary, is to be punished with a just penalty | https://www.iuscangreg.it/cic1983.php

```clingo
delict(P,n1371_1983,E) :- obstinate_rejection(P,E,c752), event_date(E,T), norm_in_force(n1371_1983,T), not outside(P), not eastern_faithful(P).
```

norm atf1998:1371 | c. 1371 n. 1 as amended by Ad tuendam fidem (18 May 1998): "or obstinately rejects the teachings mentioned in canon 750 § 2 or in canon 752" | https://www.vatican.va/content/john-paul-ii/en/motu_proprio/documents/hf_jp-ii_motu-proprio_30061998_ad-tuendam-fidem.html

```clingo
delict(P,n1371_1998,E) :- obstinate_rejection(P,E,_), event_date(E,T), norm_in_force(n1371_1998,T), not outside(P), not eastern_faithful(P).
```

norm cic2021:1365 | c. 1365: one who, apart from c. 1364 §1, teaches a doctrine condemned by the Roman Pontiff or an ecumenical council, or obstinately rejects the teaching of c. 750 §2 or c. 752, and does not retract when warned by the Apostolic See or the ordinary, is to be punished with a censure and deprivation of office | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
delict(P,n1365,E) :- obstinate_rejection(P,E,_), event_date(E,T), norm_in_force(n1365,T), not outside(P), not eastern_faithful(P).
penalty(n1371_1983,just_penalty). penalty(n1371_1998,just_penalty). penalty(n1365,censure).

```

temporal cic2021:1379

norm cic2021:1379 | c. 1379 §1 n. 2: one who cannot validly absolve and attempts absolution incurs latae sententiae interdict (a cleric also suspension) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
delict(P,n1379,A) :- absolution(A,P,_,T), not valid_absolution(A), norm_in_force(n1379,T), not outside(P), not eastern_faithful(P).
penalty(n1379,interdict).
element_of(n1379,cannot_absolve).                 % the delict's matter: one who cannot validly absolve

% ---------- Book VI: abortion (TTC-PENAL AB) -----------------------------------
% The matter comes from the moral library (moral.lp): a completed act whose
% kind is the direct killing of an innocent, its victim unborn. The canon layer
% keeps no kind of its own (CCC 2272: "a crime against human life").
```

slot procures(Person: person, Act: act)
  means "procures(Person, Act): the person procures the act (one who seeks it as well as one who performs it)"
  say "{Person} procures {Act}"

slot unborn(E: effect)
  means "unborn(E): the evil effect E is the death of one not yet born, from conception"
  say "the evil effect {E} is the death of one not yet born"

slot by_expulsion(A: act)
  means "by_expulsion(A): the act kills by expelling the immature fetus (outward)"
  say "the act {A} kills by expelling the immature fetus"

slot attempted_only(A: act)
  means "attempted_only(A): the act was attempted and its effect did not follow (c. 1328)"
  say "the act {A} was attempted, its effect not following"

use evil_kind_of/2 "moral.lp: an evil effect of this kind"

norm pclt1988:1398 | authentic interpretation of c. 1398 (Pontifical Commission for the Authentic Interpretation of the Code, 19 January 1988, approved by John Paul II on 23 May 1988; AAS 80 (1988) 1818-1819): abortion is not only the expulsion of the immature fetus but also its killing in whatever way and at whatever time from the moment of conception | https://www.vatican.va/roman_curia/pontifical_councils/intrptxt/documents/rc_pc_intrptxt_doc_22091998_authentic-interp_lt.html

```clingo
killing_of_unborn(A) :- direct(A,E), evil_kind_of(E,killing_of_innocent), unborn(E).
abortion_matter(A) :- killing_of_unborn(A), read_for(abortion,killing,A).
abortion_matter(A) :- killing_of_unborn(A), read_for(abortion,expulsion,A), by_expulsion(A).
```

norm cic1983:1398 | c. 1398 (1983): one who procures an abortion, the effect following, incurs a latae sententiae excommunication | https://www.iuscangreg.it/cic1983.php

```clingo
delict(P,n1398_1983,A) :- procures(P,A), abortion_matter(A), not attempted_only(A), event_date(A,T),
                          norm_in_force(n1398_1983,T), not outside(P), not eastern_faithful(P).
penalty(n1398_1983,excommunication).
```

norm cic2021:1397 | c. 1397 §2: a person who actually procures an abortion incurs a latae sententiae excommunication | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
delict(P,n1397,A) :- procures(P,A), abortion_matter(A), not attempted_only(A), event_date(A,T),
                     norm_in_force(n1397,T), not outside(P), not eastern_faithful(P).
penalty(n1397,excommunication).
```

norm cic2021:1328 | c. 1328 §1: one who in furtherance of an offence did or omitted something but did not complete it is not bound by the penalty prescribed for the completed offence, unless the law provides otherwise (the same in 1983) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
info(attempt_not_the_delict(P,A)) :- procures(P,A), attempted_only(A), killing_of_unborn(A).
```

recursive cic2021:1329

norm cic2021:1329 | c. 1329 §2: accomplices not named in the law incur a latae sententiae penalty if without their assistance the delict would not have been committed and the penalty can affect them; otherwise they can be punished by ferendae sententiae penalties (the same in 1983) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

slot assists(Person: person, Act: act)
  means "assists(Person, Act): the person gives assistance to another's delict"
  say "{Person} assists in the act {Act}"

slot necessary_assistance(P: person, A: act)
  means "without the person's assistance the delict would not have been committed (outward; computed both ways when disputed)"
  say "without {P}, the delict {A} would not have been committed"

```clingo
delict(P,N,A) :- assists(P,A), necessary_assistance(P,A), delict(Q,N,A), Q != P, latae_sententiae(N), not outside(P), not eastern_faithful(P).
info(accomplice_may_be_punished(P,N,A)) :- assists(P,A), not necessary_assistance(P,A), delict(Q,N,A), Q != P,
                                           latae_sententiae(N), not outside(P), not eastern_faithful(P).
```

end

```clingo
info(abortion_reading(A,R)) :- read_for(abortion,R,A).

% ---------- Book VI: imputability, through the human act (act.lp) ---------
% Status is computed at each instant: an act is judged by the law and the
% juridical situation on its own date, not on the evaluation date. What the
% agent knew, willed or feared is never computed here: the library reads the
% claims a case supplies (interior/3), and the canons read the library.
```

norm cic2021:1321 | c. 1321 §§2-4 and c. 1322: no one is punished unless the external violation is gravely imputable by malice or culpability; culpability is punished only where the law provides; once the violation is established imputability is presumed unless it appears otherwise; the habitually insane are incapable | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
act_of(P,E) :- delict(P,_,E).
% §4 is act.lp's one shape of presumption: the violation raises it, an
% outward appearance rebuts it (TTC-CHRIST SA3).
raises(imputability(P,E))   :- delict(P,_,E).
rebutted(imputability(P,E)) :- appears_otherwise(P,E).
% imputable_act/2: a human act, or a deed voluntary in its cause (act.lp; TTC-REPAIRS4 IC1)
imputed(P,N,E) :- delict(P,N,E), presumed(imputability(P,E)), imputable_act(P,E),
                  not exempt(P,E), not unpunished_culpa(P,N,E), not not_grave(P,E).
unpunished_culpa(P,N,E) :- delict(P,N,E), culpa(P,E), not punishes_culpa(N), not culpa_disregarded(P,N,E).
unpunished_culpa(P,N,E) :- delict(P,N,E), ignorance_source(P,E,culpa), not punishes_culpa(N).
% §2: imputability claimed not grave leaves no subjective element of the delict
% (a claim supplied, never computed; TTC-REPAIRS3 MT2).
not_grave(P,E) :- delict(P,_,E), interior(P,E,imputability(not_grave)).
info(no_formal_delict(P,E)) :- not_grave(P,E).
% A penalty to be imposed by a process: the process itself must establish the
% source of imputability (c. 1342 §1; c. 1608), so the reading of §4 below
% does not reach it (TTC-REPAIRS2 CI4).
to_be_imposed(P,N,E) :- imputed(P,N,E), not latae_sententiae(N).
% §§2-3: the source of grave imputability, dolus or culpa, is a finding a
% case supplies; the checker never derives it (rule 3).
supplied_source(P,E) :- dolus(P,E).
supplied_source(P,E) :- culpa(P,E).
supplied_source(P,E) :- ignorance_source(P,E,_).      % c. 1325, as read (TTC-REPAIRS3 IG1)
supplied_source(P,E) :- premeditated(P,E,_).          % c. 1326 §1 n. 4 (TTC-REPAIRS3 AG2; TTC-REPAIRS4 DS2)
unsourced_latae(P,N,E) :- imputed(P,N,E), latae_sententiae(N), not supplied_source(P,E).
info(not_a_human_act(P,E)) :- delict(P,_,E), not actus_humanus(P,E).
info(dolus(P,E))           :- delict(P,_,E), dolus(P,E).
info(culpa_not_punished(P,N,E)) :- unpunished_culpa(P,N,E).
% §2: no one is punished without dolus or culpa. A law that disregards an error
% is coherent only where the act is unlawful apart from what the error concerns:
% one engaged in an unlawful act answers for what follows from it (versari in
% re illicita, II-II q. 64 a. 8; TTC-ACT N1, N4).
illicit_apart(P,E) :- binds_for(P,E,K), kind_of_act(E,K).
violation(punished_without_fault(P,N,E)) :- imputed(P,N,E), disregarded(N,Of), ignorant_without_fault(P,E,Of),
                                            not illicit_apart(P,E).

```

norm cic2021:1321_4 | c. 1321 §4 with §§2-3, the presumption of imputability read, and a latae sententiae penalty binding one to whom the violation is gravely imputable by dolus, or by culpa where the law provides | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
% What §4 presumes is read once (c1321_4, all): mere imputability, the source
% then to be found in the acts; or imputability and so dolus, the rule of
% CIC/17 c. 2200 §2. No authentic interpretation: both are computed (rule 2).
punishable(P,N,E) :- imputed(P,N,E), dolus(P,E).
% imputed/3 already sets aside culpa the law does not punish (§3)
punishable(P,N,E) :- imputed(P,N,E), culpa(P,E).
punishable(P,N,E) :- unsourced_latae(P,N,E), read_for(c1321_4,presumes_dolus,all).
% gross ignorance read as a source (c. 1325), and passion fostered or a
% disturbance sought for the deed (c. 1326 §1 n. 4); imputed/3 already sets
% aside culpa the law does not punish
punishable(P,N,E) :- imputed(P,N,E), ignorance_source(P,E,_).
punishable(P,N,E) :- imputed(P,N,E), premeditated(P,E,_).
incurred_at(P,N,E,T) :- punishable(P,N,E), latae_sententiae(N), event_date(E,TE), instant(T), TE <= T,
                        not remitted_at(P,N,E,T), not latae_excused(P,N,E).
presumed_incurred(P,N,E) :- incurred_at(P,N,E,T), eval_date(T).
info(source_not_established(P,N,E)) :- unsourced_latae(P,N,E), read_for(c1321_4,presumes_imputability,all).
info(presumption_read(R)) :- read_for(c1321_4,R,all).

```

norm cic2021:1323 | c. 1323: not subject to a penalty: one under sixteen; one ignorant without fault of violating the law (inadvertence and error equivalent); physical force or unforeseeable chance; grave fear, necessity or grave inconvenience unless the act is intrinsically evil or tends to the harm of souls; due self-defence; lack of reason; one who thought without fault that the circumstances of nn. 4-5 existed | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
exempt(P,E) :- delict(P,_,E), age_at(P,E,Y), Y < 16.                                   % n. 1
exempt(P,E) :- delict(P,_,E), ignorant_without_fault(P,E,law).                          % n. 2
exempt(P,E) :- delict(P,N,E), ignorant_without_fault(P,E,fact(C)), element_of(N,C), not disregarded(N,fact(C)).  % n. 2: unaware he violated it
exempt(P,E) :- delict(P,_,E), chance(P,E).                                               % n. 3 (force: no human act)
exempt(P,E) :- delict(P,_,E), fear_or_necessity(P,E), not grave_matter(E).               % n. 4
exempt(P,E) :- delict(P,_,E), due_defence(P,E).                                          % n. 5
exempt(P,E) :- delict(P,_,E), believed(P,E,C,invincible), excusing(C).                   % n. 7
fear_or_necessity(P,E) :- grave_fear(P,E).
fear_or_necessity(P,E) :- necessity(P,E).
excusing(fear). excusing(necessity). excusing(defence).
grave_matter(E) :- of_kind(E,intrinsically_evil).
grave_matter(E) :- of_kind(E,harm_of_souls).
grave_matter(E) :- kind_of_act(E,K), evil_by_object(K).          % the library's kind (TTC-PENAL AB5)
info(exempt(P,E)) :- exempt(P,E).
% Proper and improper exemptions (TTC-REPAIRS3 PE1). Improper: the subjective
% element is absent, so there is no delict in the formal sense; the external
% violation alone remains (delict/3). Proper: the delict stands, and the law
% exempts it from the penalty.
improper(P,E) :- delict(P,_,E), ignorant_without_fault(P,E,law).                        % n. 2
improper(P,E) :- delict(P,N,E), ignorant_without_fault(P,E,fact(C)), element_of(N,C), not disregarded(N,fact(C)).  % n. 2
improper(P,E) :- delict(P,_,E), chance(P,E).                                             % n. 3
improper(P,E) :- delict(P,_,E), believed(P,E,C,invincible), excusing(C).                 % n. 7
improper(P,E) :- delict(P,_,E), not imputable_act(P,E).                                  % force; the lack of reason (n. 6; c. 1322)
proper_exemption(P,E) :- delict(P,_,E), age_at(P,E,Y), Y < 16.                           % n. 1
proper_exemption(P,E) :- delict(P,_,E), fear_or_necessity(P,E), not grave_matter(E).     % n. 4
proper_exemption(P,E) :- delict(P,_,E), due_defence(P,E).                                % n. 5
info(no_formal_delict(P,E)) :- improper(P,E).
info(delict_stands_exempt(P,E)) :- proper_exemption(P,E), not improper(P,E).
% n. 6 reserves cc. 1324 §1 n. 2 and 1326 §1 n. 4: a lack of reason brought on
% culpably, or sought, leaves the deed voluntary in its cause (TTC-REPAIRS4 DR1)
info(voluntary_in_cause(P,E)) :- delict(P,_,E), voluntary_in_cause(P,E).

```

norm cic2021:1324 | c. 1324 §1 nn. 1-10 and §3, imperfect use of reason; the use of reason lacking through culpable drunkenness or a similar disturbance; undeliberate grave passion; a minor over sixteen; grave fear or necessity where the act is intrinsically evil or harmful to souls; defence without due moderation; grave and unjust provocation; culpably mistaken circumstances of c. 1323 nn. 4-5; ignorance without fault of the penalty; imputability not full yet grave; the penalty is tempered, and no latae sententiae penalty binds | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
mitigated(P,E,imperfect_reason) :- delict(P,_,E), imperfect_reason(P,E).                % n. 1
mitigated(P,E,culpable_disturbance) :- delict(P,_,E), voluntary_in_cause(P,E), not sought_disturbance(P,E).  % n. 2, without prejudice to c. 1326 §1 n. 4
mitigated(P,E,passion)          :- delict(P,_,E), undeliberate_passion(P,E).            % n. 3
mitigated(P,E,minor)            :- delict(P,_,E), age_at(P,E,Y), 16 <= Y, Y < 18.       % n. 4
mitigated(P,E,fear)             :- delict(P,_,E), fear_or_necessity(P,E), grave_matter(E). % n. 5
mitigated(P,E,mistaken)         :- delict(P,_,E), believed(P,E,C,vincible), excusing(C). % n. 8
mitigated(P,E,penalty_unknown)  :- delict(P,_,E), ignorant_without_fault(P,E,penalty).  % n. 9
% nn. 6, 7, 10: claims supplied, never computed (TTC-REPAIRS3 MT1). An excess in
% defence by dolus, which excludes mitigation, is not told apart here.
mitigated(P,E,excess_defence)   :- delict(P,_,E), interior(P,E,defence(immoderate)).    % n. 6
mitigated(P,E,provocation)      :- delict(P,_,E), interior(P,E,provoked(grave,unjust)). % n. 7
mitigated(P,E,not_full)         :- delict(P,_,E), interior(P,E,imputability(diminished)). % n. 10
latae_excused(P,N,E) :- delict(P,N,E), mitigated(P,E,_), latae_sententiae(N).           % §3

```

norm cic2021:1325 | c. 1325: crass, supine or affected ignorance is never taken into account in applying cc. 1323 and 1324 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
info(ignorance_disregarded(P,E,Of)) :- delict(P,_,E), gross_ignorance(P,E,Of).
% What gross ignorance supplies, read once (c1325, all; TTC-REPAIRS3 IG1).
ignorance_source(P,E,dolus) :- gross_ignorance(P,E,_), delict(P,_,E), read_for(c1325,as_dolus,all).
ignorance_source(P,E,dolus) :- ignorance(P,E,_,affected), delict(P,_,E), read_for(c1325,affected_as_dolus,all).
ignorance_source(P,E,culpa) :- ignorance(P,E,_,K), gross(K), K != affected, delict(P,_,E), read_for(c1325,affected_as_dolus,all).
info(c1325_read(R)) :- read_for(c1325,R,all).
```

norm cic2021:1326 | c. 1326 §1 nn. 3-4, a judge must inflict a more serious punishment on one who, a penalty for a culpable offence being constituted, foresaw the event and omitted the precautions any careful person would have taken; and on one who offended in drunkenness or another mental disturbance deliberately sought so as to commit the offence or to excuse it, or through passion deliberately stimulated or nourished | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
% n. 4: a disturbance sought so as to commit the offence or to excuse it
% (TTC-REPAIRS4 DS2), or passion fostered for the deed (TTC-REPAIRS3 AG2),
% supplies dolus (dolus praemeditatus) and aggravates. The deed done without
% reason so sought is voluntary in its cause (act.lp).
premeditated(P,E,stimulated_passion) :- delict(P,_,E), interior(P,E,passion(grave,stimulated)).
premeditated(P,E,sought_disturbance) :- delict(P,_,E), sought_disturbance(P,E).
info(aggravated(P,E,W)) :- premeditated(P,E,W).
% n. 3: only where the law punishes culpa (c. 1321 §3; TTC-REPAIRS3 AG1)
info(aggravated(P,E,foreseen_event)) :- delict(P,N,E), culpa(P,E), punishes_culpa(N), interior(P,E,foresaw(certain)).
```

end

```clingo
info(mitigated(P,E,W)) :- mitigated(P,E,W), imputed(P,_,E).
% Whether necessity existed, or was believed in, is about the agent. A public
% claim of necessity is recorded; the checker never decides it.
info(defence_claimed(P)) :- claims_necessity(P,E), presumed_incurred(P,_,E).

```

norm cic:1355 | remission of a censure | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
remitted_at(P,N,E,T) :- remission(_,P,N,TR), delict(P,N,E), event_date(E,TE), TE <= TR, instant(T), TR <= T.

% ---------- Book VI and VII: declaring a penalty ------------------------------
```

norm cic:1717 | c. 1717 §1: the preliminary investigation may be omitted if it seems entirely superfluous | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1717-1731_en.html

```clingo
info(investigation_dispensable(D,P)) :- declares(D,P,N), issued(D), delict(P,N,E), public_act(P,E).
public_act(P,E) :- delict(P,_,E), consecration(E,_,_,_).          % a public liturgical act

```

norm cic2021:1342 | c. 1342 §1 with c. 1720 n. 1: a penalty declared by decree requires that the accused be heard, unless duly summoned and absent | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1717-1731_en.html

```clingo
hearing_ok(D,P) :- heard(D,P).
hearing_ok(D,P) :- summoned_absent(D,P).
hearing_ok(D,P) :- notoriety_substitutes(D,P).
% Notoriety proves the act; it does not hear the person (c. 1717 §1 may
% dispense the investigation, never c. 1720 n. 1).
violation(notoriety_for_hearing(D,P)) :- notoriety_substitutes(D,P).
% A decree is presumed valid (c. 124 §2) until annulled. A missing hearing
% is a ground for recourse, not a non-existent decree.
info(ground_for_recourse(D,P,c1720)) :- declares(D,P,_), issued(D), not hearing_ok(D,P).

```

norm cic:54 | c. 54 §1, a singular decree not entrusted to an executor takes effect when it is made known to the person by the authority of the one who issued it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib1-cann35-93_en.html

```clingo
% A declaration takes effect for each person it names when made known to him
% (TTC-REPAIRS2 NK1). The executor clause is not encoded.
notified_to(D,P) :- notified(D,P,_).
effective_at(D,P,T) :- declares(D,P,_), notified(D,P,TN), instant(T), TN <= T.
% No notification entered: the effect is dated from the decree, and a note says so.
effective_at(D,P,T) :- declares(D,P,_), not notified_to(D,P), decree(D,_,TD), instant(T), TD <= T.
info(effect_from_decree_date(D)) :- declares(D,P,_), issued(D), not notified_to(D,P).

```

norm sst2021:24 | Norms on delicts reserved to the Dicastery for the Doctrine of the Faith (11 October 2021), art. 24 §1 with art. 2 §1, recourse against the Dicastery's own acts in reserved delicts lies to the same Dicastery, any further recourse excluded; the delicts of c. 1364 are reserved | https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_con_cfaith_doc_20211011_norme-delittiriservati-cfaith_en.html

```clingo
% art. 2 §1; the reserved delicts of arts. 3-6 are not yet entered (TTC-REPAIRS2 SR3)
reserved_to_ddf(n1364).
reserved_matter(D) :- declares(D,_,N), reserved_to_ddf(N).
dicastery_act(D) :- issuer(D,ddf).
% the Dicastery's decision on a recourse against its own act is the last word (TTC-REPAIRS2 SR1)
final_on_recourse(D2) :- decides_recourse(D2,D1), dicastery_act(D1), dicastery_act(D2), reserved_matter(D1).

```

norm cic2021:1353 | c. 1353: recourse against a decree declaring a penalty has suspensive effect | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
recourse_admissible(D) :- recourse(D,_,_), not papal_act(D), not final_on_recourse(D).
info(no_recourse_against_papal_act(D)) :- recourse(D,_,_), papal_act(D).
info(no_further_recourse(D)) :- recourse(D,_,_), final_on_recourse(D).
decided_at(D,T)   :- recourse_decided(D,TD), instant(T), TD <= T.
suspended_at(D,T) :- recourse_admissible(D), recourse(D,_,TR), instant(T), TR <= T, not decided_at(D,T).
annulled(D) :- recourse_upheld(D).
declared_at(P,N,T) :- declares(D,P,N), effective_at(D,P,T), not suspended_at(D,T), not annulled(D).
declared_effective(P,N) :- declared_at(P,N,T), eval_date(T).
info(declared(P,N)) :- declared_effective(P,N).
info(declaration_suspended(D,P)) :- declares(D,P,_), suspended_at(D,T), eval_date(T).
info(presumed_incurred(P,N)) :- presumed_incurred(P,N,_).
% a declared title the norms do not derive (on the readings in force) is a ground to examine
info(title_not_derived(D,P,N)) :- declares(D,P,N), issued(D), not delict_title(P,N).
delict_title(P,N) :- delict(P,N,_).

% ---------- Book VI: effects of excommunication ----------------------------
```

norm cic2021:1331 | c. 1331 §1 n. 1: an excommunicated person may not celebrate the sacraments; §2 n. 2: once declared, his acts of governance are invalid | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
excommunicated_at(P,T) :- incurred_at(P,N,_,T), penalty(N,excommunication).
governance_invalid_at(P,T) :- declared_at(P,N,T), penalty(N,excommunication).

```

norm cic2021:1335 | c. 1335 §2: the prohibition yields for the dying, and, while the censure is undeclared, to a just-cause request | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1311-1363_en.html

```clingo
declared_any_at(P,T) :- declared_at(P,_,T).
prohibition_lifted(P,A) :- absolution(A,P,Pen,T), danger_of_death(Pen,T).
prohibition_lifted(P,A) :- absolution(A,P,Pen,T), just_cause_request(Pen,P,T), not declared_any_at(P,T).

% ---------- Book IV: holy communion (TTC-MORAL) ----------------------------
```

norm cic:912 | c. 912: any baptized person not prohibited by law can and must be admitted to holy communion | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann879-958_en.html

```clingo
right_to_communion(P) :- communion(_,P,_).
```

norm cic:915 | c. 915: those excommunicated or interdicted after the imposition or declaration of the penalty, and others obstinately persevering in manifest grave sin, are not to be admitted to holy communion | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann879-958_en.html

```clingo
% The first clause reads declared or imposed penalties only, never one
% incurred and undeclared. The second turns on the reading of "manifest grave
% sin" (above, with c. 751's): objectively, a situation grave by its matter;
% subjectively, a claim no minister can judge. Where the subjective reading is
% admissible, c. 18 takes it: the canon restricts the right of c. 912.
censure_barring(excommunication). censure_barring(interdict).
not_to_be_admitted(P,c915_censure) :- declared_effective(P,N), penalty(N,K), censure_barring(K).
restricts_rights(c915).
reaches(c915,objective,S)  :- situation_kind(S,K), grave_by_matter(K).
reaches(c915,subjective,S) :- situation(P,S), situation_kind(S,K), grave_by_matter(K), interior(P,S,subjectively_grave).
disputed(interior(P,S,subjectively_grave)) :- read_for(c915,subjective,S), situation(P,S).   % the internal forum
not_to_be_admitted(P,c915_sin) :- situation(P,S), binds_on(c915,S).
```

norm cic:916 | c. 916: one conscious of grave sin is not to celebrate Mass or receive the body of the Lord without previous sacramental confession, unless there is a grave reason and no opportunity to confess | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann879-958_en.html

```clingo
% Its one element is interior: of the internal forum, computed both ways in
% every case (rule 2), never derived.
disputed(interior(P,C,conscious_of_grave_sin)) :- communion(C,P,_).
not_to_receive(P,C) :- communion(C,P,_), interior(P,C,conscious_of_grave_sin), not confession_impossible(P,C).
```

end

```clingo
info(not_to_be_admitted(P,R)) :- not_to_be_admitted(P,R).
info(not_to_receive(P,C))     :- not_to_receive(P,C).
info(admitted_by_right(P,C))  :- communion(C,P,_), right_to_communion(P), not not_to_be_admitted(P,_), not not_to_receive(P,C).

% ---------- Book IV: faculties ----------------------------------------------
```

norm grants | a grant of faculty lasts until revoked by a competent authority ("until further provisions are made") | https://www.vatican.va/content/francesco/en/apost_letters/documents/papa-francesco-lettera-ap_20161120_misericordia-et-misera.html

```clingo
revoked_at(G,T) :- revocation(R,G,TR), competent_revocation(R,G), instant(T), TR <= T.
grant_in_force_at(G,T) :- grant(G,_,_,_,TG), instant(T), TG <= T, not revoked_at(G,T).
faculty_at(P,F,T) :- grant(G,_,F,C,_), in_class(P,C), grant_in_force_at(G,T).
permission_in_force_at(Perm,T) :- permission(Perm,_,_,TP), instant(T), TP <= T, not revoked_at(Perm,T).
class_faculty(C,F) :- grant(G,_,F,C,_), grant_in_force_at(G,T), eval_date(T).
class_permission(C,marriage) :- permission(Perm,_,C,_), permission_in_force_at(Perm,T), eval_date(T).
info(class_faculty(C,F)) :- class_faculty(C,F).
info(class_may_receive_delegation(C,marriage)) :- class_permission(C,marriage).

```

norm cic:966 | c. 966 §1: valid absolution requires orders and the faculty; c. 976: any priest absolves the dying; c. 144 §2: the Church supplies in common error | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann959-997_en.html

```clingo
% Routed through sacrament.lp (TTC-CHRIST SA1): orders are the minister's
% power, of divine law (DH 1710); the faculty is the condition this canon adds.
faculty_met(A) :- absolution(A,P,_,T), faculty_at(P,confession,T), not governance_invalid_at(P,T).
faculty_met(A) :- absolution(A,_,Pen,T), danger_of_death(Pen,T).
faculty_met(A) :- absolution(A,_,_,_), common_error(A).
defect(A,faculty) :- celebration(A,penance,_,_), not faculty_met(A).
valid_absolution(A) :- absolution(A,_,_,_), valid(A).
licit_absolution(A) :- valid_absolution(A), absolution(A,P,_,T), not excommunicated_at(P,T).
licit_absolution(A) :- valid_absolution(A), absolution(A,P,_,_), prohibition_lifted(P,A).
```

end

```clingo
info(absolution(A,valid,licit))   :- absolution(A,_,_,_), past(A), valid_absolution(A), licit_absolution(A).
info(absolution(A,valid,illicit)) :- absolution(A,_,_,_), past(A), valid_absolution(A), not licit_absolution(A).
info(absolution(A,invalid))       :- absolution(A,_,_,_), past(A), not valid_absolution(A).
info(delict(P,N,E)) :- delict(P,N,E), past(E).
info(to_be_imposed(P,N,E,K)) :- to_be_imposed(P,N,E), penalty(N,K), past(E).

```

norm cic:1117 | c. 1117: the form must be observed if at least one of the parties was baptized in the Catholic Church or received into it (as amended by Omnium in mentem, 2009; until then, "and has not defected from it by a formal act"), without prejudice to c. 1127 §2 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1108-1123_en.html

```clingo
promulgated(oim2009,20091026). aas_issue(oim2009,20100108).   % names no date; AAS 102 (2010) 8-10, issue of 8 January 2010 (c. 8 §1)
% Until Omnium in mentem the text of 1983 exempted one who had defected by a
% formal act: one matter in three texts, read off at the date (TTC-SOURCES TX2).
defection_exempts(P,M) :- spouse(M,P), formal_defection(P,D), marriage(M,_,T), D <= T, norm_in_force(n1117_1983,T).
bound_to_form(P,M) :- form_1983(M), spouse(M,P), not outside(P), not defection_exempts(P,M).
% the code whose form governs the marriage: one at a time (TTC-SOURCES TX5)
form_code(M,cic1983) :- form_1983(M).
form_code(M,cic1917) :- form_1917(M).
% silence binds: the form is excused only where every recorded party is outside or exempt
form_excused(M) :- form_code(M,_), spouse(M,_), not some_party_bound(M).
some_party_bound(M) :- bound_to_form(_,M).
form_binds(M) :- form_code(M,_), not form_excused(M).

```

norm cic:1108 | c. 1108 §1 and c. 1111: the form requires assistance by the ordinary, the pastor, or a priest delegated by either (the pastor within his territory), and two witnesses; c. 144 §2 | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1108-1123_en.html

```clingo
% A rule of the layer fires only under the text in force at the event's date
% (TTC-SOURCES TX): the form of 1983 from 27 November 1983.
form_1983(M) :- marriage(M,_,T), norm_in_force(n1108_1,T).
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,M,TD), ordinary(O), TD <= T.
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,general,TD), ordinary(O), TD <= T.
% the pastor delegates within his territory (c. 1111 §1; CIC 1917 c. 1095 §2)
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,M,TD), pastor_of(O,Tr), held_in(M,Tr), TD <= T.
delegated(P,M) :- marriage(M,P,T), delegation(_,O,P,general,TD), pastor_of(O,Tr), held_in(M,Tr), TD <= T.
valid_form(M) :- form_1983(M), marriage(M,P,T), delegated(P,M), not governance_invalid_at(P,T), not lacks_priest(M),
                 not few_witnesses(M).
valid_form(M) :- form_1983(M), common_error(M), not lacks_priest(M), not few_witnesses(M).
priest_required(M) :- priest_required_by(M,_).
lacks_priest(M) :- priest_required(M), marriage(M,A,_), not priest(A).
% Two witnesses (TTC-OFFICE PW1): a number given below two fails the form;
% silence is no defect.
few_witnesses(M) :- witnesses(M,N), N < 2.
```

norm cic:1109 | c. 1109: the local ordinary and the pastor, unless excommunicated, interdicted or suspended from office or declared such by sentence or decree, assist validly by virtue of office within their territory at the marriages of subjects and non-subjects, provided one party is of the Latin Church | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1108-1123_en.html

```clingo
% TTC-OFFICE PO1: by office, within the territory.
in_own_territory(M,P) :- marriage(M,P,_), pastor_of(P,T), held_in(M,T).
in_own_territory(M,P) :- marriage(M,P,_), ordinary_of(P,T), held_in(M,T).
in_own_territory(M,P) :- marriage(M,P,_), ordinary_of(P,D), held_in(M,T), within(T,D).
latin_party(M) :- spouse(M,Q), latin_faithful(Q).
valid_form(M) :- form_1983(M), marriage(M,P,T), in_own_territory(M,P), latin_party(M),
                 not governance_invalid_at(P,T), not lacks_priest(M), not few_witnesses(M).
```

norm cic:521 | c. 521 §1: to be appointed pastor validly, one must be in the sacred order of the presbyterate | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib2-cann515-552_en.html

```clingo
% TTC-OFFICE PO3: a pastor is a priest.
priest(P) :- pastor_of(P,_).
```

norm dc2016:1108 | c. 1108 §3 (De concordia inter Codices, 2016): only a priest validly assists at a marriage between Eastern parties, or between a Latin party and an Eastern party, Catholic or not; c. 1111 §1: delegation to priests and deacons, without prejudice to c. 1108 §3 | https://www.vatican.va/content/francesco/la/motu_proprio/documents/papa-francesco-motu-proprio_20160531_de-concordia-inter-codices.html

```clingo
eastern_party(M) :- spouse(M,P), eastern_faithful(P).
eastern_party(M) :- spouse(M,P), eastern_noncatholic(P).
priest_required_by(M,n1108_3) :- marriage(M,_,T), spouse(M,P), latin_faithful(P), eastern_party(M), norm_in_force(n1108_3,T).
```

norm cic:1127 | c. 1127 §1: in a mixed marriage the form of c. 1108 is observed; but if the Catholic party marries a non-Catholic of an Eastern rite, the canonical form binds for liceity only, and validity requires the intervention of a sacred minister (from 2016, "interventus sacerdotis"), other requirements of law observed | https://www.vatican.va/content/francesco/la/motu_proprio/documents/papa-francesco-motu-proprio_20160531_de-concordia-inter-codices.html

```clingo
liceity_only(M) :- form_1983(M), spouse(M,P), latin_faithful(P), spouse(M,Q), eastern_noncatholic(Q).
valid_form(M) :- liceity_only(M), marriage(M,A,_), sacred_minister(A), not lacks_priest(M).
sacred_minister(A) :- priest(A).
sacred_minister(A) :- deacon(A).
```

norm cic1917:1094 | CIC 1917 c. 1094: "Ea tantum matrimonia valida sunt quae contrahuntur coram parocho, vel loci Ordinario, vel sacerdote ab alterutro delegato et duobus saltem testibus"; abrogated with the Code of 1917 by CIC 1983 c. 6 §1 n. 1 | https://www.iuscangreg.it/cic1917.php

```clingo
% From 19 May 1918 to 26 November 1983. A priest is delegated, never a deacon
% (TTC-SOURCES TX1).
form_1917(M) :- marriage(M,_,T), norm_in_force(n1094_1917,T).
valid_form(M) :- form_1917(M), marriage(M,P,_), delegated(P,M), priest(P), not few_witnesses(M).
```

norm cic1917:1095 | CIC 1917 c. 1095 §1 n. 2: the pastor and the local ordinary assist validly within the limits of their own territory only, at the marriages of subjects and non-subjects | https://www.iuscangreg.it/cic1917.php

```clingo
% TTC-OFFICE PO2: by office under the Code of 1917, no proviso on rite.
valid_form(M) :- form_1917(M), marriage(M,P,_), in_own_territory(M,P), not few_witnesses(M).
```

norm cic1917:1099 | CIC 1917 c. 1099 §1: bound to the form are "omnes in catholica Ecclesia baptizati et ad eam ex haeresi aut schismate conversi, licet sive hi sive illi ab eadem postea defecerint", marrying among themselves (n. 1) or non-Catholics (n. 2); §2: not bound, "item ab acatholicis nati, etsi in Ecclesia catholica baptizati, qui ab infantili aetate in haeresi vel schismate aut infidelitate vel sine ulla religione adoleverunt, quoties cum parte acatholica contraxerint", a clause Pius XII struck from 1 January 1949 | https://www.iuscangreg.it/cic1917.php

```clingo
% One who left the Church is still bound; one born of non-Catholics and raised
% outside was not, until 1949 (TX2, TX3).
bound_to_form(P,M) :- form_1917(M), spouse(M,P), not outside(P), not exempt_1917(P,M).
exempt_1917(P,M) :- spouse(M,P), born_of_noncatholics(P), raised_outside(P), spouse(M,Q), outside(Q),
                    marriage(M,_,T), norm_in_force(n1099_2_1917,T).
```

end

```clingo
info(marriage(M,valid_form))   :- marriage(M,_,_), past(M), valid_form(M).
info(marriage(M,invalid_form)) :- marriage(M,_,_), past(M), form_binds(M), not valid_form(M), not dispensed(cond(matrimony,canonical_form),M).
info(marriage(M,form_dispensed)) :- marriage(M,_,_), past(M), form_binds(M), not valid_form(M), dispensed(cond(matrimony,canonical_form),M).
info(marriage(M,form_not_binding)) :- form_code(M,_), past(M), not form_binds(M).
info(no_text_in_force(M,form)) :- form_unread(M), past(M).
info(marriage(M,form_for_liceity_only)) :- liceity_only(M), past(M).
info(priest_required(M,N)) :- priest_required_by(M,N), past(M).
info(marriage(M,few_witnesses)) :- few_witnesses(M), past(M), form_binds(M), not liceity_only(M).

```

norm cic:1103 | c. 1103: a marriage is invalid if entered into because of force or grave fear from without, even when inflicted unintentionally, so that a person is compelled to choose marriage in order to be freed from it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann1095-1107_en.html

```clingo
act_of(P,M) :- spouse(M,P).
consent_vitiated(M) :- spouse(M,P), removes_voluntary(P,M,violence).
consent_vitiated(M) :- spouse(M,P), actus_humanus(P,M), grave_fear(P,M), fear_from_without(P,M), chosen_to_escape(P,M).
info(marriage(M,invalid_consent)) :- consent_vitiated(M).

% ---------- Book IV: the sacraments, through sacrament.lp (TTC-CHRIST) ---------
```

norm cic:842 | c. 842 §1: a person who has not received baptism cannot be admitted validly to the other sacraments | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann834-878_en.html

stratum cic:842 divine

```clingo
defect(E,subject) :- celebration(E,K,_,R), K != baptism, unbaptized(R).
```

norm cic:882 | c. 882: the ordinary minister of confirmation is a bishop; a presbyter provided with this faculty in virtue of universal law or the special grant of the competent authority also confers this sacrament validly (CCEO c. 696 §2: Eastern faithful receive it validly also from Latin presbyters, according to their faculties) | https://vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann879-958_en.html

```clingo
confirms_by_law_or_faculty(E) :- celebration(E,confirmation,P,_), priest(P), latin_faithful(P), faculty_to_confirm(P).
```

norm so1947 | Pius XII, Sacramentum ordinis (30 November 1947; AAS 40 (1948) 5-7): the matter of the diaconate, priesthood and episcopate "eamque unam esse manuum impositionem" (n. 4); "statuimus instrumentorum traditionem saltem in posterum non esse necessariam ad ... validitatem"; if it was ever necessary for validity "ex Ecclesiae voluntate et praescripto", the Church can change and abrogate what she established (n. 3); its dispositions "vim retroactivam non habent; quod si dubium aliquod contingat, illud huic Apostolicae Sedi erit subiiciendum" | https://www.vatican.va/content/pius-xii/la/apost_constitutions/documents/hf_p-xii_apc_19471130_sacramentum-ordinis.html

```clingo
% It names no date of force: three months from the issue (c. 8 §1, as the
% Code of 1917's c. 9). Before it, whether the porrection was required for
% validity is a doubt its own words leave open and refer to the Apostolic
% See: computed both ways (rule 2; TTC-LITURGY RS2).
promulgated(so1947,19471130). aas_issue(so1947,19480128).   % "ACTA, vol. XV, n. 1. — 28-1-948"
porrection_at_issue(E) :- celebration(E,orders(presbyterate),_,_), not porrection(E), celebration_date(E,T), not force_at(so1947,T).
{ porrection_required(E) } :- porrection_at_issue(E).
defect(E,porrection) :- porrection_required(E).
assumed_fact(porrection_required(E))        :- porrection_required(E).
assumed_fact(false(porrection_required(E))) :- porrection_at_issue(E), not porrection_required(E).
```

norm cic:846 | c. 846 §1: in celebrating the sacraments the liturgical books approved by competent authority are to be observed faithfully; accordingly, no one is to add, omit, or alter anything in them on one's own authority ("nemo in iisdem quidpiam proprio marte addat, demat aut mutet"; SC 22 §3) | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann834-878_en.html

```clingo
% Two laws, two outputs: a changed form also fails the sacrament
% (sacrament.lp); every change is illicit (TTC-LITURGY RS3; CCC 1125).
enacted_by(c846_text_1983,code1983). part_of(n846,c846_text_1983).
altered_rite(E) :- form_used(E,F), celebration(E,K,_,_), not due_form(K,F).
altered_rite(E) :- alters(E,_).
illicit_change(P,E) :- altered_rite(E), celebration(E,_,P,_), event_date(E,T), norm_in_force(n846,T).
```

end

```clingo
info(doubt_referred_to_apostolic_see(E)) :- porrection_at_issue(E).
info(illicit_change(P,E)) :- illicit_change(P,E).

```

norm cic:845 | c. 845 §1: baptism, confirmation and sacred ordination imprint a character and cannot be repeated; §2: if after diligent inquiry a prudent doubt remains whether they were conferred at all or validly, they are to be conferred conditionally | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann834-878_en.html

stratum cic:845 divine

```clingo
% A doubt of fact about a condition of validity is a prudent doubt (§2). Where
% the sacrament certainly failed, it is conferred absolutely.
doubt_of_validity(E) :- celebration(E,K,_,_), imprints(K), disputed(form_used(E,_)).
doubt_of_validity(E) :- celebration(E,K,_,_), imprints(K), disputed(matter_used(E,_)).
doubt_of_validity(E) :- porrection_at_issue(E).           % a doubt the law left open (Sacramentum ordinis; TTC-LITURGY RS2)
received(R,K) :- sacramental_character(R,K,_).
to_be_conferred(R,K,conditionally) :- celebration(E,K,_,R), doubt_of_validity(E).
to_be_conferred(R,K,absolutely)    :- celebration(E,K,_,R), imprints(K), not valid(E), not repeated(E),
                                      not doubt_of_validity(E), not received(R,K).
```

end

```clingo
info(to_be_conferred(R,K,How)) :- to_be_conferred(R,K,How).

% ---------- Book IV: indulgences without days (TTC-NOVISSIMA DU3) -----------------
```

norm id1967 | Paul VI, Indulgentiarum doctrina (1 January 1967; AAS 59 (1967) 5-24), norm 4: a partial indulgence is designated "nulla addita dierum vel annorum determinatione"; the new norms are valid three months from the constitution's publication in the Acta; indulgences not confirmed become null two years after the date of the constitution | https://www.vatican.va/content/paul-vi/la/apost_constitutions/documents/hf_p-vi_apc_01011967_indulgentiarum-doctrina.html

```clingo
% The norms take force by c. 8 §1's rule (the Code of 1917's c. 9 gave the
% same three months). What the former days measured, and that nothing after
% death is measured by them, is the theological side's (novissima.lp).
promulgated(id1967,19670101). aas_issue(id1967,19670130).    % "An. et vol. LIX 30 Ianuarii 1967 N. 1"
enacted_by(id1967_norms,id1967). part_of(n_id4,id1967_norms).
lapse_date(id1967,19690101).                                  % "two years after the date of this constitution"
designated_in_days(G) :- indulgence(G,partial,T), in_days(G,_), norm_in_force(n_id4,T).
indulgence_null(G,T)  :- indulgence(G,_,TG), promulgated(id1967,TP), TG < TP, not confirmed(G,_),
                         lapse_date(id1967,TL), instant(T), TL <= T.
```

end

```clingo
info(designated_in_days_against_norm_4(G)) :- designated_in_days(G).
info(indulgence_null(G))      :- indulgence_null(G,T), eval_date(T).
info(indulgence_in_force(G))  :- indulgence(G,_,TG), eval_date(T), TG <= T, not indulgence_null(G,T).

% ---------- Book III of 1917: one human being or several (TTC-EMPIRICA TW4) ----------
```

norm cic1917:748 | CIC 1917 c. 748: "Monstra et ostenta semper baptizentur saltem sub conditione; in dubio autem unusne an plures sint homines, unus absolute baptizetur, ceteri sub conditione"; abrogated with the Code of 1917 by CIC 1983 c. 6 §1 n. 1 | https://www.iuscangreg.it/cic1917.php

```clingo
% The law computed the doubt both ways without deciding it. The canon names
% no one: the first the record names is baptized absolutely. The Code of
% 1983 has no such canon.
enacted_by(c748_text_1917,code1917). part_of(n748_1917,c748_text_1917).
c748_doubt(E) :- doubt_one_or_more(E,T), norm_in_force(n748_1917,T).
named_later(E,C) :- born_together(E,C), born_together(E,C0), C0 < C.
baptize_1917(C,absolutely)    :- c748_doubt(E), born_together(E,C), not named_later(E,C).
baptize_1917(C,conditionally) :- c748_doubt(E), born_together(E,C), named_later(E,C).
```

end

```clingo
info(to_be_baptized(C,How)) :- baptize_1917(C,How).

% ---------- Book IV: the bond of marriage (TTC-CHRIST SA10) ---------------------
```

norm cic:1057 | c. 1057 §1: the consent of the parties, legitimately manifested between persons qualified by law, makes marriage; no human power is able to supply this consent | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html

stratum cic:1057 divine

```clingo
% Consent and the canonical form are conditions typed by their law
% (sacrament.lp), so a dispensation reaches only the one that is
% ecclesiastical (c. 1127 §2).
defect_of_marriage(M,consent) :- consent_vitiated(M).
defect_of_marriage(M,canonical_form) :- marriage(M,_,_), form_binds(M), not valid_form(M).
unmet_in_marriage(M,C) :- defect_of_marriage(M,C), not dispensed(cond(matrimony,C),M).
% No encoded text governs the form of a marriage before 19 May 1918: its bond
% is not computed (TTC-SOURCES TX4).
form_unread(M) :- marriage(M,_,_), not form_code(M,_).
bond(M) :- marriage(M,_,_), not unmet_in_marriage(M,_), not form_unread(M).
ratified(M) :- bond(M), not spouse_unbaptized(M).
spouse_unbaptized(M) :- spouse(M,P), unbaptized(P).
```

norm cic:1141 | c. 1141: a marriage that is ratum et consummatum can be dissolved by no human power and by no cause, except death | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html

stratum cic:1141 divine

```clingo
violation(ratum_et_consummatum_dissolved(D,M)) :- dissolution(D,M,_,_), ratified(M), consummated(M).
```

norm cic:1142 | c. 1142: a non-consummated marriage between baptized persons, or between a baptized and a non-baptized party, can be dissolved by the Roman Pontiff for a just cause | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html

```clingo
dissolved(M,D) :- dissolution(D,M,non_consummation,_), bond(M), not consummated(M), issuer(D,A), authority(A,4).
```

norm cic:1143 | c. 1143 §1: a marriage entered into by two non-baptized persons is dissolved by the pauline privilege in favour of the faith of the party who received baptism | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann998-1165_en.html

```clingo
dissolved(M,D) :- dissolution(D,M,favour_of_faith,_), bond(M), not ratified(M).
% A declaration of nullity dissolves nothing: it finds that no bond came to
% be. It changes what the external forum holds (c. 1682 §1), never the fact,
% and never becomes an adjudged matter (c. 1643).
```

norm cic:1682 | c. 1682 §1: after the sentence declaring the nullity of the marriage has become effective, the parties whose marriage has been declared null can contract a new marriage, unless a prohibition attached to the sentence or established by the local ordinary forbids it | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1671-1716_en.html

```clingo
free_to_marry(P) :- nullity_sentence(S,M,_), sentence_effective(S), spouse(M,P), not prohibited_to_marry(P).
```

norm cic:1643 | c. 1643: cases concerning the status of persons, including cases concerning the separation of spouses, never become res iudicata | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1501-1670_en.html

```clingo
never_res_iudicata(M) :- nullity_sentence(_,M,_).
```

end

```clingo
at_issue(M) :- dissolution(_,M,_,_).
at_issue(M) :- nullity_sentence(_,M,_).
info(bond(M))    :- at_issue(M), bond(M).
info(no_bond(M)) :- at_issue(M), marriage(M,_,_), not bond(M), not form_unread(M).
info(dissolved(M,D)) :- dissolved(M,D).
info(free_to_marry(P)) :- free_to_marry(P).
info(never_res_iudicata(M)) :- never_res_iudicata(M).
info(forum_holds_null_where_bond_stands(M)) :- bond(M), nullity_sentence(S,M,_), sentence_effective(S).

% ---------- Book IV and VI: the seal (TTC-CHRIST SA7) ---------------------------
```

norm cic:983 | c. 983 §1: the sacramental seal is inviolable; therefore it is absolutely forbidden for a confessor to betray in any way a penitent in words or in any manner and for any reason | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib4-cann959-997_en.html

```clingo
% Whether the seal is of divine law "from the nature of the sacrament" is
% the theological side's (law_kind(seal, ...), through sacrament.lp); "for
% any reason" is the canon's own: no release by anyone lifts it.
violation(seal_lifted(E,Why)) :- seal_lifted(E,Why).
```

norm cic2021:1386 | c. 1386 §1: a confessor who directly violates the sacramental seal incurs a latae sententiae excommunication reserved to the Apostolic See | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
delict(P,n1386,E) :- delict_act(P,n1386,E), event_date(E,T), norm_in_force(n1386,T), not outside(P), not eastern_faithful(P).
penalty(n1386,excommunication).

% ---------- Book VI: the cleric and the minor; the Dicastery's clause (TTC-ACT N1-N5) ----
```

slot cleric(P: person)
  means "a cleric (deacon, priest or bishop)"
  say "{P} is a cleric"

norm cic2021:1398 | c. 1398 §1 n. 1: a cleric who commits an offence against the sixth commandment of the Decalogue with a minor is to be punished with deprivation of office and other just penalties, not excluding dismissal from the clerical state | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
cleric(P) :- priest(P).
cleric(P) :- deacon(P).
delict(P,n1398_1,E) :- delict_act(P,n1398_1,E), cleric(P), event_date(E,T), norm_in_force(n1398_1,T), not outside(P), not eastern_faithful(P).
penalty(n1398_1,deprivation).
element_of(n1398_1,minor).                        % the delict's matter: with a minor
```

norm sst2021:6 | Norms on delicts reserved to the Dicastery for the Doctrine of the Faith (11 October 2021), art. 6 n. 1: in the delict of c. 1398 §1 n. 1, ignorance or error on the part of the cleric regarding the age of the minor does not constitute an extenuating or exonerating circumstance; art. 29: the canons on delicts and penalties of each Code apply with the norms | https://www.vatican.va/roman_curia/congregations/cfaith/documents/rc_con_cfaith_doc_20211011_norme-delittiriservati-cfaith_en.html

```clingo
% Papal law derogates, for the age only, from cc. 1321 §3, 1323 n. 2 and 1324
% as special law; a dicastery's general decree could not (cc. 33 §1, 135 §2).
age_clause(sst2021,n1398_1).
disregarded(N,fact(minor)) :- age_clause(D,N), issuer(D,A), authority(A,4).
info(derogation_refused(D,N)) :- age_clause(D,N), issuer(D,A), authority(A,K), K < 4.
% the error about the age disregarded, culpa resting on it alone is no ground of non-punishment
other_fault(P,N,E) :- delict(P,N,E), ignorant_with_fault(P,E,Of), not disregarded(N,Of).
culpa_disregarded(P,N,E) :- delict(P,N,E), disregarded(N,Of), ignorant_with_fault(P,E,Of),
                            not interior(P,E,negligence), not other_fault(P,N,E).
info(error_disregarded(P,N,E)) :- delict(P,N,E), disregarded(N,Of), ignorance(P,E,Of,_).

% ---------- Book VI: the general norm (TTC-PENAL GP) ----------------------------
```

slot special_gravity(Authority: person, Act: act)
  means "special_gravity(Authority, Act): the competent authority's judgment that the violation's special gravity requires punishment (supplied, never computed)"
  say "{Authority} judges the special gravity of {Act} to require punishment"

slot scandal_necessity(Authority: person, Act: act)
  means "scandal_necessity(Authority, Act): the authority's judgment that necessity demands that scandals be prevented or repaired (supplied, never computed)"
  say "{Authority} judges that the need to prevent or repair scandal demands punishing {Act}"

norm cic2021:1399 | c. 1399: besides the cases prescribed in this or in other laws, the external violation of divine or canon law can be punished, and with a just penalty, only when the special gravity of the violation requires it and necessity demands that scandals be prevented or repaired | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib6-cann1364-1399_en.html

```clingo
% The violation is read from the library: an act of a kind that binds the
% person (evil by its object, or forbidden by a law that binds). Penal law is
% ecclesiastical: it reaches only those c. 11 binds.
external_violation(P,A) :- binds_for(P,A,K), kind_of_act(A,K).
named_delict(P,A) :- delict(P,N,A), N != n1399.
delict(P,n1399,A) :- external_violation(P,A), special_gravity(_,A), scandal_necessity(_,A), event_date(A,T),
                     norm_in_force(n1399,T), not outside(P), not eastern_faithful(P), not named_delict(P,A).
penalty(n1399,just_penalty).
```

end

```clingo

% ---------- Book VII: the last canon (TTC-PENAL SA) ------------------------------
```

slot transfer(Decree: act, Pastor: person, Date: date)
  means "transfer(Decree, Pastor, Date): a decree transferring a pastor (cc. 1748-1752)"
  say "by {Decree}, on {Date}, the pastor {Pastor} is transferred"

slot sets_aside(Text: source, Norm: norm, Ground: ground)
  means "candidate only: sets_aside(Text, Norm, Ground): a text treats a penalty the law attaches as not incurred, on this ground"
  say "{Text} treats the penalty of {Norm} as not incurred, on the ground {Ground}"

norm cic:1752 | c. 1752: in cases of transfer the prescripts of c. 1747 are to be applied, canonical equity is to be observed, and the salvation of souls, which must always be the supreme law in the Church, is to be kept before one's eyes | https://www.vatican.va/archive/cod-iuris-canonici/eng/documents/cic_lib7-cann1732-1752_en.html

```clingo
% It names no effect: it binds the authority deciding a transfer to keep the
% salvation of souls in view, a judgment supplied, never computed. It is not a
% power over the law: canonists never weigh against the law (rule 2); the
% law's own remedies (exemption, mitigation, remission) are the routes.
info(to_keep_in_view(D,salus_animarum)) :- transfer(D,_,_).
violation(weighing_against_law(T,N)) :- sets_aside(T,N,salus_animarum).
```

end

```clingo

% ---------- Texts checked against the derivation ------------------------------
```

norm checking | a text's claims compared with what the norms derive | -

```clingo
% A text's claim about the juridical situation is compared with what the
% norms derive for each concrete act. Disagreement is a question, not a
% verdict: either the text supplies a fact or norm the encoding lacks, or
% the text is wrong.
claim_target(A,invalid_absolution(C)) :- absolution(A,P,_,_), in_class(P,C).
claim_target(M,invalid_marriage(C))   :- marriage(M,P,_), in_class(P,C).
claim_holds(A,invalid_absolution(C)) :- claim_target(A,invalid_absolution(C)), not valid_absolution(A).
claim_holds(M,invalid_marriage(C))   :- claim_target(M,invalid_marriage(C)), not valid_form(M).
info(claim_confirmed(S,X,A))    :- asserted(S,X), asserts(S,X,TS), claim_target(A,X), event_date(A,T), T >= TS, past(A), claim_holds(A,X).
info(claim_contradicted(S,X,A)) :- asserted(S,X), asserts(S,X,TS), claim_target(A,X), event_date(A,T), T >= TS, past(A), not claim_holds(A,X).

% A statement about a class is not a declaration about any person in it.
info(class_statement_not_declaration(S,C)) :- asserted(S,status(C,_)), not declares(S,_,_).
violation(collective_declaration(S,C)) :- treated_as_declaring(S,C), asserts(S,status(C,_),_).

#show assumed_fact/1.
```
