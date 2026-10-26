% ===================================================================
%  The tongues (TTC-LINGUAE): "variis linguis" (Acts 2:4).
%
%  The word thought in the heart is "nec Graecum nec Latinum nec linguae
%  alicuius alterius" (Augustine, De Trinitate XV.10.19); spoken sounds are
%  signs of it, and the signs differ between peoples while what they
%  signify does not (De interpretatione 1; In Peryerm. I lect. 2). So the
%  word takes no date and no parent in time; the date, the parent and the
%  drift belong to the encoding. An encoding is a tongue in a script, or a
%  signed language, over a span of years; a text is one encoding of one
%  edition of a source; a form is a span of a text, as given. A signed form
%  comes through a notation, which is a scheme with a claimant. Perceiving
%  a form is the senses step's.
%
%  A rendering's mode is computed, never entered: univocal where both forms
%  mean one word; analogical where they mean two and one is declared
%  analogous to the other ("secundum analogiam, idest proportionem", ST I
%  q. 13 a. 5); equivocal otherwise; a gap where a host form has no
%  rendering. What a form means is its lexicon's claim, with its claimant
%  and date, and rival lexicons run both ways. A rendering also keeps,
%  closes or opens the host's readings, which are exegesis with claimants.
%  A hearing is a horizon with a declared lexicon, never a person (rule 3),
%  and every mode is indexed by hearing. An authority's statement of a mode
%  is a claim with its unit: it weighs at its tier and never fixes.
%
%  Liturgiam authenticam, Comme le prevoit and Magnum principium run as
%  three regimes of what counts as faithful (the switches below), and none
%  is preferred. Which governed a book's approval is c. 838's, at its date
%  (canon_law.lp). The word is of no tongue in the default runtime (the
%  part word_of_no_tongue); Saussure's runtime divides it by tongue
%  (schools.lp).
%
%  @library  (read by norms.py: its predicates count as defined)
% ===================================================================

% @input word_of_no_tongue/0 | the default runtime's part: words are the order of reason's, and two encodings can mean one word
% @input word_by_division/0 | Saussure's runtime: a word is a value in one encoding at its date
% @input verbum_vocal/0 | the vocal runtime: a verbum is a vox, a significant sound
% @input verbum_lingual/0 | the lingual runtime: a verbum is a conventional sign of the inner word in a human language, by any route
% @input encoding/4 | encoding(E, Tongue, From, To): a tongue in a script, or a signed language, over a span of years
% @input encoding_route/2 | encoding_route(E, written | manual): how the encoding's forms are given
% @input encoding_from/3 | encoding_from(E2, E1, C): the encoding E2 descends from E1, by the claimant C
% @input variety_of/3 | variety_of(E2, E1, C): E2 is a variety of E1, not an encoding made from it, by C
% @input code_of/2 | code_of(E2, E1): E2 is a manual code of the tongue E1 (Signing Exact English of English)
% @input lexicon/4 | lexicon(C, E, Year, Kind): a lexicon of E at its year, of a kind (dictionary, register, grammar, gloss, database)
% @input text_of/4 | text_of(T, S, E, Year): T encodes the source S in E, dated Year
% @input made_from/2 | made_from(T2, T1): T2 is a translation made from T1
% @input revises/2 | revises(T2, T1): T2 is a new edition of T1's source: it changes the word, and is no rendering
% @input form_in/3 | form_in(F, T, Locus): the form F is a span of the text T at the locus
% @input signifies/3 | signifies(F, W, C): under its encoding the form F signifies the word W, by the lexicon C
% @input form_reading/3 | form_reading(F, R, C): R is a reading of the host form F, by C (exegesis)
% @input admits/3 | admits(F, R, C): under C's lexicon the form F admits the reading R
% @input analogous/4 | analogous(W2, W1, K, C): in the order of reason W2 is said of W1's ratio by analogy of kind K, by C
% @input broader/3 | broader(W2, W1, C): W2's ratio covers W1's and more, by C
% @input carries/3 | carries(W2, W1, P): an analogical rendering whose words are W2 for W1 carries the premise P
% @input renders/2 | renders(F2, F1): F2 is given for F1
% @input host_declared/3 | host_declared(F2, F1, C): a rendering of a rendering declares its host, by C
% @input measured_by/3 | measured_by(F1, F2, C): C takes the form F2 as the measure of F1; no descent (TTC-PENDET)
% @input rests_on_form/3 | rests_on_form(A, P, F): the argument A's premise P rests on the host form F
% @input hears_in/3 | hears_in(G, E, C): the horizon G hears in E by the lexicon C; never a person
% @input hears_under/2 | hears_under(G, C): the horizon G hears under C's rule of hearing
% @input hearing_rule/3 | hearing_rule(C, F2, F1): C lays down that F2 is to be heard by F1 (CDF 1974; the decree of 2021, n. 21)
% @input horizon_lacks/3 | horizon_lacks(G, P, C): the horizon G cannot hold the premise P, by C
% @input mode_claim/5 | mode_claim(C, F2, F1, M, U): C states the mode M of F2 for F1, in the unit U
% @input fixes_mode/3 | candidate only: fixes_mode(C, F2, F1), C's mode claim treated as fixing the mode
% @input catechesis_rule/3 | catechesis_rule(C, F2, R): C sends the reading R of F2 to catechesis (LA 29; CLP 31)
% @input message/3 | message(F1, R, C): C names R the message of F1 (CLP 6, 9)
% @input reading_holds/3 | reading_holds(R, Q, V): the reading R holds V on the question Q
% @input span_kind/2 | span_kind(F, K): the host form is in a biblical or an anaphoral text (CLP 31, 33)
% @input idiomatic/3 | idiomatic(F2, E, C): F2 keeps the character of the tongue E, by C (MP)
% @input unrendered/3 | unrendered(F2, F1, W): a word of the host form F1 has no counterpart in F2 (LA 20)
% @input order_changed/3 | order_changed(F2, F1, C): F2 changes F1's order where its tongue allows it kept, by C (LA 57)
% @input formula_of/2 | formula_of(F, K): F is the sacramental form of K as the Church gives it
% @input form_for/2 | form_for(F, K): F is a form used or put forward for K
% @input form_feature/4 | form_feature(F, Feature, Value, C): what the form expresses (minister_act, trinity_invoked, addressee), by C
% @input corruption_at/2 | corruption_at(F, start | end): the form is ill-formed in its encoding, at its start or its end
% @input form_agent/3 | form_agent(F, X, C): the form names X as the one who acts, by C
% @input rite_given/5 | rite_given(E, K, M, R, F): in the act E, M gave R the sacrament K with the form F, as notated
% @input consent_given/3 | consent_given(M, P, F): at the marriage M, the party P manifested consent by the form F
% @input confession_given/3 | confession_given(A, P, F): in the act A, the penitent P confessed by the form F
% @input depicts/3 | depicts(F, M, C): the sign F depicts the manner M (BAPTIZE as immersion), by C
% @input manner_used/2 | manner_used(E, M): the matter was used in the manner M (infusion)
% @input canon_verbum/2 | candidate only: canon_verbum(L, vocal | lingual), a runtime's reading of verba in the canon L
% @input notated/3 | notated(F, N, C): the performance F is given in the notation N by the transcriber C
% @input notation_kind/2 | notation_kind(N, K): the scheme of N (gloss, id_gloss, stokoe, hamnosys, signwriting, annotation)
% @input notation_tier/3 | notation_tier(N, Tier, full | partial): a tier the notation carries (manual, nonmanual)
% @input token/4 | token(F, N, I, T): the I-th token of F in the notation N
% @input presumes/3 | presumes(T, Cat, C): the gloss token T presumes the grammatical category Cat, by C
% @input nonmanual_mark/3 | nonmanual_mark(F, N, M): the notation N marks on F what the face and body carry (brows_raised)
% @input practice_teaches/3 | practice_teaches(C, S, Q): C claims that the practice S teaches on Q (Ecclesiae praxis aliquando docet)
% @input rests_on_practice/3 | rests_on_practice(S2, Q, S): S2 rests its value on the doctrinal question Q on the practice S alone
% @input date_claimed/3 | date_claimed(S, D, C): C dates the act S to the day D
% @input date_claim/2 | saeculum.lp
% @input text_year/2 | sources.lp
% @input in_order/1 | saeculum.lp: an event placed in the order
% @input fixed_by/3 | empirica.lp: a finding fixes an empirical question
% @input person/1 | the kernel

