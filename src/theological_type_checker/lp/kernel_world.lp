% ===================================================================
%  Kernel fixtures: creatures of the kernel's own, across the range of
%  created being, so that kernel rules are tested without the Grammar of
%  the Icon's models (docs/layers.md). Grades after ST I q.18 a.3 and
%  q.76 a.3: what merely is, what lives, what senses, what understands,
%  and pure spirits. Lateran IV (DH 800): God created "both orders of
%  creatures, the spiritual and the bodily, the angelic and the earthly".
% ===================================================================

#program world.
god(god).
inanimate(stone; star; water; bronze).          % what merely is
organism(oak; oak2; bacterium; bacterium2).     % what lives
organism(lion; lioness; cub).                   % what senses
created_person(peter; anna; sculptor).          % what understands, in a body
created_person(infant; embryo).                 % human at every stage (Donum vitae I.1)
angel(gabriel; michael).                        % pure spirits
gen(budding,  oak, oak2).                       % one parent
gen(fission,  bacterium, bacterium2).           % one parent
gen(breeding, lion, cub). gen(breeding, lioness, cub).   % two parents, no persons
acton(sculptor, bronze).                        % action on a thing (relation D); the statue is
                                                % the bronze given a form, not a new substance

#program world_claims.            % unary and relational claims about the world
claims(c_recv,  receptive, bronze, sculptor, d).   % true: the bronze is acted on
claims(c_give,  donative,  sculptor, bronze, d).   % true
claims(c_false, donative,  bronze, sculptor, d).   % false: the bronze does not act on the sculptor
claims(c_cub,   receptive, cub, lion, o).          % true: the cub is from the lion
claims(c_angel, receptive, gabriel, god, e).       % true: the angel receives being from God (DH 800)
distinguishes(d_god_stone, donative, god, stone).  % "giving" as a property: does it tell God from a stone?

% ---------- Candidates: positions the kernel must refuse ----------------
#program cand_causa_sui.          % God the cause of his own being (cf. ST I q.2 a.3, second way)
being(god, god).

#program cand_theogony.           % the god born of something prior (Hesiod, Theogony 116 ff.)
inanimate(chaos).
gen(theogony, chaos, god).

#program cand_demiurge.           % a second giver of being beside God (Plato, Timaeus; the Gnostic demiurge)
being(demiurge, peter).

#program cand_time_loop.          % two creatures each the ancestor of the other
organism(x1; x2).
gen(loop_a, x1, x2). gen(loop_b, x2, x1).

#program cand_arian.              % the Son a creature (Arius; Nicaea, DH 126)
created_person(son).

#program cand_bridge_no_divine_mode.   % a bridge with a creaturely mode only
bridge(wisdom, div, cr). mode(wisdom, cr, participated).

#program cand_univocal_acyclicity.     % acyclicity typed as a norm on both sides
univocal_mode(acyclicity, norm).

#program cand_angels_above_men.   % "a little less than the angels" (Ps 8:5; Heb 2:7): a ranking of natures
less(peter, gabriel).

#program cand_image_by_birth.     % the image withheld until birth
denies_image(embryo, not_yet_born).

#program cand_image_of_angels.    % the image denied to angels: the deposit is silent (cf. ST I q.93 a.3)
denies_image(gabriel, pure_spirit).

#program communicatio_nature.     % a nature term with a predicate of its own nature
sentence(humanity_is_created, humanity, is_a_creature).

