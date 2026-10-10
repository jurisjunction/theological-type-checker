% The minimal new case from the encoding guide. Run with:
%   ttc-check --facts examples/new_question.lp
% Then change enc_x's character to interview and run it again.
question(q(example)). question_kind(q(example),doctrinal).
value(q(example),yes). value(q(example),no).
source(enc_x,3,truth,1990). papal_form(enc_x,ordinary). character(enc_x,encyclical).
supports(enc_x,q(example),yes).
source(theol_y,5,truth,2001). supports(theol_y,q(example),no).