% ---------- Encodings and texts (LW3, LW4, SG9) -----------------------------
tongue_of(E,T)      :- encoding(E,T,_,_).
same_tongue(E1,E2)  :- tongue_of(E1,T), tongue_of(E2,T).
text_enc(T,E)       :- text_of(T,_,E,_).
text_date(T,Y)      :- text_of(T,_,_,Y).
form_enc(F,E)       :- form_in(F,T,_), text_enc(T,E).
manual_form(F)      :- form_enc(F,E), encoding_route(E,manual).
% A text is not older than its parent, and no text descends from itself, as
% no rite does (liturgy.lp: rite_from_later, rite_descends_from_itself).
made_after(T2,T1)   :- made_from(T2,T1).
made_after(T3,T1)   :- made_from(T3,T2), made_after(T2,T1).
violation(made_before_parent(T2,T1)) :- made_from(T2,T1), text_date(T2,Y2), text_date(T1,Y1), Y2 < Y1.
violation(translation_cycle(T))      :- made_after(T,T).
% A word is no encoding's parent: an Adamic tongue, a perfect language, or a
% reconstruction taken as the word is refused on every runtime, as God is
% refused at the apex of the order (A11; cand_apex). A proto-language
% enters as an encoding, with its claimant.
violation(word_as_root(W)) :- encoding_from(_,W,_), word(W).
violation(variety_entered_as_descent(E2,E1)) :- variety_of(E2,E1,_), encoding_from(E2,E1,_).
% Every meaning cites a lexicon with its year and kind; a lexicon of an
% encoding outside the encoding's span is refused.
lexicon_named(C) :- lexicon(C,_,_,_).
violation(meaning_without_lexicon(F,C)) :- signifies(F,_,C), not lexicon_named(C).
violation(lexicon_out_of_span(C,E))     :- lexicon(C,E,Y,_), encoding(E,_,From,_), Y < From.
violation(lexicon_out_of_span(C,E))     :- lexicon(C,E,Y,_), encoding(E,_,_,To), Y > To.

