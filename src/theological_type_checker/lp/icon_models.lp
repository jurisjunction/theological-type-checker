% ===================================================================
%  Domain models. Each #program block is one model; the runner grounds
%  the core plus whichever blocks a scenario names. Encoding a model
%  is the interpretive step; checking it is mechanical.
% ===================================================================

#program trinity.                       % M1
divine(father). divine(son). divine(spirit).
gen(begetting,father,son).
gen(spiration,father,spirit).
gen(spiration,son,spirit) :- not monopatrism.   % Lyons II, DH 850; Florence, DH 1300-1302

#program family.                        % M2: marriage, conception, baptism
uses(icon).                             % the Grammar of the Icon
god(god). bridegroom(son). incarnate(son).   % the incarnate is the Son (TTC-CREED CR2)
created_person(man). created_person(woman). created_person(child).
proposed_bond(man,woman).
consent(man,woman). consent(woman,man). capable_closing(man,woman).
gen(conception,man,child). gen(conception,woman,child).
closed_in_act(conception,man,woman).
consent(man,son). consent(woman,son).
held_for(church,child,son).          % infant baptism: held in trust

#program souls.                         % M3: Christ and many souls
uses(icon).                             % the Grammar of the Icon
god(god). bridegroom(son). incarnate(son).
created_person(soul1). created_person(soul2). created_person(soul3).
consent(soul1,son). consent(soul2,son). consent(soul3,son).
total(son,soul1). total(son,soul2). total(son,soul3).
total(soul1,son). total(soul2,son). total(soul3,son).
stage(son,embryo).

#program friendship.                    % M4: co-phase love
uses(icon).                             % the Grammar of the Icon
god(god). bridegroom(son). incarnate(son).
created_person(david). created_person(jonathan).
consent(david,son). consent(jonathan,son).
side_by_side(david,jonathan,god).
intense(david,jonathan).

#program communicatio.                  % M5: predication about Christ
term_sort(god,suppositum). term_sort(son,suppositum). term_sort(this_man,suppositum).
term_sort(divinity,nature(div)). term_sort(humanity,nature(hum)).
pred_nature(died,hum). pred_nature(born_of_mary,hum). pred_nature(is_a_creature,hum).
pred_nature(is_god,div). pred_nature(eternal,div).
unsafe_unqualified(is_a_creature).
sentence(god_died,god,died).
sentence(this_man_is_god,this_man,is_god).
sentence(god_born_of_mary,god,born_of_mary).
sentence(divinity_died,divinity,died).
sentence(humanity_is_eternal,humanity,eternal).
sentence(christ_is_a_creature,son,is_a_creature).
sentence(christ_as_man_is_a_creature,son,is_a_creature).
qualified(christ_as_man_is_a_creature).

#program bonds.                         % c. 1084 / c. 1057 shapes
uses(icon).                             % the Grammar of the Icon
god(god).
created_person(a1). created_person(b1).                  % sterile, capable
proposed_bond(a1,b1). consent(a1,b1). consent(b1,a1). capable_closing(a1,b1). sterile(a1).
created_person(a2). created_person(b2).                  % incapable of the closing act
proposed_bond(a2,b2). consent(a2,b2). consent(b2,a2).
created_person(a3). created_person(b3).                  % one consent supplied by a third party
proposed_bond(a3,b3). consent(a3,b3). held_for(parent,b3,a3). capable_closing(a3,b3).

#program polygamy.
uses(icon).                             % the Grammar of the Icon
created_person(h). created_person(w1). created_person(w2).
total(h,w1). total(h,w2).

#program separate_act.                  % married couple; generation without the closing act
uses(icon).                             % the Grammar of the Icon
god(god). bridegroom(son). incarnate(son).
created_person(man2). created_person(woman2). created_person(child2).
proposed_bond(man2,woman2).
consent(man2,woman2). consent(woman2,man2). capable_closing(man2,woman2).
consent(man2,son). consent(woman2,son). held_for(church,child2,son).
gen(separate,man2,child2). gen(separate,woman2,child2).   % no closed_in_act

#program asexual.                       % fission and parthenogenesis
uses(icon).                             % the Grammar of the Icon
god(god).
organism(bact). organism(bact_a). organism(bact_b).
level(bact,organism). of_kind(bact,bacterium).
gen(fission,bact,bact_a). gen(fission,bact,bact_b).
organism(whiptail). organism(whiptail_jr).
level(whiptail,organism). of_kind(whiptail,whiptail_lizard).
gen(parthenogenesis,whiptail,whiptail_jr).
band(gamete). band(organism).
obligate_sexual(human).