% ---------- The creeds' persons and events (TTC-CREED) ------------------
% Load with trinity. The Son incarnate, his mother, and the economy as the
% second article of the creeds tells it (DH 30, 150).
#program creed.
incarnate(son).                    % the only-begotten Son made incarnate (Lateran IV, DH 801)
created_person(mary). created_person(adam).
gen(nativity,mary,son). in_nature(nativity,hum).    % born of the Virgin Mary, in his humanity (DH 422)
changes_in(son,hum).               % he grew (Lk 2:52) and suffered in the flesh (DH 432)
virginally_conceived(son).         % conceived by the Holy Spirit (DH 30, 150)
descends_from(mary,adam). descends_from(son,adam).   % by generation; his through Mary (Lk 3:23-38)
% the economy: an order of events
next(creation,fall). next(fall,conception_of_mary). next(conception_of_mary,annunciation).
next(annunciation,nativity_of_christ). next(nativity_of_christ,passion). next(passion,death).
next(death,burial). next(burial,descent). next(descent,resurrection). next(resurrection,ascension).
next(ascension,session). next(session,pentecost). next(pentecost,return). next(return,judgment).
% "under Pontius Pilate" dates the passion, the creeds' one date; the rest is order, not date.
% Mary preserved at her conception "in view of the merits of Jesus Christ" (DH 2803)
caused_by(preservation_of_mary,passion). happens_at(preservation_of_mary,conception_of_mary).
foreseen(preservation_of_mary,passion).
term_sort(son,suppositum). pred_nature(born_of_mary,hum).   % T5: God the Son was born of Mary (DH 251)
sentence(the_son_born_of_mary,son,born_of_mary).

% ---------- Candidates: what the councils refused (TTC-CREED) -------------
#program creed_predication.       % what may be said of whom (T5 by the person's natures)
term_sort(mary,suppositum). pred_nature(is_god,div).
sentence(the_son_is_god,son,is_god).          % well typed
sentence(mary_is_god,mary,is_god).            % ill typed: a creature (the Collyridians, Epiphanius, Panarion 79)
#program cand_father_suffered.    % the Father suffered (Praxeas)
changes_in(father,hum).
#program cand_incarnate_apart.     % the incarnate named apart from the Son (the theory's models before TTC-CREED)
incarnate(christ).
#program cand_incarnate_father.    % the Father made flesh (Sabellius)
incarnate(father).
#program cand_birth_by_person.     % the birth of Mary typed by the person only
gen(nativity_untyped,mary,son).
#program cand_change_by_person.    % his growth and passion said of the person without a nature
changes(son).
#program cand_change_in_divinity.  % the passion said in the divine nature (Theopaschism)
changes_in(son,div).
#program cand_patripassian.        % the Father born of Mary (Noetus, Praxeas)
gen(nativity_of_father,mary,father). in_nature(nativity_of_father,hum).
term_sort(father,suppositum). pred_nature(born_of_mary,hum).
sentence(father_born_of_mary,father,born_of_mary).
#program cand_apollinarian.        % the Word in place of a human mind (Apollinaris)
lacks(son,rational_soul).
#program cand_eutychian.           % the humanity absorbed after the union (Eutyches)
absorbed(son).
#program cand_monothelite.         % one will (Sergius of Constantinople)
denies(son,human_will).
#program cand_monoenergist.        % one operation (Cyrus of Alexandria)
denies(son,human_operation).
#program cand_nestorian.           % the one born of Mary a man joined to the Word (Nestorius)
created_person(jesus_man). gen(nativity_n,mary,jesus_man). conjoined(jesus_man,son).
term_sort(son,suppositum). pred_nature(born_of_mary,hum).
sentence(god_the_word_born_of_mary,son,born_of_mary).
#program cand_descent_alone.       % original sin by descent alone, propagation or none
contracts_original_sin(P) :- descends_from(P,adam).
#program cand_merits_in_time.      % the cross's effects only after it in time
violation(effect_before_cause(E,C)) :- caused_by(E,C), happens_at(E,T), before(T,C).
#program cand_grace_unforeseen.    % a grace before the cross, typed without foresight
next(fall,call_of_abraham). next(call_of_abraham,conception_of_mary).
caused_by(grace_of_abraham,passion). happens_at(grace_of_abraham,call_of_abraham).
#program cand_economy_reversed.    % risen before he died
next(resurrection,death).
#program cand_scripture_raw.      % a text of Scripture entered with no readings (TTC-CREED)
source(raw_text,0,truth,95). supports(raw_text,q(water_of_baptism),true_water).
