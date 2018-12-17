% tagalog.pl
% Nikka Yalung

% case markers
tagalog([ng],[marker, unfocused, relational]).
tagalog([sa],[marker, unfocused, locative]).
tagalog([ang],[marker, focused]).

% nouns
tagalog([lalaki],[noun, animate]). % man
tagalog([pusa],[noun, animate]). % cat
tagalog([laruan],[noun, inanimate]). % toy
tagalog([libro],[noun, inanimate]). % book

% verbs
tagalog([binigay],[verb,ditransitive]). % gave
tagalog([binasa],[verb, transitive]). % read / soaked(if pronounced with final glottal stop)
tagalog([nagmahal],[verb, intransitive]). % loved

% case particle
tagalog([ay],[particle]).

% Legend:
% V = verb
% F = focus
% UR = unfocused relational
% UL = unfocused locative

% The next 4 predicates yields noun phrases. Each one is described by their arguments.
tagalog(A, [focused, animate]):-
    tagalog(B, [marker, focused]),
    tagalog(C, [noun, animate]),
    append(B,C,A).

tagalog(A, [focused, inanimate]):-
    tagalog(B, [marker, focused]),
    tagalog(C, [noun, inanimate]),
    append(B,C,A).

tagalog(A, [unfocused, relational]):-
    tagalog(B, [marker, unfocused, relational]),
    tagalog(C, [noun, animate]),
    append(B,C,A).

tagalog(A, [unfocused, locative]):-
    tagalog(B, [marker, unfocused, locative]),
    tagalog(C, [noun, animate]),
    append(B,C,A).

% The next 3 predicates will yield the proper word orders without the verb.
% word order: UR F UL
tagalog(A, [relational, focused, locative]):-
    tagalog(B, [unfocused, relational]),
    tagalog(C, [focused, _]),
    tagalog(D, [unfocused, locative]),
    append([B,C,D],A).

% word order: UR UL F
tagalog(A, [relational, locative, focused]):-
    tagalog(B, [unfocused, relational]),
    tagalog(C, [unfocused, locative]),
    tagalog(D, [focused,_]),
    append([B,C,D],A).

% word order: F UL UR
tagalog(A, [focused, locative, relational]):-
    tagalog(B, [focused,_]),
    tagalog(C, [locative]),
    tagalog(D, [relational]),
    append([B,C,D],A).

% The next 4 predicates will yield ditransitive sentences.
% word order: V UR F UL
tagalog(A, [sentence, ditransitive]):-
    tagalog(B, [verb]),
    tagalog(C, [relational, focused, locative]),
    append(B,C,A).

% word order: V UR UL F
tagalog(A, [sentence, ditransitive]):-
  tagalog(B, [verb]),
  tagalog(C, [relational, locative, focused]),
  append(B,C,A).

% word order: V F UL UR
tagalog(A, [sentence, ditransitive]):-
  tagalog(B, [verb, ditransitive]),
  tagalog(C, [focused, locative, relational]),
  append(B,C,A).

% This predicate is a little different from the above 3 as it includes a case particle
% to accommodate the Focus being the first word.
% word order: F V UR UL
tagalog(A, [sentence, ditransitive]):-
  tagalog(B, [focused,_]),
  tagalog(C, [particle]),
  tagalog(F, [verb, ditransitive]),
  tagalog(D, [unfocused, relational]),
  tagalog(E, [unfocused, locative]),
  append([B,C,F,D,E],A).

% This predicate will yield a transitive sentence.
% word order: V UR F
tagalog(A, [sentence, transitive]):-
  tagalog(B, [verb, transitive]),
  tagalog(C, [unfocused, relational]),
  tagalog(D, [focused,_]),
  append([B,C,D],A).

% This predicate will yield a transitive sentence. It is different from the predicate above
% as it includes a case particle to accommodate the Focus being the first word.
% word order: F V UR
tagalog(A,[sentence, transitive]):-
  tagalog(B, [focused,_]),
  tagalog(C, [particle]),
  tagalog(D, [verb, transitive]),
  tagalog(E, [unfocused,relational]),
  append([B,C,D,E],A).

% This predicate will yield an intransitive sentence.
% word order: V F
tagalog(A, [sentence, intransitive]):-
  tagalog(B, [verb, intransitive]),
  tagalog(C, [focused,animate]),
  append(B,C,A).

% This predicate will yield an intransitive sentence. It is different from the predicate above
% as it includes a case particle to accommodate the Focus being the first word.
% word order: F V
tagalog(A, [sentence, intransitive]):-
  tagalog(B, [focused,animate]),
  tagalog(C, [particle]),
  tagalog(D, [verb, intransitive]),
  append([B,C,D],A).