% ---------- Words: of no tongue, or a value in one (LW1, LW2) ----------------
word(W) :- signifies(_,W,_).
word(W) :- analogous(W,_,_,_).
word(W) :- analogous(_,W,_,_).
words_one :- word_of_no_tongue, not word_by_division.
% A word given a date, or a place in the order of time, is refused on the
% default runtime, as a procession placed in time is (saeculum.lp).
word_in_time(W) :- word(W), date_claim(W,_).
word_in_time(W) :- word(W), text_year(W,_).
word_in_time(W) :- word(W), in_order(W).
violation(word_dated(W)) :- word_in_time(W), words_one.

% ---------- What a form means: one lexicon per branch ------------------------
% A database of forms gives no meanings: its entries are identifiers, not
% definitions, so a lexicon's token number never supplies a meaning (SG4).
database(C)     :- lexicon(C,_,_,database).
usable(F,W,C)   :- signifies(F,W,C), not database(C).
info(meaning_not_supplied(F,C)) :- signifies(F,_,C), database(C).
lexical(F,C)    :- usable(F,_,C).
% Two lexicons that give a form the same words are one reading of it; rival
% lexicons are computed both ways.
lex_differs(F,C1,C2) :- usable(F,W,C1), lexical(F,C2), not usable(F,W,C2).
lex_alike(F,C1,C2)   :- lexical(F,C1), lexical(F,C2), C1 < C2, not lex_differs(F,C1,C2), not lex_differs(F,C2,C1).
lex_shadowed(F,C2)   :- lex_alike(F,_,C2).
lex_option(F,C)      :- lexical(F,C), not lex_shadowed(F,C).
{ lexicon_read(F,C) : lex_option(F,C) } :- lexical(F,_).
lex_chosen(F) :- lexicon_read(F,_).
:- lexical(F,_), not lex_chosen(F).
:- lexicon_read(F,C1), lexicon_read(F,C2), C1 < C2.
lex_rival(F) :- lex_option(F,C1), lex_option(F,C2), C1 < C2.
assumed_fact(read_by(F,C)) :- lexicon_read(F,C), lex_rival(F).
assumed_fact(read_by(F,C)) :- lexicon_read(F,C0), lex_alike(F,C0,C), lex_rival(F).
means_now(F,W) :- lexicon_read(F,C), usable(F,W,C).

% ---------- Renderings: not a revision, not a code (CC1, SG2) ----------------
% Whether a form is given for a host form at all, or the host has a gap
% there, may be disputed (RN2): both ways.
{ renders(F2,F1) } :- disputed(renders(F2,F1)).
assumed_fact(renders(F2,F1))        :- disputed(renders(F2,F1)), renders(F2,F1).
assumed_fact(false(renders(F2,F1))) :- disputed(renders(F2,F1)), not renders(F2,F1).
given_for(F2,F1) :- renders(F2,F1).
given_for(F2,F1) :- host_declared(F2,F1,_).
% A rendering of a rendering is computed against its declared host and,
% through it, the host's own host.
given_for(F3,F1) :- host_declared(F3,F2,_), renders(F2,F1).
edition(T2,T1) :- revises(T2,T1).
edition(T1,T2) :- revises(T2,T1).
no_mode(F2,F1,revision) :- given_for(F2,F1), form_in(F2,T2,_), form_in(F1,T1,_), edition(T2,T1).
no_mode(F2,F1,code)     :- given_for(F2,F1), form_enc(F2,E2), form_enc(F1,E1), code_of(E2,E1).
info(no_mode(F2,F1,Why)) :- no_mode(F2,F1,Why).
rendering(F2,F1) :- given_for(F2,F1), not no_mode(F2,F1,_).
renders_text(T2,T1) :- made_from(T2,T1).
renders_text(T2,T1) :- rendering(F2,F1), form_in(F2,T2,_), form_in(F1,T1,_).
rendered_in(F1,T2)  :- rendering(F2,F1), form_in(F2,T2,_).
% A text encodes an edition; where a later edition revises it, the text
% still encodes the earlier word (CC2).
info(superseded_encoding(T,T2)) :- revises(T2,T1), text_of(T1,S,_,_), text_of(T,S,_,_).

% ---------- The mode, computed (LW2, RN, CC1, PM, BF1) -----------------------
across(F2,F1)   :- rendering(F2,F1), form_enc(F2,E2), form_enc(F1,E1), E2 != E1.
one_word(F2,F1) :- rendering(F2,F1), means_now(F2,W), means_now(F1,W), words_one.
one_word(F2,F1) :- rendering(F2,F1), means_now(F2,W), means_now(F1,W), not across(F2,F1).
analogy(F2,F1,K) :- rendering(F2,F1), means_now(F2,W2), means_now(F1,W1), analogous(W2,W1,K,_), not one_word(F2,F1).
analogical(F2,F1) :- analogy(F2,F1,_).
mode_of(F2,F1,univocal)   :- one_word(F2,F1).
mode_of(F2,F1,analogical) :- analogical(F2,F1).
worded(F1) :- means_now(F1,_).
mode_of(F2,F1,equivocal)  :- rendering(F2,F1), worded(F1), not one_word(F2,F1), not analogical(F2,F1).
info(mode(F2,F1,M))           :- mode_of(F2,F1,M).
% The host may itself speak by analogy ("velut formam quamdam"): the premise
% that rests on it is then typed by that analogy's kind (RN6).
info(premise_by_analogy(A,P,K)) :- rests_on_form(A,P,F1), means_now(F1,W1), analogous(W1,_,K,_).
info(analogy_kind(F2,F1,K))   :- analogy(F2,F1,K).
kept_ratio(F2,F1) :- one_word(F2,F1).
kept_ratio(F2,F1) :- analogical(F2,F1).
info(extent(F2,F1,wider))     :- kept_ratio(F2,F1), means_now(F2,W2), means_now(F1,W1), broader(W2,W1,_).
info(extent(F2,F1,narrower))  :- kept_ratio(F2,F1), means_now(F2,W2), means_now(F1,W1), broader(W1,W2,_).
% An analogy declared without one of the three kinds is refused; carriage
% entered on an equivocal pair is refused.
analogy_kind(attribution;proportionality;metaphor) :- analogous(_,_,_,_).
violation(analogy_without_kind(W2,W1)) :- analogous(W2,W1,K,_), not analogy_kind(K).
violation(equivocation_carried(F2,F1)) :- carries(W2,W1,_), mode_of(F2,F1,equivocal), means_now(F2,W2), means_now(F1,W1).
% A gap: a form an argument rests on, with no rendering in a text that
% renders its own.
gap(F1,T2) :- rests_on_form(_,_,F1), form_in(F1,T1,_), renders_text(T2,T1), not rendered_in(F1,T2).
info(gap(F1,T2)) :- gap(F1,T2).

