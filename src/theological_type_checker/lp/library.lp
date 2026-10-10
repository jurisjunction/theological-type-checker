% ===================================================================
%  Library: where each source is found in print, and what to fetch.
%
%  work(W, Author, Title, Imprint, Year)   a book, series or edition
%  cites_work(S, W, Locator)               source S is read in W at Locator
%  online(W, URL)                          a reliable text is online; no trip
%  consulted(S)                            S has been checked against the
%                                          original (the flywheel adds these)
%  to_read(W, Why)                         read W for the research itself
%
%  to_fetch(W, Why) is derived: a physical copy is wanted. No identifiers
%  (ISBN, OCLC) are entered by hand; they are resolved at fetch time.
% ===================================================================

work(dh43, "Denzinger, H.; Hünermann, P. (ed.)", "Enchiridion symbolorum, definitionum et declarationum de rebus fidei et morum", "43rd ed.", 2012).
work(scotus_vat, "Ioannes Duns Scotus", "Opera omnia (editio Vaticana)", "Civitas Vaticana: Commissio Scotistica", 1950).
work(bonaventure_quar, "Bonaventura", "Opera omnia", "Quaracchi: Collegium S. Bonaventurae", 1882).
work(bernard_sbo, "Bernardus Claraevallensis", "Sancti Bernardi Opera, ed. J. Leclercq, H. Rochais", "Romae: Editiones Cistercienses", 1957).
work(gasser_relatio, "Gasser, Vincent", "The Gift of Infallibility: The Official Relatio on Infallibility at Vatican Council I, tr. J. T. O'Connor", "Boston: St Paul Editions", 1986).
work(comentario_exegetico, "Marzoa, A.; Miras, J.; Rodríguez-Ocaña, R. (eds.)", "Comentario exegético al Código de Derecho Canónico", "Pamplona: EUNSA", 1996).
work(rrdec95, "Rota Romana", "Romanae Rotae Decisiones seu Sententiae, vol. 95 (decisions of 2003)", "Città del Vaticano: LEV", 2003).
work(ouellet_2006, "Ouellet, Marc", "Divine Likeness: Toward a Trinitarian Anthropology of the Family", "Grand Rapids: Eerdmans", 2006).
work(scola_2005, "Scola, Angelo", "The Nuptial Mystery", "Grand Rapids: Eerdmans", 2005).
work(przywara_2014, "Przywara, Erich", "Analogia Entis, tr. J. R. Betz and D. B. Hart", "Grand Rapids: Eerdmans", 2014).
work(horan_2014, "Horan, Daniel P.", "Postmodernity and Univocity: A Critical Account of Radical Orthodoxy and John Duns Scotus", "Minneapolis: Fortress", 2014).
work(antonianum_76, "Cross, Richard", "Where Angels Fear to Tread: Duns Scotus and Radical Orthodoxy, Antonianum 76 (2001) 7-41", "Antonianum", 2001).
work(summa_leonina, "Thomas Aquinas", "Summa theologiae", "Leonine ed.", 1888).
work(aas, "Holy See", "Acta Apostolicae Sedis", "Città del Vaticano", 1909).
work(cic1983, "Holy See", "Codex Iuris Canonici (1983; Book VI as revised 2021)", "Città del Vaticano: LEV", 1983).

online(summa_leonina, "https://www.corpusthomisticum.org/sth0000.html").
online(aas, "https://www.vatican.va/archive/aas/index_sp.htm").
online(cic1983, "https://www.iuscangreg.it/cic1983.php").

% where the encoded sources are read
cites_work(scotus, scotus_vat, "Ordinatio III d.3 q.1").
cites_work(bonaventure, bonaventure_quar, "In III Sent. d.3").
cites_work(bernard, bernard_sbo, "Ep. 174").
cites_work(aquinas, summa_leonina, "ST III q.27 a.2").
cites_work(trent_1546, dh43, "DH 1516").
cites_work(ineffabilis_1854, dh43, "DH 2800-2804").
cites_work(florence_1439, dh43, "DH 1306").
cites_work(florence1442, dh43, "DH 1351").
cites_work(auctorem_fidei_1794, dh43, "DH 2626").
cites_work(dh795, dh43, "DH 795").
cites_work(trent_1563, dh43, "DH 1807").
cites_work(trent_1551, dh43, "DH 1661").
cites_work(lg25, gasser_relatio, "relatio of 11 July 1870").
cites_work(ed1988, aas, "AAS 80 (1988) 1495-1498").

% research the theory still owes (docs/research/warrants-and-prior-art.md)
to_read(comentario_exegetico, "Bañares on cc. 1057, 1084, 1091; Fornés on cc. 1134-1135: may already contain the systematic reading claimed as new").
to_read(rrdec95, "c. Defilippi, 783-805: verify the gift rationale for c. 1084 against the printed sentence").
to_read(ouellet_2006, "verify quotations taken from excerpts").
to_read(scola_2005, "verify quotations taken from reviews").
to_read(przywara_2014, "analogia entis: the bridge design against its classic statement").
to_read(horan_2014, "Scotus and univocity: findings section 1").
to_read(antonianum_76, "Scotus and univocity: findings section 1").

to_fetch(W,verify(S,L)) :- cites_work(S,W,L), not consulted(S), not online(W,_).
to_fetch(W,read(Why))   :- to_read(W,Why), not online(W,_).
used_work(W,S) :- cites_work(S,W,_), source(S,_,_,_).

#show work/5. #show to_fetch/2. #show online/2. #show used_work/2.
