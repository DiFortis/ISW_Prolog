:- dynamic user_answer/3.


category(pis, [sprawiedliwosc, tradycja, socjalizm]).
category(po, [liberalizm, kapitalizm, modernizacja]).
category(lewica, [socjalizm, rownosc, ekologia]).
category(psl, [agraryzm, tradycja, decentralizacja]).
category(konfederacja, [kapitalizm, wolnosc, konserwatyzm]).


question(1, 'Czy popierasz polityke socjalna?', [tak, nie]).
question(2, 'Czy uwazasz, ze tradycja jest wazna?', [tak, nie]).
question(3, 'Czy jestes za wolnym rynkiem?', [tak, nie]).
question(4, 'Czy popierasz modernizacje panstwa?', [tak, nie]).
question(5, 'Czy uwazasz, ze rownosc spoleczna jest wazna?', [tak, nie]).
question(6, 'Czy jestes za decentralizacja wladzy?', [tak, nie]).
question(7, 'Czy popierasz ekologie?', [tak, nie]).
question(8, 'Czy uwazasz, ze wolnosc jednostki jest najwazniejsza?', [tak, nie]).
question(9, 'Czy jestes za agraryzmem?', [tak, nie]).
question(10, 'Czy popierasz sprawiedliwosc spoleczna?', [tak, nie]).
question(11, 'Czy uwazasz, ze kapitalizm jest najlepszym systemem gospodarczym?', [tak, nie]).
question(12, 'Czy popierasz konserwatyzm?', [tak, nie]).
question(13, 'Czy jestes za liberalizmem?', [tak, nie]).
question(14, 'Czy uwazasz, ze socjalizm jest dobra droga?', [tak, nie]).
question(15, 'Czy popierasz polityke rownych szans?', [tak, nie]).


answer(QuestionNum, User, Response) :- 
    question(QuestionNum, _, Options), 
    member(Response, Options), 
    assertz(user_answer(User, QuestionNum, Response)).


match_party(User, Category) :-
    category(Category, Features),
    check_features(User, Features).

check_features(User, [Feature|Rest]) :-
    feature_question(Feature, QuestionNum),
    user_answer(User, QuestionNum, tak),
    check_features(User, Rest).
check_features(_, []).

feature_question(sprawiedliwosc, 10).
feature_question(tradycja, 2).
feature_question(socjalizm, 14).
feature_question(liberalizm, 13).
feature_question(kapitalizm, 11).
feature_question(modernizacja, 4).
feature_question(rownosc, 5).
feature_question(ekologia, 7).
feature_question(wolnosc, 8).
feature_question(agraryzm, 9).
feature_question(decentralizacja, 6).
feature_question(konserwatyzm, 12).

clear_answers :- retractall(user_answer(_, _, _)).