% ---------- Readings kept, closed, opened (PM1, BF3, LM2) --------------------
host_reading(F1,R) :- form_reading(F1,R,_).
host_typed(F1)     :- form_reading(F1,_,_).
admitted(F,R)      :- admits(F,R,_).
typed(F)           :- admits(F,_,_).
closes(F2,F1,R) :- rendering(F2,F1), host_reading(F1,R), typed(F2), not admitted(F2,R).
opens(F2,F1,R)  :- rendering(F2,F1), admitted(F2,R), host_typed(F1), not host_reading(F1,R).
interpretation(F2,F1,R) :- rendering(F2,F1), host_reading(F1,R), admitted(F2,R), closes(F2,F1,_).
info(closes(F2,F1,R))         :- closes(F2,F1,R).
info(opens(F2,F1,R))          :- opens(F2,F1,R).
info(interpretation(F2,F1,R)) :- interpretation(F2,F1,R).

% ---------- What a rendering carries (RN) ------------------------------------
% A univocal rendering carries every premise of its host form; an analogical
% one only what carries/3 names for its words.
carried(F2,F1,P) :- one_word(F2,F1), rests_on_form(_,P,F1).
carried(F2,F1,P) :- analogical(F2,F1), means_now(F2,W2), means_now(F1,W1), carries(W2,W1,P).
info(carried(F2,F1,P)) :- carried(F2,F1,P).
% The argument, in each encoding that renders its host: a premise is kept
% where every form it rests on carries it, and lost by gap, equivocation, or
% an analogy that does not carry it.
guest_text(A,T2) :- rests_on_form(A,_,F1), form_in(F1,T1,_), renders_text(T2,T1).
lost_at(A,T2,P,gap)       :- rests_on_form(A,P,F1), gap(F1,T2).
lost_at(A,T2,P,equivocal) :- rests_on_form(A,P,F1), rendering(F2,F1), form_in(F2,T2,_), mode_of(F2,F1,equivocal).
lost_at(A,T2,P,no_carry)  :- rests_on_form(A,P,F1), rendering(F2,F1), form_in(F2,T2,_), analogical(F2,F1),
                             not carried(F2,F1,P).
lost_text(A,T2,P)  :- lost_at(A,T2,P,_).
carried_at(A,T2,P) :- rests_on_form(A,_,F1), rendering(F2,F1), form_in(F2,T2,_), carried(F2,F1,P).
info(carried_in(A,E,P))   :- carried_at(A,T2,P), not lost_text(A,T2,P), text_enc(T2,E).
info(lost_in(A,E,P,Why))  :- lost_at(A,T2,P,Why), text_enc(T2,E).

% ---------- A measure, beside descent (TTC-PENDET MS) -----------------------
% C takes F2 as the measure of F1, as a person may take the tongue he prays
% in. F1 is then read as given for F2: its mode, its readings closed and
% opened, its interpretations. No descent follows (no made_from/2; LW3 does
% not see it), and a measure carries nothing: carriage follows descent only.
% The measure's admitted readings count as its host readings, and the
% measured form's host readings as what it admits, so a pair is read either
% way. An analogy is found whichever of its two words the measure has; the
% word declared prior stays prior as to the thing, "quantum ad rem
% significatam", and the measure's own word is prior as to us, "quantum ad
% impositionem nominis" (I q. 13 a. 6).
measured_pair(F1,F2) :- measured_by(F1,F2,_).
m_across(F1,F2) :- measured_pair(F1,F2), form_enc(F1,E1), form_enc(F2,E2), E1 != E2.
m_one_word(F1,F2) :- measured_pair(F1,F2), means_now(F1,W), means_now(F2,W), words_one.
m_one_word(F1,F2) :- measured_pair(F1,F2), means_now(F1,W), means_now(F2,W), not m_across(F1,F2).
% m_analogy(F1,F2,K,Prior,W2): the analogy of kind K, the word declared prior, the measure's word.
m_analogy(F1,F2,K,W2,W2) :- measured_pair(F1,F2), means_now(F1,W1), means_now(F2,W2), analogous(W1,W2,K,_),
                            not m_one_word(F1,F2).
