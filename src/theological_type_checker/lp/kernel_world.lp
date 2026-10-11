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
