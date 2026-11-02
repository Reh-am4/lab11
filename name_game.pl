% ARTI 401 - Lab 9
% IO Stream and Database Manipulation
% Lab Activity: Name Game

:- dynamic letters/1.

% Initial set of letters
letters([a, b, c]).


% Start the game
name_game :-
    write('Hi. This is the "Name Game"'), nl,
    write('You will be given a set of English letters.'), nl,
    write('Add, delete, or arrange letters to create your name.'), nl,
    menu.


% Display the menu
menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice: '),
    read(Choice),
    process_choice(Choice).


% Option 1: Display letters
process_choice(1) :-
    letters(List),
    write('Current letters: '),
    write(List), nl,
    menu.


% Option 2: Add a letter
% In this version, a normal add places the letter at the end
process_choice(2) :-
    write('Enter the letter to add: '),
    read(Letter),
    letters(List),
    add_at_end(Letter, List, NewList),
    update_letters(NewList),
    write('Letter added.'), nl,
    menu.


% Option 3: Add a letter at the top
process_choice(3) :-
    write('Enter the letter to add at the top: '),
    read(Letter),
    letters(List),
    NewList = [Letter|List],
    update_letters(NewList),
    write('Letter added at the top.'), nl,
    menu.


% Option 4: Add a letter at the bottom
process_choice(4) :-
    write('Enter the letter to add at the bottom: '),
    read(Letter),
    letters(List),
    add_at_end(Letter, List, NewList),
    update_letters(NewList),
    write('Letter added at the bottom.'), nl,
    menu.


% Option 5: Delete one occurrence of a letter
process_choice(5) :-
    write('Enter the letter to delete: '),
    read(Letter),
    letters(List),
    delete_one(Letter, List, NewList),
    update_letters(NewList),
    write('Letter deleted if it existed.'), nl,
    menu.


% Option 6: Delete all letters
process_choice(6) :-
    update_letters([]),
    write('All letters deleted.'), nl,
    menu.


% Option 7: Exit
process_choice(7) :-
    write('Goodbye!'), nl.


% Invalid menu choice
process_choice(Choice) :-
    Choice \= 1,
    Choice \= 2,
    Choice \= 3,
    Choice \= 4,
    Choice \= 5,
    Choice \= 6,
    Choice \= 7,
    write('Invalid choice. Please try again.'), nl,
    menu.


% Add an element at the end of a list
add_at_end(X, [], [X]).

add_at_end(X, [Head|Tail], [Head|Result]) :-
    add_at_end(X, Tail, Result).


% Delete only the first occurrence of an element
delete_one(_, [], []).

delete_one(X, [X|Tail], Tail).

delete_one(X, [Head|Tail], [Head|Result]) :-
    X \= Head,
    delete_one(X, Tail, Result).


% Update the dynamic database
update_letters(NewList) :-
    retractall(letters(_)),
    assertz(letters(NewList)).