m_analogy(F1,F2,K,W1,W2) :- measured_pair(F1,F2), means_now(F1,W1), means_now(F2,W2), analogous(W2,W1,K,_),
                            not m_one_word(F1,F2).
m_analogical(F1,F2) :- m_analogy(F1,F2,_,_,_).
m_mode(F1,F2,univocal)   :- m_one_word(F1,F2).
m_mode(F1,F2,analogical) :- m_analogical(F1,F2).
m_mode(F1,F2,equivocal)  :- measured_pair(F1,F2), worded(F2), not m_one_word(F1,F2), not m_analogical(F1,F2).
info(mode(F1,F2,M))          :- m_mode(F1,F2,M).
info(analogy_kind(F1,F2,K))  :- m_analogy(F1,F2,K,_,_).
info(prius_rei(F1,F2,W))     :- m_analogy(F1,F2,_,W,_).
info(prius_nobis(F1,F2,W))   :- m_analogy(F1,F2,_,_,W).
m_closes(F1,F2,R) :- measured_pair(F1,F2), admitted(F2,R), host_typed(F1), not host_reading(F1,R).
m_opens(F1,F2,R)  :- measured_pair(F1,F2), host_reading(F1,R), typed(F2), not admitted(F2,R).
info(closes(F1,F2,R)) :- m_closes(F1,F2,R).
info(opens(F1,F2,R))  :- m_opens(F1,F2,R).
info(interpretation(F1,F2,R)) :- m_closes(F1,F2,_), admitted(F2,R), host_reading(F1,R).

% ---------- Hearings: a horizon with a lexicon, never a person (LM1, LM3) ----
violation(hearing_of_a_person(G))   :- hears_in(G,_,_), person(G).
violation(hearing_without_lexicon(G)) :- hears_in(G,E,C), not lexicon(C,E,_,_).
hearing(G,E) :- hears_in(G,E,_).
{ hear_by(G,E,C) : hears_in(G,E,C) } :- hearing(G,E).
heard_one(G,E) :- hear_by(G,E,_).
:- hearing(G,E), not heard_one(G,E).
:- hear_by(G,E,C1), hear_by(G,E,C2), C1 < C2.
hearing_rival(G,E) :- hears_in(G,E,C1), hears_in(G,E,C2), C1 < C2.
assumed_fact(heard_by(G,E,C)) :- hear_by(G,E,C), hearing_rival(G,E).
heard(G,F,C)    :- hear_by(G,E,C), form_enc(F,E2), same_tongue(E,E2).
hears_form(G,F) :- heard(G,F,_).
means_for(G,F,W) :- heard(G,F,C), usable(F,W,C).
% A rule of hearing (CDF, 1974: an approved version is to be understood by
% the Latin; the decree of 2021, n. 21): a hearer under it admits for the
% version exactly its host's readings, and the rule is reported.
by_rule(G,F2,F1,C) :- hears_under(G,C), hearing_rule(C,F2,F1), hears_form(G,F2).
ruled(G,F2) :- by_rule(G,F2,_,_).
info(heard_by_rule(G,F2,C)) :- by_rule(G,F2,_,C).
admitted_for(G,F2,R) :- heard(G,F2,C), admits(F2,R,C), not ruled(G,F2).
admitted_for(G,F2,R) :- by_rule(G,F2,F1,_), host_reading(F1,R).
typed_for(G,F2) :- admitted_for(G,F2,_).
% The host's words for the hearer: his own, where he hears its tongue.
host_means(G,F1,W) :- rendering(F2,F1), hears_form(G,F2), hears_form(G,F1), means_for(G,F1,W).
host_means(G,F1,W) :- rendering(F2,F1), hears_form(G,F2), not hears_form(G,F1), means_now(F1,W).
heard_rendering(G,F2,F1) :- rendering(F2,F1), hears_form(G,F2).
one_word_for(G,F2,F1) :- heard_rendering(G,F2,F1), means_for(G,F2,W), host_means(G,F1,W), words_one.
one_word_for(G,F2,F1) :- heard_rendering(G,F2,F1), means_for(G,F2,W), host_means(G,F1,W), not across(F2,F1).
analogical_for(G,F2,F1) :- heard_rendering(G,F2,F1), means_for(G,F2,W2), host_means(G,F1,W1), analogous(W2,W1,_,_),
                           not one_word_for(G,F2,F1).
mode_for(G,F2,F1,univocal)   :- one_word_for(G,F2,F1).
mode_for(G,F2,F1,analogical) :- analogical_for(G,F2,F1).
host_worded(G,F1) :- host_means(G,F1,_).
mode_for(G,F2,F1,equivocal)  :- heard_rendering(G,F2,F1), host_worded(G,F1), not one_word_for(G,F2,F1),
                                not analogical_for(G,F2,F1).
info(mode_for(G,F2,F1,M)) :- mode_for(G,F2,F1,M).
closes_for(G,F2,F1,R) :- heard_rendering(G,F2,F1), host_reading(F1,R), typed_for(G,F2), not admitted_for(G,F2,R).
opens_for(G,F2,F1,R)  :- heard_rendering(G,F2,F1), admitted_for(G,F2,R), host_typed(F1), not host_reading(F1,R).
interpretation_for(G,F2,F1,R) :- heard_rendering(G,F2,F1), host_reading(F1,R), admitted_for(G,F2,R),
                                 closes_for(G,F2,F1,_).
info(closes_for(G,F2,F1,R))         :- closes_for(G,F2,F1,R).
info(opens_for(G,F2,F1,R))          :- opens_for(G,F2,F1,R).
info(interpretation_for(G,F2,F1,R)) :- interpretation_for(G,F2,F1,R).
carried_for_form(G,F2,F1,P) :- one_word_for(G,F2,F1), rests_on_form(_,P,F1).
carried_for_form(G,F2,F1,P) :- analogical_for(G,F2,F1), means_for(G,F2,W2), host_means(G,F1,W1), carries(W2,W1,P).
% The argument heard: a loss by encoding (the rendering heard) and a loss by
% horizon (what the hearer cannot hold) are reported apart (RN5).
heard_text(G,A,T2) :- guest_text(A,T2), form_in(F2,T2,_), hears_form(G,F2).
lost_for(G,A,P,gap)       :- heard_text(G,A,T2), rests_on_form(A,P,F1), gap(F1,T2).
lost_for(G,A,P,equivocal) :- rests_on_form(A,P,F1), heard_rendering(G,F2,F1), mode_for(G,F2,F1,equivocal).
lost_for(G,A,P,no_carry)  :- rests_on_form(A,P,F1), heard_rendering(G,F2,F1), analogical_for(G,F2,F1),
                             not carried_for_form(G,F2,F1,P).
lost_heard(G,A,P) :- lost_for(G,A,P,_).
carried_heard(G,A,P) :- rests_on_form(A,_,F1), heard_rendering(G,F2,F1), carried_for_form(G,F2,F1,P).
info(carried_for(G,A,P))   :- carried_heard(G,A,P), not lost_heard(G,A,P).
info(lost_for(G,A,P,Why))  :- lost_for(G,A,P,Why).
heard_argument(G,A) :- rests_on_form(A,_,F1), hears_form(G,F1).
heard_argument(G,A) :- heard_text(G,A,_).
info(lost_by_horizon(G,A,P)) :- heard_argument(G,A), rests_on_form(A,P,_), horizon_lacks(G,P,_).

% ---------- Claims of a mode: they weigh and never fix (PM5, LM1) -----------
claim_agrees(C,F2,F1) :- mode_claim(C,F2,F1,M,word), mode_of(F2,F1,M).
claim_agrees(C,F2,F1) :- mode_claim(C,F2,F1,interpretation,word), interpretation(F2,F1,_).
info(mode_claim_agrees(C,F2,F1))  :- claim_agrees(C,F2,F1).
info(mode_claim_differs(C,F2,F1)) :- mode_claim(C,F2,F1,_,word), rendering(F2,F1), not claim_agrees(C,F2,F1).
info(units_differ(C1,C2,F2,F1))   :- mode_claim(C1,F2,F1,_,U1), mode_claim(C2,F2,F1,_,U2), C1 < C2, U1 != U2.
info(mode_claim_weighs(C,F2,F1,T)) :- mode_claim(C,F2,F1,_,_), in_force(C), eff_tier(C,T).
violation(mode_fixed_by_claim(C,F2,F1)) :- fixes_mode(C,F2,F1), mode_claim(C,F2,F1,_,_).

% ---------- What the regimes read (the switches below) -----------------------
message_admitted(G,F2,F1) :- heard_rendering(G,F2,F1), message(F1,R,_), admitted_for(G,F2,R).
contrary_for(G,F2,R,Q) :- admitted_for(G,F2,R), reading_holds(R,Q,V), question_kind(Q,doctrinal), holds(Q,W), W != V.
contrary_heard(G,F2) :- contrary_for(G,F2,_,_).
info(contrary_for(G,F2,R,Q)) :- contrary_for(G,F2,R,Q).
% A rendering that closes what the text says: the doctrinal question is
% answered by its own sources, never by what a rendering closes (PM6).
violation(rendering_answers(S,Q,F2)) :- rests_on_rendering(S,Q,F2), question_kind(Q,doctrinal), in_force(S).

% ---------- Sacramental forms: features, corruption (BF, SG) ----------------
featured(F,Ft) :- form_feature(F,Ft,_,_).
{ feature(F,Ft,V) : form_feature(F,Ft,V,_) } :- featured(F,Ft).
feature_one(F,Ft) :- feature(F,Ft,_).
:- featured(F,Ft), not feature_one(F,Ft).
:- feature(F,Ft,V1), feature(F,Ft,V2), V1 < V2.
feature_rival(F,Ft) :- form_feature(F,Ft,V1,_), form_feature(F,Ft,V2,_), V1 < V2.
assumed_fact(feature(F,Ft,V)) :- feature(F,Ft,V), feature_rival(F,Ft).
info(feature(F,Ft,V)) :- feature(F,Ft,V).
% Each feature against the Church's form: the same value; a gap where the
% form leaves it unexpressed, which is no defect (Florence accepts the Greek
% passive, DH 1314); otherwise a contrary.
compared(F,F0) :- rendering(F,F0), featured(F0,_).
compared(F,F0) :- form_for(F,K), formula_of(F0,K), F != F0.
feature_mode(F,F0,Ft,univocal)  :- compared(F,F0), feature(F0,Ft,V), feature(F,Ft,V).
feature_mode(F,F0,Ft,gap)       :- compared(F,F0), feature(F0,Ft,V0), feature(F,Ft,unexpressed), V0 != unexpressed.
feature_mode(F,F0,Ft,equivocal) :- compared(F,F0), feature(F0,Ft,V0), feature(F,Ft,V), V != V0, V != unexpressed.
info(feature_mode(F,F0,Ft,M)) :- feature_mode(F,F0,Ft,M).
% Which features belong to the substance is teaching (classification/3);
% the step only reads it.
substance_feature(K,Ft) :- of_kind(feature(K,Ft),of_substance).
% A form corrupt at its end is read by the accommodation of use; at its
% start its sense is lost (III q. 60 a. 7 ad 3; Zachary, c. 746).
info(read_by_accommodation(F)) :- corruption_at(F,end).
info(sense_lost(F))            :- corruption_at(F,start).
% The agent a form names, for the Grammar of the Icon (icon_theory.lp, BF5).
agent_named(F,X) :- form_agent(F,X,_).

% ---------- Verba: a vox, or a sign of a human language (SG-R, SG0) ---------
% Whether a sign of a signed language is a verbum is a reading the runtimes
% divide: a vox, a significant sound (Aristotle, De int. 2; Isidore; Thomas's
% definitions); or a conventional sign of the inner word in a human
% language, by any route (De Trinitate XV.10.19; III q. 60 a. 6). The
% default runs both; each runtime's branch names its part in read_as.
at_issue(F) :- rite_given(_,_,_,_,F).
at_issue(F) :- consent_given(_,_,F).
verbum_at_issue :- at_issue(F), manual_form(F).
1 { verbum_as(vocal); verbum_as(lingual) } 1 :- verbum_at_issue.
verbum_as(vocal)   :- verbum_at_issue, verbum_vocal.
verbum_as(lingual) :- verbum_at_issue, verbum_lingual.
read_as(verbum,verbum_vocal)   :- verbum_as(vocal).
read_as(verbum,verbum_lingual) :- verbum_as(lingual).
rite_at_issue    :- rite_given(_,_,_,_,F), manual_form(F).
consent_at_issue :- consent_given(_,_,F), manual_form(F).
reads_verba(c849,R)    :- verbum_as(R), rite_at_issue.
reads_verba(c1104_2,R) :- verbum_as(R), consent_at_issue.
reads_verba(L,R)       :- canon_verbum(L,R).
violation(verba_read_two_ways(L1,L2)) :- reads_verba(L1,R1), reads_verba(L2,R2), L1 < L2, R1 != R2.
% A signed language is a human language, signifying by convention, from the
% year findings fix it (empirica.lp); a homesign has no such finding.
language_fixed(E) :- tongue_of(E,T), fixed_by(q(human_language(T)),yes,_), fixed_by(q(signifies_by_convention(T)),yes,_).
verba(F) :- at_issue(F), not manual_form(F).
verba(F) :- at_issue(F), manual_form(F), verbum_as(lingual), form_enc(F,E), language_fixed(E).
signa(F) :- at_issue(F), not verba(F).
info(read_as_verba(F)) :- verba(F), manual_form(F).
info(read_as_signa(F)) :- signa(F).
% A claimant's reading of manual forms as words reaches only the encodings it
% names: a manual code of a tongue has no finding of its own (SG2).
info(no_claimant(F,E)) :- manual_form(F), form_enc(F,E), code_of(E,_), not language_fixed(E).
% A finding fixes no reading of the law, as it settles no doctrine (SG0).
violation(finding_on_a_doctrine(F,Q)) :- finding(F,Q,_,Y), question_kind(Q,juridical), asof(A), Y <= A.
% Where a form is in doubt (c. 869 §1, canon_law.lp): signs not verba, or a
% feature of the substance given two ways (the record disputes it). A form
% contrary on such a feature, undisputed, is no doubt: it is the response's.
form_in_doubt(F) :- rite_given(_,_,_,_,F), signa(F).
form_in_doubt(F) :- rite_given(_,K,_,_,F), feature_rival(F,Ft), substance_feature(K,Ft).
info(confession_by_form(A,P,F)) :- confession_given(A,P,F).
info(iconic_manner_differs(F,E)) :- rite_given(E,_,_,_,F), depicts(F,M1,_), manner_used(E,M2), M1 != M2.

% ---------- Notations: a scheme with a claimant (SG1, SG4) -------------------
gloss_notation(N) :- notation_kind(N,gloss).
has_tier(N,X) :- notation_tier(N,X,_).
violation(gloss_as_word(F)) :- token(F,N,_,T), gloss_notation(N), word(T).
info(notation_gap(F,N,nonmanual))     :- notated(F,N,_), not has_tier(N,nonmanual).
info(notation_partial(F,N,nonmanual)) :- notated(F,N,_), notation_tier(N,nonmanual,partial).
info(gloss_presumes_category(F,Cat))  :- token(F,N,_,T), gloss_notation(N), presumes(T,Cat,_).
token_at(F,N,I) :- token(F,N,I,_).
info(transcriptions_differ(F,N1,N2)) :- token(F,N1,I,T1), token(F,N2,I,T2), N1 < N2, T1 != T2.
info(transcriptions_differ(F,N1,N2)) :- token(F,N1,I,_), notated(F,N2,_), N1 != N2, token_at(F,N2,_), not token_at(F,N2,I).
info(clause_read(F,N,yes_no_question)) :- notated(F,N,_), has_tier(N,nonmanual), nonmanual_mark(F,N,brows_raised).
info(clause_read(F,N,statement))       :- notated(F,N,_), has_tier(N,nonmanual), not nonmanual_mark(F,N,brows_raised).
info(clause_read(F,N,unmarked))        :- notated(F,N,_), not has_tier(N,nonmanual).

% ---------- Practice, and the dates of an act (SG5, SG5a) --------------------
% A claim that the Church's practice teaches weighs with its claimant and has
% no tier; a doctrinal value resting on practice alone is refused.
info(practice_claim(C,S,Q)) :- practice_teaches(C,S,Q).
violation(validity_from_practice(S2,Q)) :- rests_on_practice(S2,Q,_), question_kind(Q,doctrinal), in_force(S2).
info(dated_two_ways(S,D1,D2)) :- date_claimed(S,D1,_), date_claimed(S,D2,_), D1 < D2.
% @input rests_on_rendering/3 | rests_on_rendering(S, Q, F2): S rests its value on the doctrinal question Q on what the rendering F2 closes
#program regime_la.               % Liturgiam authenticam (2001): the text "must be translated integrally and in
                                  % the most exact manner" (n. 20); nothing restricted (n. 32); the order kept as
                                  % far as the tongue allows (n. 57). What a rendering opens goes to catechesis (n. 29).
la_faithful(F2,F1) :- rendering(F2,F1), not closes(F2,F1,_), not unrendered(F2,F1,_), not order_changed(F2,F1,_).
info(faithful(F2,F1))     :- la_faithful(F2,F1).
info(not_faithful(F2,F1)) :- rendering(F2,F1), not la_faithful(F2,F1).
for_catechesis(F2,R) :- opens(F2,_,R).
for_catechesis(F2,R) :- catechesis_rule(_,F2,R).
info(for_catechesis(F2,R)) :- for_catechesis(F2,R).
#program regime_clp.              % Comme le prevoit (1969): the unit is "the whole passage" (n. 12), the hearer
                                  % "some actual community" (n. 20); a faithful version gives the message (nn. 6,
                                  % 16); explanations go to catechesis, not into the text, nor any insertion
                                  % into a biblical or anaphoral text (nn. 31, 33). Whether a choice is an
                                  % insertion is itself disputed: both ways.
{ inserted(F2,F1) } :- interpretation(F2,F1,R), catechesis_rule(_,F2,R), span_kind(F1,_).
assumed_fact(inserted(F2,F1))        :- inserted(F2,F1).
assumed_fact(false(inserted(F2,F1))) :- interpretation(F2,F1,R), catechesis_rule(_,F2,R), span_kind(F1,_),
                                        not inserted(F2,F1).
clp_faithful(G,F2,F1) :- message_admitted(G,F2,F1), not contrary_heard(G,F2), not inserted(F2,F1).
info(faithful_for(G,F2,F1))     :- clp_faithful(G,F2,F1).
info(not_faithful_for(G,F2,F1)) :- heard_rendering(G,F2,F1), message(F1,_,_), not clp_faithful(G,F2,F1).
#program regime_mp.               % Magnum principium (2017): "fidelitas non semper iudicari potest ex singulis
                                  % verbis", but "ex toto communicationis actu"; three fidelities (Francis to
                                  % Sarah, 15 October 2017): the text, the Latin deciding in doubt (the decree of
                                  % 22 October 2021, n. 21); the tongue; the addressees, as Comme le prevoit.
mp_text(F2,F1) :- rendering(F2,F1), not closes(F2,F1,_).
info(latin_decides(F2,F1)) :- rendering(F2,F1), closes(F2,F1,_).
mp_tongue(F2) :- idiomatic(F2,_,_).
mp_faithful(G,F2,F1) :- mp_text(F2,F1), mp_tongue(F2), message_admitted(G,F2,F1), not contrary_heard(G,F2).
info(faithful_for(G,F2,F1))     :- mp_faithful(G,F2,F1).
info(not_faithful_for(G,F2,F1)) :- heard_rendering(G,F2,F1), message(F1,_,_), not mp_faithful(G,F2,F1).
% A sacramental formula also needs a version word for word, approved by the
% Pope (the decree, n. 25): governance, reported.
info(word_for_word_required(F2,F1)) :- rendering(F2,F1), formula_of(F1,_).

% ---------- domains (L) ---------------------------------------------
#program base.
in_sort(tmode,(univocal;analogical;equivocal;gap;interpretation)).
in_sort(akind,(attribution;proportionality;metaphor)).
in_sort(unit,(word;passage;act;sense;recipients)).
violation(outside_domain(analogous,3,K)) :- analogous(_,_,K,_), not in_sort(akind,K).
violation(outside_domain(mode_claim,4,M)) :- mode_claim(_,_,_,M,_), not in_sort(tmode,M).
violation(outside_domain(mode_claim,5,U)) :- mode_claim(_,_,_,_,U), not in_sort(unit,U).
violation(outside_domain(formula_of,2,K)) :- formula_of(_,K), not in_sort(sacrament,K).
violation(outside_domain(form_for,2,K)) :- form_for(_,K), not in_sort(sacrament,K).
violation(outside_domain(rite_given,2,K)) :- rite_given(_,K,_,_,_), not in_sort(sacrament,K).
