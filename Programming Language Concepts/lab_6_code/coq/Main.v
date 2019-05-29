

Notation "x :: y" := (cons x y) 
                     (at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x , .. , y ]" := (cons x .. (cons y []) ..).
Notation "x ++ y" := (app x y) 
                     (at level 60, right associativity).

Theorem nil_app : forall X:Type, forall l:list X, 
  app [] l = l.
Proof. 
  intros X l. reflexivity.
Qed.

Theorem app_assoc: forall X (l1 l2 l3: list X),
  (l1 ++ l2) ++ l3 = l1 ++ (l2 ++ l3).
intros. induction l1. reflexivity.
  simpl. rewrite IHl1. reflexivity.
Qed.



(* ################################################################# *)
(** * Pairs of Numbers *)

(** In an [Inductive] type definition, each constructor can take
    any number of arguments -- none (as with [true] and [O]), one (as
    with [S]), or more than one, as here: *)

Inductive natprod : Type :=
| pair : nat -> nat -> natprod.

(** This declaration can be read: "There is one way to construct
    a pair of numbers: by applying the constructor [pair] to two
    arguments of type [nat]." *)

Check (pair 3 5).

(** Here are two simple functions for extracting the first and
    second components of a pair.  The definitions also illustrate how
    to do pattern matching on two-argument constructors. *)

Definition fst (p : natprod) : nat :=
  match p with
  | pair x y => x
  end.

Definition snd (p : natprod) : nat :=
  match p with
  | pair x y => y
  end.

Compute (fst (pair 3 5)).
(* ===> 3 *)

(** Since pairs are used quite a bit, it is nice to be able to
    write them with the standard mathematical notation [(x,y)] instead
    of [pair x y].  We can tell Coq to allow this with a [Notation]
    declaration. *)

Notation "( x , y )" := (pair x y).

(** The new notation can be used both in expressions and in
    pattern matches (indeed, we've seen it already in the previous
    chapter -- this works because the pair notation is actually
    provided as part of the standard library): *)

Compute (fst (3,5)).

Definition fst' (p : natprod) : nat :=
  match p with
  | (x,y) => x
  end.

Definition snd' (p : natprod) : nat :=
  match p with
  | (x,y) => y
  end.

Definition swap_pair (p : natprod) : natprod :=
  match p with
  | (x,y) => (y,x)
  end.

(** Let's try to prove a few simple facts about pairs.

    If we state things in a particular (and slightly peculiar) way, we
    can complete proofs with just reflexivity (and its built-in
    simplification): *)

Theorem surjective_pairing' : forall (n m : nat),
  (n,m) = (fst (n,m), snd (n,m)).
Proof.
  reflexivity.  Qed.

(** But [reflexivity] is not enough if we state the lemma in a more
    natural way: *)

Theorem surjective_pairing_stuck : forall (p : natprod),
  p = (fst p, snd p).
Proof.
  simpl. (* Doesn't reduce anything! *)
Abort.

(** We have to expose the structure of [p] so that [simpl] can
    perform the pattern match in [fst] and [snd].  We can do this with
    [destruct]. *)

Theorem surjective_pairing : forall (p : natprod),
  p = (fst p, snd p).
Proof.
  intros p.  destruct p as [n m].  simpl.  reflexivity.  Qed.

(** Notice that, unlike its behavior with [nat]s, [destruct]
    doesn't generate an extra subgoal here.  That's because [natprod]s
    can only be constructed in one way. *)

(** **** Exercise: 1 star (snd_fst_is_swap)  *)
Theorem snd_fst_is_swap : forall (p : natprod),
  (snd p, fst p) = swap_pair p.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 1 star, optional (fst_swap_is_snd)  *)
Theorem fst_swap_is_snd : forall (p : natprod),
  fst (swap_pair p) = snd p.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(* ################################################################# *)
(** * Lists of Numbers *)

(** Generalizing the definition of pairs, we can describe the
    type of _lists_ of numbers like this: "A list is either the empty
    list or else a pair of a number and another list." *)

Inductive natlist : Type :=
  | nil  : natlist
  | cons : nat -> natlist -> natlist.

(** For example, here is a three-element list: *)

Definition mylist := cons 1 (cons 2 (cons 3 nil)).

(** As with pairs, it is more convenient to write lists in
    familiar programming notation.  The following declarations
    allow us to use [::] as an infix [cons] operator and square
    brackets as an "outfix" notation for constructing lists. *)

Notation "x :: l" := (cons x l)
                     (at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) ..).

(** It is not necessary to understand the details of these
    declarations, but in case you are interested, here is roughly
    what's going on.  The [right associativity] annotation tells Coq
    how to parenthesize expressions involving several uses of [::] so
    that, for example, the next three declarations mean exactly the
    same thing: *)

Definition mylist1 := 1 :: (2 :: (3 :: nil)).
Definition mylist2 := 1 :: 2 :: 3 :: nil.
Definition mylist3 := [1;2;3].

(** The [at level 60] part tells Coq how to parenthesize
    expressions that involve both [::] and some other infix operator.
    For example, since we defined [+] as infix notation for the [plus]
    function at level 50,

  Notation "x + y" := (plus x y)
                      (at level 50, left associativity).

   the [+] operator will bind tighter than [::], so [1 + 2 :: [3]]
   will be parsed, as we'd expect, as [(1 + 2) :: [3]] rather than [1
   + (2 :: [3])].

   (Expressions like "[1 + 2 :: [3]]" can be a little confusing when 
   you read them in a .v file.  The inner brackets, around 3, indicate 
   a list, but the outer brackets, which are invisible in the HTML 
   rendering, are there to instruct the "coqdoc" tool that the bracketed 
   part should be displayed as Coq code rather than running text.)

   The second and third [Notation] declarations above introduce the
   standard square-bracket notation for lists; the right-hand side of
   the third one illustrates Coq's syntax for declaring n-ary
   notations and translating them to nested sequences of binary
   constructors. *)

(* ----------------------------------------------------------------- *)
(** *** Repeat *)

(** A number of functions are useful for manipulating lists.
    For example, the [repeat] function takes a number [n] and a
    [count] and returns a list of length [count] where every element
    is [n]. *)

Fixpoint repeat (n count : nat) : natlist :=
  match count with
  | O => nil
  | S count' => n :: (repeat n count')
  end.

(* ----------------------------------------------------------------- *)
(** *** Length *)

(** The [length] function calculates the length of a list. *)

Fixpoint length (l:natlist) : nat :=
  match l with
  | nil => O
  | h :: t => S (length t)
  end.

(* ----------------------------------------------------------------- *)
(** *** Append *)

(** The [app] function concatenates (appends) two lists. *)

Fixpoint app (l1 l2 : natlist) : natlist :=
  match l1 with
  | nil    => l2
  | h :: t => h :: (app t l2)
  end.

(** Actually, [app] will be used a lot in some parts of what
    follows, so it is convenient to have an infix operator for it. *)

Notation "x ++ y" := (app x y)
                     (right associativity, at level 60).

Example test_app1:             [1;2;3] ++ [4;5] = [1;2;3;4;5].
Proof. reflexivity.  Qed.
Example test_app2:             nil ++ [4;5] = [4;5].
Proof. reflexivity.  Qed.
Example test_app3:             [1;2;3] ++ nil = [1;2;3].
Proof. reflexivity.  Qed.

(* ----------------------------------------------------------------- *)
(** *** Head (with default) and Tail *)

(** Here are two smaller examples of programming with lists.
    The [hd] function returns the first element (the "head") of the
    list, while [tl] returns everything but the first
    element (the "tail").
    Of course, the empty list has no first element, so we
    must pass a default value to be returned in that case.  *)

Definition hd (default:nat) (l:natlist) : nat :=
  match l with
  | nil => default
  | h :: t => h
  end.

Definition tl (l:natlist) : natlist :=
  match l with
  | nil => nil
  | h :: t => t
  end.

Example test_hd1:             hd 0 [1;2;3] = 1.
Proof. reflexivity.  Qed.
Example test_hd2:             hd 0 [] = 0.
Proof. reflexivity.  Qed.
Example test_tl:              tl [1;2;3] = [2;3].
Proof. reflexivity.  Qed.

(* ----------------------------------------------------------------- *)
(** *** Exercises *)

(** **** Exercise: 2 stars, recommended (list_funs)  *)
(** Complete the definitions of [nonzeros], [oddmembers] and
    [countoddmembers] below. Have a look at the tests to understand
    what these functions should do. *)

Fixpoint nonzeros (l:natlist) : natlist 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_nonzeros:
  nonzeros [0;1;0;2;3;0;0] = [1;2;3].
  (* FILL IN HERE *) Admitted.

Fixpoint oddmembers (l:natlist) : natlist 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_oddmembers:
  oddmembers [0;1;0;2;3;0;0] = [1;3].
  (* FILL IN HERE *) Admitted.

Fixpoint countoddmembers (l:natlist) : nat 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_countoddmembers1:
  countoddmembers [1;0;3;1;4;5] = 4.
  (* FILL IN HERE *) Admitted.

Example test_countoddmembers2:
  countoddmembers [0;2;4] = 0.
  (* FILL IN HERE *) Admitted.

Example test_countoddmembers3:
  countoddmembers nil = 0.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 3 stars, advanced (alternate)  *)
(** Complete the definition of [alternate], which "zips up" two lists
    into one, alternating between elements taken from the first list
    and elements from the second.  See the tests below for more
    specific examples.

    Note: one natural and elegant way of writing [alternate] will fail
    to satisfy Coq's requirement that all [Fixpoint] definitions be
    "obviously terminating."  If you find yourself in this rut, look
    for a slightly more verbose solution that considers elements of
    both lists at the same time.  (One possible solution requires
    defining a new kind of pairs, but this is not the only way.)  *)

Fixpoint alternate (l1 l2 : natlist) : natlist 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_alternate1:
  alternate [1;2;3] [4;5;6] = [1;4;2;5;3;6].
  (* FILL IN HERE *) Admitted.

Example test_alternate2:
  alternate [1] [4;5;6] = [1;4;5;6].
  (* FILL IN HERE *) Admitted.

Example test_alternate3:
  alternate [1;2;3] [4] = [1;4;2;3].
  (* FILL IN HERE *) Admitted.

Example test_alternate4:
  alternate [] [20;30] = [20;30].
  (* FILL IN HERE *) Admitted.
(** [] *)

(* ----------------------------------------------------------------- *)
(** *** Bags via Lists *)

(** A [bag] (or [multiset]) is like a set, except that each element
    can appear multiple times rather than just once.  One possible
    implementation is to represent a bag of numbers as a list. *)

Definition bag := natlist.

(** **** Exercise: 3 stars, recommended (bag_functions)  *)
(** Complete the following definitions for the functions
    [count], [sum], [add], and [member] for bags. *)

Fixpoint count (v:nat) (s:bag) : nat 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

(** All these proofs can be done just by [reflexivity]. *)

Example test_count1:              count 1 [1;2;3;1;4;1] = 3.
 (* FILL IN HERE *) Admitted.
Example test_count2:              count 6 [1;2;3;1;4;1] = 0.
 (* FILL IN HERE *) Admitted.

(** Multiset [sum] is similar to set [union]: [sum a b] contains
    all the elements of [a] and of [b].  (Mathematicians usually
    define [union] on multisets a little bit differently, which
    is why we don't use that name for this operation.)
    For [sum] we're giving you a header that does not give explicit
    names to the arguments.  Moreover, it uses the keyword
    [Definition] instead of [Fixpoint], so even if you had names for
    the arguments, you wouldn't be able to process them recursively.
    The point of stating the question this way is to encourage you to
    think about whether [sum] can be implemented in another way --
    perhaps by using functions that have already been defined.  *)

Definition sum : bag -> bag -> bag 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_sum1:              count 1 (sum [1;2;3] [1;4;1]) = 3.
 (* FILL IN HERE *) Admitted.

Definition add (v:nat) (s:bag) : bag 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_add1:                count 1 (add 1 [1;4;1]) = 3.
 (* FILL IN HERE *) Admitted.
Example test_add2:                count 5 (add 1 [1;4;1]) = 0.
 (* FILL IN HERE *) Admitted.

Definition member (v:nat) (s:bag) : bool 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_member1:             member 1 [1;4;1] = true.
 (* FILL IN HERE *) Admitted.

Example test_member2:             member 2 [1;4;1] = false.
 (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 3 stars, optional (bag_more_functions)  *)
(** Here are some more bag functions for you to practice with. *)

(** When remove_one is applied to a bag without the number to remove,
   it should return the same bag unchanged. *)

Fixpoint remove_one (v:nat) (s:bag) : bag 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_remove_one1:
  count 5 (remove_one 5 [2;1;5;4;1]) = 0.
  (* FILL IN HERE *) Admitted.

Example test_remove_one2:
  count 5 (remove_one 5 [2;1;4;1]) = 0.
  (* FILL IN HERE *) Admitted.

Example test_remove_one3:
  count 4 (remove_one 5 [2;1;4;5;1;4]) = 2.
  (* FILL IN HERE *) Admitted.

Example test_remove_one4:
  count 5 (remove_one 5 [2;1;5;4;5;1;4]) = 1.
  (* FILL IN HERE *) Admitted.

Fixpoint remove_all (v:nat) (s:bag) : bag 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_remove_all1:  count 5 (remove_all 5 [2;1;5;4;1]) = 0.
 (* FILL IN HERE *) Admitted.
Example test_remove_all2:  count 5 (remove_all 5 [2;1;4;1]) = 0.
 (* FILL IN HERE *) Admitted.
Example test_remove_all3:  count 4 (remove_all 5 [2;1;4;5;1;4]) = 2.
 (* FILL IN HERE *) Admitted.
Example test_remove_all4:  count 5 (remove_all 5 [2;1;5;4;5;1;4;5;1;4]) = 0.
 (* FILL IN HERE *) Admitted.

Fixpoint subset (s1:bag) (s2:bag) : bool 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_subset1:              subset [1;2] [2;1;4;1] = true.
 (* FILL IN HERE *) Admitted.
Example test_subset2:              subset [1;2;2] [2;1;4;1] = false.
 (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 3 stars, recommended (bag_theorem)  *)
(** Write down an interesting theorem [bag_theorem] about bags
    involving the functions [count] and [add], and prove it.  Note
    that, since this problem is somewhat open-ended, it's possible
    that you may come up with a theorem which is true, but whose proof
    requires techniques you haven't learned yet.  Feel free to ask for
    help if you get stuck! *)

(*
Theorem bag_theorem : ...
Proof.
  ...
Qed.
*)

(** [] *)

(* ################################################################# *)
(** * Reasoning About Lists *)

(** As with numbers, simple facts about list-processing
    functions can sometimes be proved entirely by simplification.  For
    example, the simplification performed by [reflexivity] is enough
    for this theorem... *)

Theorem nil_app : forall l:natlist,
  [] ++ l = l.
Proof. reflexivity. Qed.

(** ... because the [[]] is substituted into the match
    "scrutinee" in the definition of [app], allowing the match itself
    to be simplified. *)

(** Also, as with numbers, it is sometimes helpful to perform case
    analysis on the possible shapes (empty or non-empty) of an unknown
    list. *)

Theorem tl_length_pred : forall l:natlist,
  pred (length l) = length (tl l).
Proof.
  intros l. destruct l as [| n l'].
  - (* l = nil *)
    reflexivity.
  - (* l = cons n l' *)
    reflexivity.  Qed.

(** Here, the [nil] case works because we've chosen to define
    [tl nil = nil]. Notice that the [as] annotation on the [destruct]
    tactic here introduces two names, [n] and [l'], corresponding to
    the fact that the [cons] constructor for lists takes two
    arguments (the head and tail of the list it is constructing). *)

(** Usually, though, interesting theorems about lists require
    induction for their proofs. *)

(* ----------------------------------------------------------------- *)
(** *** Micro-Sermon *)

(** Simply reading example proof scripts will not get you very far!
    It is important to work through the details of each one, using Coq
    and thinking about what each step achieves.  Otherwise it is more
    or less guaranteed that the exercises will make no sense when you
    get to them.  'Nuff said. *)

(* ================================================================= *)
(** ** Induction on Lists *)

(** Proofs by induction over datatypes like [natlist] are a
    little less familiar than standard natural number induction, but
    the idea is equally simple.  Each [Inductive] declaration defines
    a set of data values that can be built up using the declared
    constructors: a boolean can be either [true] or [false]; a number
    can be either [O] or [S] applied to another number; a list can be
    either [nil] or [cons] applied to a number and a list.

    Moreover, applications of the declared constructors to one another
    are the _only_ possible shapes that elements of an inductively
    defined set can have, and this fact directly gives rise to a way
    of reasoning about inductively defined sets: a number is either
    [O] or else it is [S] applied to some _smaller_ number; a list is
    either [nil] or else it is [cons] applied to some number and some
    _smaller_ list; etc. So, if we have in mind some proposition [P]
    that mentions a list [l] and we want to argue that [P] holds for
    _all_ lists, we can reason as follows:

      - First, show that [P] is true of [l] when [l] is [nil].

      - Then show that [P] is true of [l] when [l] is [cons n l'] for
        some number [n] and some smaller list [l'], assuming that [P]
        is true for [l'].

    Since larger lists can only be built up from smaller ones,
    eventually reaching [nil], these two arguments together establish
    the truth of [P] for all lists [l].  Here's a concrete example: *)

Theorem app_assoc : forall l1 l2 l3 : natlist,
  (l1 ++ l2) ++ l3 = l1 ++ (l2 ++ l3).
Proof.
  intros l1 l2 l3. induction l1 as [| n l1' IHl1'].
  - (* l1 = nil *)
    reflexivity.
  - (* l1 = cons n l1' *)
    simpl. rewrite -> IHl1'. reflexivity.  Qed.

(** Notice that, as when doing induction on natural numbers, the
    [as...] clause provided to the [induction] tactic gives a name to
    the induction hypothesis corresponding to the smaller list [l1']
    in the [cons] case. Once again, this Coq proof is not especially
    illuminating as a static written document -- it is easy to see
    what's going on if you are reading the proof in an interactive Coq
    session and you can see the current goal and context at each
    point, but this state is not visible in the written-down parts of
    the Coq proof.  So a natural-language proof -- one written for
    human readers -- will need to include more explicit signposts; in
    particular, it will help the reader stay oriented if we remind
    them exactly what the induction hypothesis is in the second
    case. *)

(** For comparison, here is an informal proof of the same theorem. *)

(** _Theorem_: For all lists [l1], [l2], and [l3],
   [(l1 ++ l2) ++ l3 = l1 ++ (l2 ++ l3)].

   _Proof_: By induction on [l1].

   - First, suppose [l1 = []].  We must show

       ([] ++ l2) ++ l3 = [] ++ (l2 ++ l3),

     which follows directly from the definition of [++].

   - Next, suppose [l1 = n::l1'], with

       (l1' ++ l2) ++ l3 = l1' ++ (l2 ++ l3)

     (the induction hypothesis). We must show

       ((n :: l1') ++ l2) ++ l3 = (n :: l1') ++ (l2 ++ l3).

     By the definition of [++], this follows from

       n :: ((l1' ++ l2) ++ l3) = n :: (l1' ++ (l2 ++ l3)),

     which is immediate from the induction hypothesis.  [] *)

(* ----------------------------------------------------------------- *)
(** *** Reversing a list *)

(** For a slightly more involved example of inductive proof over
    lists, suppose we use [app] to define a list-reversing function
    [rev]: *)

Fixpoint rev (l:natlist) : natlist :=
  match l with
  | nil    => nil
  | h :: t => rev t ++ [h]
  end.

Example test_rev1:            rev [1;2;3] = [3;2;1].
Proof. reflexivity.  Qed.
Example test_rev2:            rev nil = nil.
Proof. reflexivity.  Qed.

(* ----------------------------------------------------------------- *)
(** *** Proofs about reverse *)

(** Now let's prove some theorems about our newly defined [rev].
    For something a bit more challenging than what we've seen, let's
    prove that reversing a list does not change its length.  Our first
    attempt gets stuck in the successor case... *)

Theorem rev_length_firsttry : forall l : natlist,
  length (rev l) = length l.
Proof.
  intros l. induction l as [| n l' IHl'].
  - (* l = [] *)
    reflexivity.
  - (* l = n :: l' *)
    (* This is the tricky case.  Let's begin as usual
       by simplifying. *)
    simpl.
    (* Now we seem to be stuck: the goal is an equality
       involving [++], but we don't have any useful equations
       in either the immediate context or in the global
       environment!  We can make a little progress by using
       the IH to rewrite the goal... *)
    rewrite <- IHl'.
    (* ... but now we can't go any further. *)
Abort.

(** So let's take the equation relating [++] and [length] that
    would have enabled us to make progress and prove it as a separate
    lemma. *)

Theorem app_length : forall l1 l2 : natlist,
  length (l1 ++ l2) = (length l1) + (length l2).
Proof.
  (* WORKED IN CLASS *)
  intros l1 l2. induction l1 as [| n l1' IHl1'].
  - (* l1 = nil *)
    reflexivity.
  - (* l1 = cons *)
    simpl. rewrite -> IHl1'. reflexivity.  Qed.

(** Note that, to make the lemma as general as possible, we
    quantify over _all_ [natlist]s, not just those that result from an
    application of [rev].  This should seem natural, because the truth
    of the goal clearly doesn't depend on the list having been
    reversed.  Moreover, it is easier to prove the more general
    property. *)

(** Now we can complete the original proof. *)

Theorem rev_length : forall l : natlist,
  length (rev l) = length l.
Proof.
  intros l. induction l as [| n l' IHl'].
  - (* l = nil *)
    reflexivity.
  - (* l = cons *)
    simpl. rewrite -> app_length, plus_comm.
    rewrite -> IHl'. reflexivity.  Qed.

(** For comparison, here are informal proofs of these two theorems:

    _Theorem_: For all lists [l1] and [l2],
       [length (l1 ++ l2) = length l1 + length l2].

    _Proof_: By induction on [l1].

    - First, suppose [l1 = []].  We must show

        length ([] ++ l2) = length [] + length l2,

      which follows directly from the definitions of
      [length] and [++].

    - Next, suppose [l1 = n::l1'], with

        length (l1' ++ l2) = length l1' + length l2.

      We must show

        length ((n::l1') ++ l2) = length (n::l1') + length l2).

      This follows directly from the definitions of [length] and [++]
      together with the induction hypothesis. [] *)

(** _Theorem_: For all lists [l], [length (rev l) = length l].

    _Proof_: By induction on [l].

      - First, suppose [l = []].  We must show

          length (rev []) = length [],

        which follows directly from the definitions of [length]
        and [rev].

      - Next, suppose [l = n::l'], with

          length (rev l') = length l'.

        We must show

          length (rev (n :: l')) = length (n :: l').

        By the definition of [rev], this follows from

          length ((rev l') ++ [n]) = S (length l')

        which, by the previous lemma, is the same as

          length (rev l') + length [n] = S (length l').

        This follows directly from the induction hypothesis and the
        definition of [length]. [] *)

(** The style of these proofs is rather longwinded and pedantic.
    After the first few, we might find it easier to follow proofs that
    give fewer details (which can easily work out in our own minds or
    on scratch paper if necessary) and just highlight the non-obvious
    steps.  In this more compressed style, the above proof might look
    like this: *)

(** _Theorem_:
     For all lists [l], [length (rev l) = length l].

    _Proof_: First, observe that [length (l ++ [n]) = S (length l)]
     for any [l] (this follows by a straightforward induction on [l]).
     The main property again follows by induction on [l], using the
     observation together with the induction hypothesis in the case
     where [l = n'::l']. [] *)

(** Which style is preferable in a given situation depends on
    the sophistication of the expected audience and how similar the
    proof at hand is to ones that the audience will already be
    familiar with.  The more pedantic style is a good default for our
    present purposes. *)

(* ================================================================= *)
(** ** [SearchAbout] *)

(** We've seen that proofs can make use of other theorems we've
    already proved, e.g., using [rewrite].  But in order to refer to a
    theorem, we need to know its name!  Indeed, it is often hard even
    to remember what theorems have been proven, much less what they
    are called.

    Coq's [SearchAbout] command is quite helpful with this.  Typing
    [SearchAbout foo] will cause Coq to display a list of all theorems
    involving [foo].  For example, try uncommenting the following line 
    to see a list of theorems that we have proved about [rev]: *)

(*  SearchAbout rev. *)

(** Keep [SearchAbout] in mind as you do the following exercises and
    throughout the rest of the book; it can save you a lot of time!

    If you are using ProofGeneral, you can run [SearchAbout] with [C-c
    C-a C-a]. Pasting its response into your buffer can be
    accomplished with [C-c C-;]. *)

(* ================================================================= *)
(** ** List Exercises, Part 1 *)

(** **** Exercise: 3 stars (list_exercises)  *)
(** More practice with lists: *)

Theorem app_nil_r : forall l : natlist,
  l ++ [] = l.
Proof.
  (* FILL IN HERE *) Admitted.


Theorem rev_involutive : forall l : natlist,
  rev (rev l) = l.
Proof.
  (* FILL IN HERE *) Admitted.

(** There is a short solution to the next one.  If you find yourself
    getting tangled up, step back and try to look for a simpler
    way. *)

Theorem app_assoc4 : forall l1 l2 l3 l4 : natlist,
  l1 ++ (l2 ++ (l3 ++ l4)) = ((l1 ++ l2) ++ l3) ++ l4.
Proof.
  (* FILL IN HERE *) Admitted.

(** An exercise about your implementation of [nonzeros]: *)

Lemma nonzeros_app : forall l1 l2 : natlist,
  nonzeros (l1 ++ l2) = (nonzeros l1) ++ (nonzeros l2).
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 2 stars (beq_natlist)  *)
(** Fill in the definition of [beq_natlist], which compares
    lists of numbers for equality.  Prove that [beq_natlist l l]
    yields [true] for every list [l]. *)

Fixpoint beq_natlist (l1 l2 : natlist) : bool 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_beq_natlist1 :
  (beq_natlist nil nil = true).
 (* FILL IN HERE *) Admitted.

Example test_beq_natlist2 :
  beq_natlist [1;2;3] [1;2;3] = true.
(* FILL IN HERE *) Admitted.

Example test_beq_natlist3 :
  beq_natlist [1;2;3] [1;2;4] = false.
 (* FILL IN HERE *) Admitted.

Theorem beq_natlist_refl : forall l:natlist,
  true = beq_natlist l l.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(* ================================================================= *)
(** ** List Exercises, Part 2 *)

(** **** Exercise: 3 stars, advanced (bag_proofs)  *)
(** Here are a couple of little theorems to prove about your
    definitions about bags earlier in the file. *)

Theorem count_member_nonzero : forall (s : bag),
  leb 1 (count 1 (1 :: s)) = true.
Proof.
  (* FILL IN HERE *) Admitted.

(** The following lemma about [leb] might help you in the next proof. *)

Theorem ble_n_Sn : forall n,
  leb n (S n) = true.
Proof.
  intros n. induction n as [| n' IHn'].
  - (* 0 *)
    simpl.  reflexivity.
  - (* S n' *)
    simpl.  rewrite IHn'.  reflexivity.  Qed.

Theorem remove_decreases_count: forall (s : bag),
  leb (count 0 (remove_one 0 s)) (count 0 s) = true.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 3 stars, optional (bag_count_sum)  *)
(** Write down an interesting theorem [bag_count_sum] about bags
    involving the functions [count] and [sum], and prove it.*)

(* FILL IN HERE *)
(** [] *)

(** **** Exercise: 4 stars, advanced (rev_injective)  *)
(** Prove that the [rev] function is injective -- that is,

    forall (l1 l2 : natlist), rev l1 = rev l2 -> l1 = l2.

(There is a hard way and an easy way to do this.) *)

(* FILL IN HERE *)
(** [] *)


(* ################################################################# *)
(** * Options *)

(** Suppose we want to write a function that returns the [n]th
    element of some list.  If we give it type [nat -> natlist -> nat],
    then we'll have to choose some number to return when the list is
    too short... *)

Fixpoint nth_bad (l:natlist) (n:nat) : nat :=
  match l with
  | nil => 42  (* arbitrary! *)
  | a :: l' => match beq_nat n O with
               | true => a
               | false => nth_bad l' (pred n)
               end
  end.

(** This solution is not so good: If [nth_bad] returns [42], we
    can't tell whether that value actually appears on the input
    without further processing. A better alternative is to change the
    return type of [nth_bad] to include an error value as a possible
    outcome. We call this type [natoption]. *)

Inductive natoption : Type :=
  | Some : nat -> natoption
  | None : natoption.

(** We can then change the above definition of [nth_bad] to
    return [None] when the list is too short and [Some a] when the
    list has enough members and [a] appears at position [n]. We call
    this new function [nth_error] to indicate that it may result in an
    error. *)

Fixpoint nth_error (l:natlist) (n:nat) : natoption :=
  match l with
  | nil => None
  | a :: l' => match beq_nat n O with
               | true => Some a
               | false => nth_error l' (pred n)
               end
  end.

Example test_nth_error1 : nth_error [4;5;6;7] 0 = Some 4.
Proof. reflexivity. Qed.
Example test_nth_error2 : nth_error [4;5;6;7] 3 = Some 7.
Proof. reflexivity. Qed.
Example test_nth_error3 : nth_error [4;5;6;7] 9 = None.
Proof. reflexivity. Qed.

(** (In the HTML version, the boilerplate proofs of these
    examples are elided.  Click on a box if you want to see one.)

    This example is also an opportunity to introduce one more small
    feature of Coq's programming language: conditional
    expressions... *)

Fixpoint nth_error' (l:natlist) (n:nat) : natoption :=
  match l with
  | nil => None
  | a :: l' => if beq_nat n O then Some a
               else nth_error' l' (pred n)
  end.

(** Coq's conditionals are exactly like those found in any other
    language, with one small generalization.  Since the boolean type
    is not built in, Coq actually allows conditional expressions over
    _any_ inductively defined type with exactly two constructors.  The
    guard is considered true if it evaluates to the first constructor
    in the [Inductive] definition and false if it evaluates to the
    second. *)

(** The function below pulls the [nat] out of a [natoption], returning
    a supplied default in the [None] case. *)

Definition option_elim (d : nat) (o : natoption) : nat :=
  match o with
  | Some n' => n'
  | None => d
  end.

(** **** Exercise: 2 stars (hd_error)  *)
(** Using the same idea, fix the [hd] function from earlier so we don't
    have to pass a default element for the [nil] case.  *)

Definition hd_error (l : natlist) : natoption 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_hd_error1 : hd_error [] = None.
 (* FILL IN HERE *) Admitted.

Example test_hd_error2 : hd_error [1] = Some 1.
 (* FILL IN HERE *) Admitted.

Example test_hd_error3 : hd_error [5;6] = Some 5.
 (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 1 star, optional (option_elim_hd)  *)
(** This exercise relates your new [hd_error] to the old [hd]. *)

Theorem option_elim_hd : forall (l:natlist) (default:nat),
  hd default l = option_elim default (hd_error l).
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

End NatList.

(* ################################################################# *)
(** * Partial Maps *)

(** As a final illustration of how data structures can be defined in
    Coq, here is a simple _partial map_ data type, analogous to the
    map or dictionary data structures found in most programming
    languages. *)

(** First, we define a new inductive datatype [id] to serve as the
    "keys" of our partial maps. *)

Inductive id : Type :=
  | Id : nat -> id.

(** Internally, an [id] is just a number.  Introducing a separate type
    by wrapping each nat with the tag [Id] makes definitions more
    readable and gives us the flexibility to change representations
    later if we wish.

    We'll also need an equality test for [id]s: *)

Definition beq_id x1 x2 :=
  match x1, x2 with
  | Id n1, Id n2 => beq_nat n1 n2
  end.

(** **** Exercise: 1 star (beq_id_refl)  *)
Theorem beq_id_refl : forall x, true = beq_id x x.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** Now we define the type of partial maps: *)

Module PartialMap.
Import NatList.
  
Inductive partial_map : Type :=
  | empty  : partial_map
  | record : id -> nat -> partial_map -> partial_map.

(** This declaration can be read: "There are two ways to construct a
    [partial_map]: either using the constructor [empty] to represent an
    empty partial map, or by applying the constructor [record] to
    a key, a value, and an existing [partial_map] to construct a
    [partial_map] with an additional key-to-value mapping." *)

(** The [update] function overrides the entry for a given key in a
    partial map (or adds a new entry if the given key is not already
    present). *)

Definition update (d : partial_map)
                  (key : id) (value : nat)
                  : partial_map :=
  record key value d.

(** Last, the [find] function searches a [partial_map] for a given
    key.  It returns [None] if the key was not found and [Some val] if
    the key was associated with [val]. If the same key is mapped to
    multiple values, [find] will return the first one it
    encounters. *)

Fixpoint find (key : id) (d : partial_map) : natoption :=
  match d with
  | empty         => None
  | record k v d' => if beq_id key k
                     then Some v
                     else find key d'
  end.

(** **** Exercise: 1 star (update_eq)  *)
Theorem update_eq :
  forall (d : partial_map) (k : id) (v: nat),
    find k (update d k v) = Some v.
Proof.
 (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 1 star (update_neq)  *)
Theorem update_neq :
  forall (d : partial_map) (m n : id) (o: nat),
    beq_id m n = false -> find m (update d n o) = find m d.
Proof.
 (* FILL IN HERE *) Admitted.
(** [] *)

End PartialMap.

(** **** Exercise: 2 stars (baz_num_elts)  *)
(** Consider the following inductive definition: *)

Inductive baz : Type :=
  | Baz1 : baz -> baz
  | Baz2 : baz -> bool -> baz.

(** How _many_ elements does the type [baz] have?  (Answer in English
    or the natural language of your choice.)

(* FILL IN HERE *)
*)
(** [] *)

(** $Date: 2016-07-11 21:31:32 -0400 (Mon, 11 Jul 2016) $ *)

(** * Induction: Proof by Induction *)

(** First, we import all of our definitions from the previous
    chapter. *)

Require Export Basics.

(** For the [Require Export] to work, you first need to use
    [coqc] to compile [Basics.v] into [Basics.vo].  This is like
    making a .class file from a .java file, or a .o file from a .c
    file.  There are two ways to do it:

     - In CoqIDE:

         Open [Basics.v].  In the "Compile" menu, click on "Compile
         Buffer".

     - From the command line:

         Run [coqc Basics.v]

    *)

(* ################################################################# *)
(** * Proof by Induction *)

(** We proved in the last chapter that [0] is a neutral element
    for [+] on the left using an easy argument based on
    simplification.  The fact that it is also a neutral element on the
    _right_... *)

Theorem plus_n_O_firsttry : forall n:nat,
  n = n + 0.

(** ... cannot be proved in the same simple way.  Just applying
  [reflexivity] doesn't work, since the [n] in [n + 0] is an arbitrary
  unknown number, so the [match] in the definition of [+] can't be
  simplified.  *)

Proof.
  intros n.
  simpl. (* Does nothing! *)
Abort.

(** And reasoning by cases using [destruct n] doesn't get us much
   further: the branch of the case analysis where we assume [n = 0]
   goes through fine, but in the branch where [n = S n'] for some [n'] we
   get stuck in exactly the same way.  We could use [destruct n'] to
   get one step further, but, since [n] can be arbitrarily large, if we
   try to keep on like this we'll never be done. *)

Theorem plus_n_O_secondtry : forall n:nat,
  n = n + 0.
Proof.
  intros n. destruct n as [| n'].
  - (* n = 0 *)
    reflexivity. (* so far so good... *)
  - (* n = S n' *)
    simpl.       (* ...but here we are stuck again *)
Abort.

(** To prove interesting facts about numbers, lists, and other
    inductively defined sets, we usually need a more powerful
    reasoning principle: _induction_.

    Recall (from high school, a discrete math course, etc.) the
    principle of induction over natural numbers: If [P(n)] is some
    proposition involving a natural number [n] and we want to show
    that [P] holds for _all_ numbers [n], we can reason like this:
         - show that [P(O)] holds;
         - show that, for any [n'], if [P(n')] holds, then so does
           [P(S n')];
         - conclude that [P(n)] holds for all [n].

    In Coq, the steps are the same but the order is backwards: we
    begin with the goal of proving [P(n)] for all [n] and break it
    down (by applying the [induction] tactic) into two separate
    subgoals: first showing [P(O)] and then showing [P(n') -> P(S
    n')].  Here's how this works for the theorem at hand: *)


Theorem plus_n_O : forall n:nat, n = n + 0.
Proof.
  intros n. induction n as [| n' IHn'].
  - (* n = 0 *)    reflexivity.
  - (* n = S n' *) simpl. rewrite <- IHn'. reflexivity.  Qed.

(** Like [destruct], the [induction] tactic takes an [as...]
    clause that specifies the names of the variables to be introduced
    in the subgoals.  In the first branch, [n] is replaced by [0] and
    the goal becomes [0 + 0 = 0], which follows by simplification.  In
    the second, [n] is replaced by [S n'] and the assumption [n' + 0 =
    n'] is added to the context (with the name [IHn'], i.e., the
    Induction Hypothesis for [n'] -- notice that this name is
    explicitly chosen in the [as...] clause of the call to [induction]
    rather than letting Coq choose one arbitrarily). The goal in this
    case becomes [(S n') + 0 = S n'], which simplifies to [S (n' + 0)
    = S n'], which in turn follows from [IHn']. *)

Theorem minus_diag : forall n,
  minus n n = 0.
Proof.
  (* WORKED IN CLASS *)
  intros n. induction n as [| n' IHn'].
  - (* n = 0 *)
    simpl. reflexivity.
  - (* n = S n' *)
    simpl. rewrite -> IHn'. reflexivity.  Qed.

(** (The use of the [intros] tactic in these proofs is actually
    redundant.  When applied to a goal that contains quantified
    variables, the [induction] tactic will automatically move them
    into the context as needed.) *)

(** **** Exercise: 2 stars, recommended (basic_induction)  *)
(** Prove the following using induction. You might need previously
    proven results. *)

Theorem mult_0_r : forall n:nat,
  n * 0 = 0.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem plus_n_Sm : forall n m : nat, 
  S (n + m) = n + (S m).
Proof.
  (* FILL IN HERE *) Admitted.

Theorem plus_comm : forall n m : nat,
  n + m = m + n.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem plus_assoc : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 2 stars (double_plus)  *)
(** Consider the following function, which doubles its argument: *)

Fixpoint double (n:nat) :=
  match n with
  | O => O
  | S n' => S (S (double n'))
  end.

(** Use induction to prove this simple fact about [double]: *)

Lemma double_plus : forall n, double n = n + n .
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 2 stars, optional (evenb_S)  *)
(** One inconveninent aspect of our definition of [evenb n] is that it
    may need to perform a recursive call on [n - 2]. This makes proofs
    about [evenb n] harder when done by induction on [n], since we may
    need an induction hypothesis about [n - 2]. The following lemma
    gives a better characterization of [evenb (S n)]: *)

Theorem evenb_S : forall n : nat,
  evenb (S n) = negb (evenb n).
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 1 star (destruct_induction)  *)
(** Briefly explain the difference between the tactics [destruct] 
    and [induction].

(* FILL IN HERE *)
*)
(** [] *)

(* ################################################################# *)
(** * Proofs Within Proofs *)

(** In Coq, as in informal mathematics, large proofs are often
    broken into a sequence of theorems, with later proofs referring to
    earlier theorems.  But sometimes a proof will require some
    miscellaneous fact that is too trivial and of too little general
    interest to bother giving it its own top-level name.  In such
    cases, it is convenient to be able to simply state and prove the
    needed "sub-theorem" right at the point where it is used.  The
    [assert] tactic allows us to do this.  For example, our earlier
    proof of the [mult_0_plus] theorem referred to a previous theorem
    named [plus_O_n].  We could instead use [assert] to state and
    prove [plus_O_n] in-line: *)

Theorem mult_0_plus' : forall n m : nat,
  (0 + n) * m = n * m.
Proof.
  intros n m.
  assert (H: 0 + n = n). { reflexivity. }
  rewrite -> H.
  reflexivity.  Qed.

(** The [assert] tactic introduces two sub-goals.  The first is
    the assertion itself; by prefixing it with [H:] we name the
    assertion [H].  (We can also name the assertion with [as] just as
    we did above with [destruct] and [induction], i.e., [assert (0 + n
    = n) as H].)  Note that we surround the proof of this assertion
    with curly braces [{ ... }], both for readability and so that,
    when using Coq interactively, we can see more easily when we have
    finished this sub-proof.  The second goal is the same as the one
    at the point where we invoke [assert] except that, in the context,
    we now have the assumption [H] that [0 + n = n].  That is,
    [assert] generates one subgoal where we must prove the asserted
    fact and a second subgoal where we can use the asserted fact to
    make progress on whatever we were trying to prove in the first
    place. *)

(** The [assert] tactic is handy in many sorts of situations.  For
    example, suppose we want to prove that [(n + m) + (p + q) = (m +
    n) + (p + q)]. The only difference between the two sides of the
    [=] is that the arguments [m] and [n] to the first inner [+] are
    swapped, so it seems we should be able to use the commutativity of
    addition ([plus_comm]) to rewrite one into the other.  However,
    the [rewrite] tactic is a little stupid about _where_ it applies
    the rewrite.  There are three uses of [+] here, and it turns out
    that doing [rewrite -> plus_comm] will affect only the _outer_
    one... *)

Theorem plus_rearrange_firsttry : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  (* We just need to swap (n + m) for (m + n)...
     it seems like plus_comm should do the trick! *)
  rewrite -> plus_comm.
  (* Doesn't work...Coq rewrote the wrong plus! *)
Abort.

(** To get [plus_comm] to apply at the point where we want it to, we
    can introduce a local lemma stating that [n + m = m + n] (for the
    particular [m] and [n] that we are talking about here), prove this
    lemma using [plus_comm], and then use it to do the desired
    rewrite. *)

Theorem plus_rearrange : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  assert (H: n + m = m + n).
  { rewrite -> plus_comm. reflexivity. }
  rewrite -> H. reflexivity.  Qed.

(* ################################################################# *)
(** * More Exercises *)

(** **** Exercise: 3 stars, recommended (mult_comm)  *)
(** Use [assert] to help prove this theorem.  You shouldn't need to
    use induction on [plus_swap]. *)

Theorem plus_swap : forall n m p : nat,
  n + (m + p) = m + (n + p).
Proof.
  (* FILL IN HERE *) Admitted.

(** Now prove commutativity of multiplication.  (You will probably
    need to define and prove a separate subsidiary theorem to be used
    in the proof of this one.  You may find that [plus_swap] comes in
    handy.) *)

Theorem mult_comm : forall m n : nat,
  m * n = n * m.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 3 stars, optional (more_exercises)  *)
(** Take a piece of paper.  For each of the following theorems, first
    _think_ about whether (a) it can be proved using only
    simplification and rewriting, (b) it also requires case
    analysis ([destruct]), or (c) it also requires induction.  Write
    down your prediction.  Then fill in the proof.  (There is no need
    to turn in your piece of paper; this is just to encourage you to
    reflect before you hack!) *)

Theorem leb_refl : forall n:nat,
  true = leb n n.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem zero_nbeq_S : forall n:nat,
  beq_nat 0 (S n) = false.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem andb_false_r : forall b : bool,
  andb b false = false.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem plus_ble_compat_l : forall n m p : nat,
  leb n m = true -> leb (p + n) (p + m) = true.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem S_nbeq_0 : forall n:nat,
  beq_nat (S n) 0 = false.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem mult_1_l : forall n:nat, 1 * n = n.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem all3_spec : forall b c : bool,
    orb
      (andb b c)
      (orb (negb b)
               (negb c))
  = true.
Proof.
  (* FILL IN HERE *) Admitted.

Theorem mult_plus_distr_r : forall n m p : nat,
  (n + m) * p = (n * p) + (m * p).
Proof.
  (* FILL IN HERE *) Admitted.

Theorem mult_assoc : forall n m p : nat,
  n * (m * p) = (n * m) * p.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 2 stars, optional (beq_nat_refl)  *)
(** Prove the following theorem.  (Putting the [true] on the left-hand
    side of the equality may look odd, but this is how the theorem is
    stated in the Coq standard library, so we follow suit.  Rewriting
    works equally well in either direction, so we will have no problem
    using the theorem no matter which way we state it.) *)

Theorem beq_nat_refl : forall n : nat,
  true = beq_nat n n.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 2 stars, optional (plus_swap')  *)
(** The [replace] tactic allows you to specify a particular subterm to
   rewrite and what you want it rewritten to: [replace (t) with (u)]
   replaces (all copies of) expression [t] in the goal by expression
   [u], and generates [t = u] as an additional subgoal. This is often
   useful when a plain [rewrite] acts on the wrong part of the goal.

   Use the [replace] tactic to do a proof of [plus_swap'], just like
   [plus_swap] but without needing [assert (n + m = m + n)]. *)

Theorem plus_swap' : forall n m p : nat,
  n + (m + p) = m + (n + p).
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 3 stars, recommended (binary_commute)  *)
(** Recall the [incr] and [bin_to_nat] functions that you
    wrote for the [binary] exercise in the [Basics] chapter.  Prove
    that the following diagram commutes:

               bin --------- incr -------> bin
                |                           |
            bin_to_nat                  bin_to_nat
                |                           |
                v                           v
               nat ---------- S ---------> nat

    That is, incrementing a binary number and then converting it to 
    a (unary) natural number yields the same result as first converting
    it to a natural number and then incrementing.  
    Name your theorem [bin_to_nat_pres_incr] ("pres" for "preserves").

    Before you start working on this exercise, please copy the
    definitions from your solution to the [binary] exercise here so
    that this file can be graded on its own.  If you find yourself
    wanting to change your original definitions to make the property
    easier to prove, feel free to do so! *)

(* FILL IN HERE *)
(** [] *)

(** **** Exercise: 5 stars, advanced (binary_inverse)  *)
(** This exercise is a continuation of the previous exercise about
    binary numbers.  You will need your definitions and theorems from
    there to complete this one.

    (a) First, write a function to convert natural numbers to binary
        numbers.  Then prove that starting with any natural number,
        converting to binary, then converting back yields the same
        natural number you started with.

    (b) You might naturally think that we should also prove the
        opposite direction: that starting with a binary number,
        converting to a natural, and then back to binary yields the
        same number we started with.  However, this is not true!
        Explain what the problem is.

    (c) Define a "direct" normalization function -- i.e., a function
        [normalize] from binary numbers to binary numbers such that,
        for any binary number b, converting to a natural and then back
        to binary yields [(normalize b)].  Prove it.  (Warning: This
        part is tricky!)

    Again, feel free to change your earlier definitions if this helps
    here. *)

(* FILL IN HERE *)
(** [] *)

(* ################################################################# *)
(** * Formal vs. Informal Proof (Optional) *)

(** "_Informal proofs are algorithms; formal proofs are code_." *)

(** The question of what constitutes a proof of a mathematical
    claim has challenged philosophers for millennia, but a rough and
    ready definition could be this: A proof of a mathematical
    proposition [P] is a written (or spoken) text that instills in the
    reader or hearer the certainty that [P] is true.  That is, a proof
    is an act of communication.

    Acts of communication may involve different sorts of readers.  On
    one hand, the "reader" can be a program like Coq, in which case
    the "belief" that is instilled is that [P] can be mechanically
    derived from a certain set of formal logical rules, and the proof
    is a recipe that guides the program in checking this fact.  Such
    recipes are _formal_ proofs.

    Alternatively, the reader can be a human being, in which case the
    proof will be written in English or some other natural language,
    and will thus necessarily be _informal_.  Here, the criteria for
    success are less clearly specified.  A "valid" proof is one that
    makes the reader believe [P].  But the same proof may be read by
    many different readers, some of whom may be convinced by a
    particular way of phrasing the argument, while others may not be.
    Some readers may be particularly pedantic, inexperienced, or just
    plain thick-headed; the only way to convince them will be to make
    the argument in painstaking detail.  But other readers, more
    familiar in the area, may find all this detail so overwhelming
    that they lose the overall thread; all they want is to be told the
    main ideas, since it is easier for them to fill in the details for
    themselves than to wade through a written presentation of them.
    Ultimately, there is no universal standard, because there is no
    single way of writing an informal proof that is guaranteed to
    convince every conceivable reader.

    In practice, however, mathematicians have developed a rich set of
    conventions and idioms for writing about complex mathematical
    objects that -- at least within a certain community -- make
    communication fairly reliable.  The conventions of this stylized
    form of communication give a fairly clear standard for judging
    proofs good or bad.

    Because we are using Coq in this course, we will be working
    heavily with formal proofs.  But this doesn't mean we can
    completely forget about informal ones!  Formal proofs are useful
    in many ways, but they are _not_ very efficient ways of
    communicating ideas between human beings. *)

(** For example, here is a proof that addition is associative: *)

Theorem plus_assoc' : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof. intros n m p. induction n as [| n' IHn']. reflexivity.
  simpl. rewrite -> IHn'. reflexivity.  Qed.

(** Coq is perfectly happy with this.  For a human, however, it
    is difficult to make much sense of it.  We can use comments and
    bullets to show the structure a little more clearly... *)

Theorem plus_assoc'' : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros n m p. induction n as [| n' IHn'].
  - (* n = 0 *)
    reflexivity.
  - (* n = S n' *)
    simpl. rewrite -> IHn'. reflexivity.   Qed.

(** ... and if you're used to Coq you may be able to step
    through the tactics one after the other in your mind and imagine
    the state of the context and goal stack at each point, but if the
    proof were even a little bit more complicated this would be next
    to impossible.

    A (pedantic) mathematician might write the proof something like
    this: *)

(** - _Theorem_: For any [n], [m] and [p],

      n + (m + p) = (n + m) + p.

    _Proof_: By induction on [n].

    - First, suppose [n = 0].  We must show

        0 + (m + p) = (0 + m) + p.

      This follows directly from the definition of [+].

    - Next, suppose [n = S n'], where

        n' + (m + p) = (n' + m) + p.

      We must show

        (S n') + (m + p) = ((S n') + m) + p.

      By the definition of [+], this follows from

        S (n' + (m + p)) = S ((n' + m) + p),

      which is immediate from the induction hypothesis.  _Qed_. *)


(** The overall form of the proof is basically similar, and of
    course this is no accident: Coq has been designed so that its
    [induction] tactic generates the same sub-goals, in the same
    order, as the bullet points that a mathematician would write.  But
    there are significant differences of detail: the formal proof is
    much more explicit in some ways (e.g., the use of [reflexivity])
    but much less explicit in others (in particular, the "proof state"
    at any given point in the Coq proof is completely implicit,
    whereas the informal proof reminds the reader several times where
    things stand). *)

(** **** Exercise: 2 stars, advanced, recommended (plus_comm_informal)  *)
(** Translate your solution for [plus_comm] into an informal proof:

    Theorem: Addition is commutative.

    Proof: (* FILL IN HERE *)
*)
(** [] *)

(** **** Exercise: 2 stars, optional (beq_nat_refl_informal)  *)
(** Write an informal proof of the following theorem, using the
    informal proof of [plus_assoc] as a model.  Don't just
    paraphrase the Coq tactics into English!

    Theorem: [true = beq_nat n n] for any [n].

    Proof: (* FILL IN HERE *)
[] *)

(** $Date: 2016-05-26 16:17:19 -0400 (Thu, 26 May 2016) $ *)

(**` * Basics: Functional Programming in Coq *)

(* REMINDER:

          #####################################################
          ###  PLEASE DO NOT DISTRIBUTE SOLUTIONS PUBLICLY  ###
          #####################################################

   (See the [Preface] for why.) 

*)

(* [Admitted] is Coq's "escape hatch" that says accept this definition
   without proof.  We use it to mark the 'holes' in the development
   that should be completed as part of your homework exercises.  In
   practice, [Admitted] is useful when you're incrementally developing
   large proofs. *)
Definition admit {T: Type} : T.  Admitted.

(* ################################################################# *)
(** * Introduction *)

(** The functional programming style brings programming closer to
    simple, everyday mathematics: If a procedure or method has no side
    effects, then (ignoring efficiency) all we need to understand
    about it is how it maps inputs to outputs -- that is, we can think
    of it as just a concrete method for computing a mathematical
    function.  This is one sense of the word "functional" in
    "functional programming."  The direct connection between programs
    and simple mathematical objects supports both formal correctness
    proofs and sound informal reasoning about program behavior.

    The other sense in which functional programming is "functional" is
    that it emphasizes the use of functions (or methods) as
    _first-class_ values -- i.e., values that can be passed as
    arguments to other functions, returned as results, included in
    data structures, etc.  The recognition that functions can be
    treated as data in this way enables a host of useful and powerful
    idioms.

    Other common features of functional languages include _algebraic
    data types_ and _pattern matching_, which make it easy to
    construct and manipulate rich data structures, and sophisticated
    _polymorphic type systems_ supporting abstraction and code reuse.
    Coq shares all of these features.

    The first half of this chapter introduces the most essential
    elements of Coq's functional programming language.  The second
    half introduces some basic _tactics_ that can be used to prove
    simple properties of Coq programs. *)

(* ################################################################# *)
(** * Enumerated Types *)

(** One unusual aspect of Coq is that its set of built-in
    features is _extremely_ small.  For example, instead of providing
    the usual palette of atomic data types (booleans, integers,
    strings, etc.), Coq offers a powerful mechanism for defining new
    data types from scratch, from which all these familiar types arise
    as instances.

    Naturally, the Coq distribution comes with an extensive standard
    library providing definitions of booleans, numbers, and many
    common data structures like lists and hash tables.  But there is
    nothing magic or primitive about these library definitions.  To
    illustrate this, we will explicitly recapitulate all the
    definitions we need in this course, rather than just getting them
    implicitly from the library.

    To see how this definition mechanism works, let's start with a
    very simple example. *)

(* ================================================================= *)
(** ** Days of the Week *)

(** The following declaration tells Coq that we are defining
    a new set of data values -- a _type_. *)

Inductive day : Type :=
  | monday : day
  | tuesday : day
  | wednesday : day
  | thursday : day
  | friday : day
  | saturday : day
  | sunday : day.

(** The type is called [day], and its members are [monday],
    [tuesday], etc.  The second and following lines of the definition
    can be read "[monday] is a [day], [tuesday] is a [day], etc."

    Having defined [day], we can write functions that operate on
    days. *)

Definition next_weekday (d:day) : day :=
  match d with
  | monday    => tuesday
  | tuesday   => wednesday
  | wednesday => thursday
  | thursday  => friday
  | friday    => monday
  | saturday  => monday
  | sunday    => monday
  end.

(** One thing to note is that the argument and return types of
    this function are explicitly declared.  Like most functional
    programming languages, Coq can often figure out these types for
    itself when they are not given explicitly -- i.e., it performs
    _type inference_ -- but we'll include them to make reading
    easier. *)

(** Having defined a function, we should check that it works on
    some examples.  There are actually three different ways to do this
    in Coq.

    First, we can use the command [Compute] to evaluate a compound
    expression involving [next_weekday]. *)

Compute (next_weekday friday).
(* ==> monday : day *)

Compute (next_weekday (next_weekday saturday)).
(* ==> tuesday : day *)

(** (We show Coq's responses in comments, but, if you have a
    computer handy, this would be an excellent moment to fire up the
    Coq interpreter under your favorite IDE -- either CoqIde or Proof
    General -- and try this for yourself.  Load this file, [Basics.v],
    from the book's accompanying Coq sources, find the above example,
    submit it to Coq, and observe the result.)

    Second, we can record what we _expect_ the result to be in the
    form of a Coq example: *)

Example test_next_weekday:
  (next_weekday (next_weekday saturday)) = tuesday.

(** This declaration does two things: it makes an
    assertion (that the second weekday after [saturday] is [tuesday]),
    and it gives the assertion a name that can be used to refer to it
    later.

    Having made the assertion, we can also ask Coq to verify it, like
    this: *)

Proof. simpl. reflexivity.  Qed.

(** The details are not important for now (we'll come back to
    them in a bit), but essentially this can be read as "The assertion
    we've just made can be proved by observing that both sides of the
    equality evaluate to the same thing, after some simplification."

    Third, we can ask Coq to _extract_, from our [Definition], a
    program in some other, more conventional, programming
    language (OCaml, Scheme, or Haskell) with a high-performance
    compiler.  This facility is very interesting, since it gives us a
    way to construct _fully certified_ programs in mainstream
    languages.  Indeed, this is one of the main uses for which Coq was
    developed.  We'll come back to this topic in later chapters. *)

(* ================================================================= *)
(** ** Booleans *)

(** In a similar way, we can define the standard type [bool] of
    booleans, with members [true] and [false]. *)

Inductive bool : Type :=
  | true : bool
  | false : bool.

(** Although we are rolling our own booleans here for the sake
    of building up everything from scratch, Coq does, of course,
    provide a default implementation of the booleans in its standard
    library, together with a multitude of useful functions and
    lemmas.  (Take a look at [Coq.Init.Datatypes] in the Coq library
    documentation if you're interested.)  Whenever possible, we'll
    name our own definitions and theorems so that they exactly
    coincide with the ones in the standard library.

    Functions over booleans can be defined in the same way as
    above: *)

Definition negb (b:bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.

Definition orb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

(** The last two illustrate Coq's syntax for multi-argument
    function definitions.  The corresponding multi-argument
    application syntax is illustrated by the following four "unit
    tests," which constitute a complete specification -- a truth
    table -- for the [orb] function: *)

Example test_orb1:  (orb true  false) = true.
Proof. simpl. reflexivity.  Qed.
Example test_orb2:  (orb false false) = false.
Proof. simpl. reflexivity.  Qed.
Example test_orb3:  (orb false true)  = true.
Proof. simpl. reflexivity.  Qed.
Example test_orb4:  (orb true  true)  = true.
Proof. simpl. reflexivity.  Qed.

(** We can also introduce some familiar syntax for the boolean
    operations we have just defined. The [Infix] command defines new,
    infix notation for an existing definition. *)

Infix "&&" := andb.
Infix "||" := orb.

Example test_orb5:  false || false || true = true.
Proof. simpl. reflexivity. Qed.

(** _A note on notation_: In [.v] files, we use square brackets to
    delimit fragments of Coq code within comments; this convention,
    also used by the [coqdoc] documentation tool, keeps them visually
    separate from the surrounding text.  In the html version of the
    files, these pieces of text appear in a [different font].

    The special phrases [Admitted] and [admit] can be used as a
    placeholder for an incomplete definition or proof.  We'll use them
    in exercises, to indicate the parts that we're leaving for you --
    i.e., your job is to replace [admit] or [Admitted] with real
    definitions or proofs. *)

(** **** Exercise: 1 star (nandb)  *)
(** Remove [admit] and complete the definition of the following
    function; then make sure that the [Example] assertions below can
    each be verified by Coq.  (Remove "[Admitted.]" and fill in each
    proof, following the model of the [orb] tests above.) The function
    should return [true] if either or both of its inputs are
    [false]. *)

Definition nandb (b1:bool) (b2:bool) : bool 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_nandb1:               (nandb true false) = true.
(* FILL IN HERE *) Admitted.
Example test_nandb2:               (nandb false false) = true.
(* FILL IN HERE *) Admitted.
Example test_nandb3:               (nandb false true) = true.
(* FILL IN HERE *) Admitted.
Example test_nandb4:               (nandb true true) = false.
(* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 1 star (andb3)  *)
(** Do the same for the [andb3] function below. This function should
    return [true] when all of its inputs are [true], and [false]
    otherwise. *)

Definition andb3 (b1:bool) (b2:bool) (b3:bool) : bool 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_andb31:                 (andb3 true true true) = true.
(* FILL IN HERE *) Admitted.
Example test_andb32:                 (andb3 false true true) = false.
(* FILL IN HERE *) Admitted.
Example test_andb33:                 (andb3 true false true) = false.
(* FILL IN HERE *) Admitted.
Example test_andb34:                 (andb3 true true false) = false.
(* FILL IN HERE *) Admitted.
(** [] *)

(* ================================================================= *)
(** ** Function Types *)

(** Every expression in Coq has a type, describing what sort of
    thing it computes. The [Check] command asks Coq to print the type
    of an expression. *)

(** For example, the type of [negb true] is [bool]. *)

Check true.
(* ===> true : bool *)
Check (negb true).
(* ===> negb true : bool *)

(** Functions like [negb] itself are also data values, just like
    [true] and [false].  Their types are called _function types_, and
    they are written with arrows. *)

Check negb.
(* ===> negb : bool -> bool *)

(** The type of [negb], written [bool -> bool] and pronounced
    "[bool] arrow [bool]," can be read, "Given an input of type
    [bool], this function produces an output of type [bool]."
    Similarly, the type of [andb], written [bool -> bool -> bool], can
    be read, "Given two inputs, both of type [bool], this function
    produces an output of type [bool]." *)

(* ================================================================= *)
(** ** Modules *)

(** Coq provides a _module system_, to aid in organizing large
    developments.  In this course we won't need most of its features,
    but one is useful: If we enclose a collection of declarations
    between [Module X] and [End X] markers, then, in the remainder of
    the file after the [End], these definitions are referred to by
    names like [X.foo] instead of just [foo].  Here, we use this
    feature to introduce the definition of the type [nat] in an inner
    module so that it does not interfere with the one from the
    standard library, which comes with a bit of special notational
    magic.  *)

Module Playground1.

(* ================================================================= *)
(** ** Numbers *)

(** The types we have defined so far are examples of "enumerated
    types": their definitions explicitly enumerate a finite set of
    elements.  A more interesting way of defining a type is to give a
    collection of _inductive rules_ describing its elements.  For
    example, we can define the natural numbers as follows: *)

Inductive nat : Type :=
  | O : nat
  | S : nat -> nat.

(** The clauses of this definition can be read:
      - [O] is a natural number (note that this is the letter "[O],"
        not the numeral "[0]").
      - [S] is a "constructor" that takes a natural number and yields
        another one -- that is, if [n] is a natural number, then [S n]
        is too.

    Let's look at this in a little more detail.

    Every inductively defined set ([day], [nat], [bool], etc.) is
    actually a set of _expressions_.  The definition of [nat] says how
    expressions in the set [nat] can be constructed:

    - the expression [O] belongs to the set [nat];
    - if [n] is an expression belonging to the set [nat], then [S n]
      is also an expression belonging to the set [nat]; and
    - expressions formed in these two ways are the only ones belonging
      to the set [nat].

    The same rules apply for our definitions of [day] and [bool]. The
    annotations we used for their constructors are analogous to the
    one for the [O] constructor, indicating that they don't take any
    arguments.

    These three conditions are the precise force of the [Inductive]
    declaration.  They imply that the expression [O], the expression
    [S O], the expression [S (S O)], the expression [S (S (S O))], and
    so on all belong to the set [nat], while other expressions like
    [true], [andb true false], and [S (S false)] do not.

    We can write simple functions that pattern match on natural
    numbers just as we did above -- for example, the predecessor
    function: *)

Definition pred (n : nat) : nat :=
  match n with
    | O => O
    | S n' => n'
  end.

(** The second branch can be read: "if [n] has the form [S n']
    for some [n'], then return [n']."  *)

End Playground1.

Definition minustwo (n : nat) : nat :=
  match n with
    | O => O
    | S O => O
    | S (S n') => n'
  end.

(** Because natural numbers are such a pervasive form of data,
    Coq provides a tiny bit of built-in magic for parsing and printing
    them: ordinary arabic numerals can be used as an alternative to
    the "unary" notation defined by the constructors [S] and [O].  Coq
    prints numbers in arabic form by default: *)

Check (S (S (S (S O)))).
  (* ===> 4 : nat *)
Compute (minustwo 4).
  (* ===> 2 : nat *)

(** The constructor [S] has the type [nat -> nat], just like the
    functions [minustwo] and [pred]: *)

Check S.
Check pred.
Check minustwo.

(** These are all things that can be applied to a number to yield a
    number.  However, there is a fundamental difference between the
    first one and the other two: functions like [pred] and [minustwo]
    come with _computation rules_ -- e.g., the definition of [pred]
    says that [pred 2] can be simplified to [1] -- while the
    definition of [S] has no such behavior attached.  Although it is
    like a function in the sense that it can be applied to an
    argument, it does not _do_ anything at all!

    For most function definitions over numbers, just pattern matching
    is not enough: we also need recursion.  For example, to check that
    a number [n] is even, we may need to recursively check whether
    [n-2] is even.  To write such functions, we use the keyword
    [Fixpoint]. *)

Fixpoint evenb (n:nat) : bool :=
  match n with
  | O        => true
  | S O      => false
  | S (S n') => evenb n'
  end.

(** We can define [oddb] by a similar [Fixpoint] declaration, but here
    is a simpler definition that is a bit easier to work with: *)

Definition oddb (n:nat) : bool   :=   negb (evenb n).

Example test_oddb1:    oddb 1 = true.
Proof. simpl. reflexivity.  Qed.
Example test_oddb2:    oddb 4 = false.
Proof. simpl. reflexivity.  Qed.

(** (You will notice if you step through these proofs that
    [simpl] actually has no effect on the goal -- all of the work is
    done by [reflexivity].  We'll see more about why that is shortly.)

    Naturally, we can also define multi-argument functions by
    recursion.  *)

Module Playground2.

Fixpoint plus (n : nat) (m : nat) : nat :=
  match n with
    | O => m
    | S n' => S (plus n' m)
  end.

(** Adding three to two now gives us five, as we'd expect. *)

Compute (plus 3 2).

(** The simplification that Coq performs to reach this conclusion can
    be visualized as follows: *)

(*  [plus (S (S (S O))) (S (S O))]
==> [S (plus (S (S O)) (S (S O)))]
      by the second clause of the [match]
==> [S (S (plus (S O) (S (S O))))]
      by the second clause of the [match]
==> [S (S (S (plus O (S (S O)))))]
      by the second clause of the [match]
==> [S (S (S (S (S O))))]
      by the first clause of the [match]
*)

(** As a notational convenience, if two or more arguments have
    the same type, they can be written together.  In the following
    definition, [(n m : nat)] means just the same as if we had written
    [(n : nat) (m : nat)]. *)

Fixpoint mult (n m : nat) : nat :=
  match n with
    | O => O
    | S n' => plus m (mult n' m)
  end.

Example test_mult1: (mult 3 3) = 9.
Proof. simpl. reflexivity.  Qed.

(** You can match two expressions at once by putting a comma
    between them: *)

Fixpoint minus (n m:nat) : nat :=
  match n, m with
  | O   , _    => O
  | S _ , O    => n
  | S n', S m' => minus n' m'
  end.

(** The _ in the first line is a _wildcard pattern_.  Writing _ in a
    pattern is the same as writing some variable that doesn't get used
    on the right-hand side.  This avoids the need to invent a bogus
    variable name. *)

End Playground2.

Fixpoint exp (base power : nat) : nat :=
  match power with
    | O => S O
    | S p => mult base (exp base p)
  end.

(** **** Exercise: 1 star (factorial)  *)
(** Recall the standard mathematical factorial function:

       factorial(0)  =  1
       factorial(n)  =  n * factorial(n-1)     (if n>0)

    Translate this into Coq. *)

Fixpoint factorial (n:nat) : nat 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_factorial1:          (factorial 3) = 6.
(* FILL IN HERE *) Admitted.
Example test_factorial2:          (factorial 5) = (mult 10 12).
(* FILL IN HERE *) Admitted.
(** [] *)

(** We can make numerical expressions a little easier to read and
    write by introducing _notations_ for addition, multiplication, and
    subtraction. *)

Notation "x + y" := (plus x y)
                       (at level 50, left associativity)
                       : nat_scope.
Notation "x - y" := (minus x y)
                       (at level 50, left associativity)
                       : nat_scope.
Notation "x * y" := (mult x y)
                       (at level 40, left associativity)
                       : nat_scope.

Check ((0 + 1) + 1).

(** (The [level], [associativity], and [nat_scope] annotations
    control how these notations are treated by Coq's parser.  The
    details are not important, but interested readers can refer to the
    optional "More on Notation" section at the end of this chapter.)

    Note that these do not change the definitions we've already made:
    they are simply instructions to the Coq parser to accept [x + y]
    in place of [plus x y] and, conversely, to the Coq pretty-printer
    to display [plus x y] as [x + y].

    When we say that Coq comes with nothing built-in, we really mean
    it: even equality testing for numbers is a user-defined
    operation! *)

(** The [beq_nat] function tests [nat]ural numbers for [eq]uality,
    yielding a [b]oolean.  Note the use of nested [match]es (we could
    also have used a simultaneous match, as we did in [minus].)  *)

Fixpoint beq_nat (n m : nat) : bool :=
  match n with
  | O => match m with
         | O => true
         | S m' => false
         end
  | S n' => match m with
            | O => false
            | S m' => beq_nat n' m'
            end
  end.

(** The [leb] function tests whether its first argument is less than or
  equal to its second argument, yielding a boolean. *)

Fixpoint leb (n m : nat) : bool :=
  match n with
  | O => true
  | S n' =>
      match m with
      | O => false
      | S m' => leb n' m'
      end
  end.

Example test_leb1:             (leb 2 2) = true.
Proof. simpl. reflexivity.  Qed.
Example test_leb2:             (leb 2 4) = true.
Proof. simpl. reflexivity.  Qed.
Example test_leb3:             (leb 4 2) = false.
Proof. simpl. reflexivity.  Qed.

(** **** Exercise: 1 star (blt_nat)  *)
(** The [blt_nat] function tests [nat]ural numbers for [l]ess-[t]han,
    yielding a [b]oolean.  Instead of making up a new [Fixpoint] for
    this one, define it in terms of a previously defined function. *)

Definition blt_nat (n m : nat) : bool 
  (* REPLACE THIS LINE WITH   := _your_definition_ . *) . Admitted.

Example test_blt_nat1:             (blt_nat 2 2) = false.
(* FILL IN HERE *) Admitted.
Example test_blt_nat2:             (blt_nat 2 4) = true.
(* FILL IN HERE *) Admitted.
Example test_blt_nat3:             (blt_nat 4 2) = false.
(* FILL IN HERE *) Admitted.
(** [] *)

(* ################################################################# *)
(** * Proof by Simplification *)

(** Now that we've defined a few datatypes and functions, let's
    turn to stating and proving properties of their behavior.
    Actually, we've already started doing this: each [Example] in the
    previous sections makes a precise claim about the behavior of some
    function on some particular inputs.  The proofs of these claims
    were always the same: use [simpl] to simplify both sides of the
    equation, then use [reflexivity] to check that both sides contain
    identical values.

    The same sort of "proof by simplification" can be used to prove
    more interesting properties as well.  For example, the fact that
    [0] is a "neutral element" for [+] on the left can be proved just
    by observing that [0 + n] reduces to [n] no matter what [n] is, a
    fact that can be read directly off the definition of [plus].*)

Theorem plus_O_n : forall n : nat, 0 + n = n.
Proof.
  intros n. simpl. reflexivity.  Qed.

(** (You may notice that the above statement looks different in
    the [.v] file in your IDE than it does in the HTML rendition in
    your browser, if you are viewing both. In [.v] files, we write the
    [forall] universal quantifier using the reserved identifier
    "forall."  When the [.v] files are converted to HTML, this gets
    transformed into an upside-down-A symbol.) *)

(** This is a good place to mention that [reflexivity] is a bit
    more powerful than we have admitted. In the examples we have seen,
    the calls to [simpl] were actually not needed, because
    [reflexivity] can perform some simplification automatically when
    checking that two sides are equal; [simpl] was just added so that
    we could see the intermediate state -- after simplification but
    before finishing the proof.  Here is a shorter proof of the
    theorem: *)

Theorem plus_O_n' : forall n : nat, 0 + n = n.
Proof.
  intros n. reflexivity. Qed.

(** Moreover, it will be useful later to know that [reflexivity]
    does somewhat _more_ simplification than [simpl] does -- for
    example, it tries "unfolding" defined terms, replacing them with
    their right-hand sides.  The reason for this difference is that,
    if reflexivity succeeds, the whole goal is finished and we don't
    need to look at whatever expanded expressions [reflexivity] has
    created by all this simplification and unfolding; by contrast,
    [simpl] is used in situations where we may have to read and
    understand the new goal that it creates, so we would not want it
    blindly expanding definitions and leaving the goal in a messy
    state. *)

(** The form of the theorem we just stated and its proof are
    almost exactly the same as the simpler examples we saw earlier;
    there are just a few differences.

    First, we've used the keyword [Theorem] instead of [Example].
    This difference is purely a matter of style; the keywords
    [Example] and [Theorem] (and a few others, including [Lemma],
    [Fact], and [Remark]) mean exactly the same thing to Coq.

    Second, we've added the quantifier [forall n:nat], so that our
    theorem talks about _all_ natural numbers [n].  In order to prove
    theorems of this form, we need to to be able to reason by
    _assuming_ the existence of an arbitrary natural number [n].  This
    is achieved in the proof by [intros n], which moves the quantifier
    from the goal to a _context_ of current assumptions. In effect, we
    start the proof by saying "Suppose [n] is some arbitrary
    number..."

    The keywords [intros], [simpl], and [reflexivity] are examples of
    _tactics_.  A tactic is a command that is used between [Proof] and
    [Qed] to guide the process of checking some claim we are making.
    We will see several more tactics in the rest of this chapter and
    yet more in future chapters.

    Other similar theorems can be proved with the same pattern. *)

Theorem plus_1_l : forall n:nat, 1 + n = S n.
Proof.
  intros n. reflexivity.  Qed.

Theorem mult_0_l : forall n:nat, 0 * n = 0.
Proof.
  intros n. reflexivity.  Qed.

(** The [_l] suffix in the names of these theorems is
    pronounced "on the left." *)

(** It is worth stepping through these proofs to observe how the
    context and the goal change. *)
(** You may want to add calls to [simpl] before [reflexivity] to
    see the simplifications that Coq performs on the terms before
    checking that they are equal.

    Although simplification is powerful enough to prove some fairly
    general facts, there are many statements that cannot be handled by
    simplification alone.  For instance, we cannot use it to prove
    that [0] is also a neutral element for [+] _on the right_. *)

Theorem plus_n_O : forall n, n = n + 0.
Proof.
  intros n. simpl. (* Doesn't do anything! *)

(** (Can you explain why this happens?  Step through both proofs
    with Coq and notice how the goal and context change.)

    When stuck in the middle of a proof, we can use the [Abort]
    command to give up on it for the moment. *)

Abort.

(** The next chapter will introduce _induction_, a powerful
    technique that can be used for proving this goal.  For the moment,
    though, let's look at a few more simple tactics. *)

(* ################################################################# *)
(** * Proof by Rewriting *)

(** This theorem is a bit more interesting than the others we've
    seen: *)

Theorem plus_id_example : forall n m:nat,
  n = m ->
  n + n = m + m.

(** Instead of making a universal claim about all numbers [n] and [m],
    it talks about a more specialized property that only holds when [n
    = m].  The arrow symbol is pronounced "implies."

    As before, we need to be able to reason by assuming the existence
    of some numbers [n] and [m].  We also need to assume the hypothesis
    [n = m]. The [intros] tactic will serve to move all three of these
    from the goal into assumptions in the current context.

    Since [n] and [m] are arbitrary numbers, we can't just use
    simplification to prove this theorem.  Instead, we prove it by
    observing that, if we are assuming [n = m], then we can replace
    [n] with [m] in the goal statement and obtain an equality with the
    same expression on both sides.  The tactic that tells Coq to
    perform this replacement is called [rewrite]. *)

Proof.
  (* move both quantifiers into the context: *)
  intros n m.
  (* move the hypothesis into the context: *)
  intros H.
  (* rewrite the goal using the hypothesis: *)
  rewrite -> H.
  reflexivity.  Qed.

(** The first line of the proof moves the universally quantified
    variables [n] and [m] into the context.  The second moves the
    hypothesis [n = m] into the context and gives it the name [H].
    The third tells Coq to rewrite the current goal ([n + n = m + m])
    by replacing the left side of the equality hypothesis [H] with the
    right side.

    (The arrow symbol in the [rewrite] has nothing to do with
    implication: it tells Coq to apply the rewrite from left to right.
    To rewrite from right to left, you can use [rewrite <-].  Try
    making this change in the above proof and see what difference it
    makes.) *)

(** **** Exercise: 1 star (plus_id_exercise)  *)
(** Remove "[Admitted.]" and fill in the proof. *)

Theorem plus_id_exercise : forall n m o : nat,
  n = m -> m = o -> n + m = m + o.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** The [Admitted] command tells Coq that we want to skip trying
    to prove this theorem and just accept it as a given.  This can be
    useful for developing longer proofs, since we can state subsidiary
    lemmas that we believe will be useful for making some larger
    argument, use [Admitted] to accept them on faith for the moment,
    and continue working on the main argument until we are sure it
    makes sense; then we can go back and fill in the proofs we
    skipped.  Be careful, though: every time you say [Admitted] (or
    [admit]) you are leaving a door open for total nonsense to enter
    Coq's nice, rigorous, formally checked world! *)

(** We can also use the [rewrite] tactic with a previously proved
    theorem instead of a hypothesis from the context. If the statement
    of the previously proved theorem involves quantified variables,
    as in the example below, Coq tries to instantiate them 
    by matching with the current goal. *)   

Theorem mult_0_plus : forall n m : nat,
  (0 + n) * m = n * m.
Proof.
  intros n m.
  rewrite -> plus_O_n.
  reflexivity.  Qed.

(** **** Exercise: 2 stars (mult_S_1)  *)
Theorem mult_S_1 : forall n m : nat,
  m = S n ->
  m * (1 + n) = m * m.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)


(* ################################################################# *)
(** * Proof by Case Analysis *)

(** Of course, not everything can be proved by simple
    calculation and rewriting: In general, unknown, hypothetical
    values (arbitrary numbers, booleans, lists, etc.) can block
    simplification.  For example, if we try to prove the following
    fact using the [simpl] tactic as above, we get stuck. *)

Theorem plus_1_neq_0_firsttry : forall n : nat,
  beq_nat (n + 1) 0 = false.
Proof.
  intros n.
  simpl.  (* does nothing! *)
Abort.

(** The reason for this is that the definitions of both
    [beq_nat] and [+] begin by performing a [match] on their first
    argument.  But here, the first argument to [+] is the unknown
    number [n] and the argument to [beq_nat] is the compound
    expression [n + 1]; neither can be simplified.

    To make progress, we need to consider the possible forms of [n]
    separately.  If [n] is [O], then we can calculate the final result
    of [beq_nat (n + 1) 0] and check that it is, indeed, [false].  And
    if [n = S n'] for some [n'], then, although we don't know exactly
    what number [n + 1] yields, we can calculate that, at least, it
    will begin with one [S], and this is enough to calculate that,
    again, [beq_nat (n + 1) 0] will yield [false].

    The tactic that tells Coq to consider, separately, the cases where
    [n = O] and where [n = S n'] is called [destruct]. *)

Theorem plus_1_neq_0 : forall n : nat,
  beq_nat (n + 1) 0 = false.
Proof.
  intros n. destruct n as [| n'].
  - reflexivity.
  - reflexivity.   Qed.

(** The [destruct] generates _two_ subgoals, which we must then
    prove, separately, in order to get Coq to accept the theorem. The
    annotation "[as [| n']]" is called an _intro pattern_.  It tells
    Coq what variable names to introduce in each subgoal.  In general,
    what goes between the square brackets is a _list of lists_ of
    names, separated by [|].  In this case, the first component is
    empty, since the [O] constructor is nullary (it doesn't have any
    arguments).  The second component gives a single name, [n'], since
    [S] is a unary constructor.

    The [-] signs on the second and third lines are called _bullets_,
    and they mark the parts of the proof that correspond to each
    generated subgoal.  The proof script that comes after a bullet is
    the entire proof for a subgoal.  In this example, each of the
    subgoals is easily proved by a single use of [reflexivity], which
    itself performs some simplification -- e.g., the first one
    simplifies [beq_nat (S n' + 1) 0] to [false] by first rewriting
    [(S n' + 1)] to [S (n' + 1)], then unfolding [beq_nat], and then
    simplifying the [match].

    Marking cases with bullets is entirely optional: if bullets are
    not present, Coq simply asks you to prove each subgoal in
    sequence, one at a time. But it is a good idea to use bullets.
    For one thing, they make the structure of a proof apparent, making
    it more readable. Also, bullets instruct Coq to ensure that a
    subgoal is complete before trying to verify the next one,
    preventing proofs for different subgoals from getting mixed
    up. These issues become especially important in large
    developments, where fragile proofs lead to long debugging
    sessions.

    There are no hard and fast rules for how proofs should be
    formatted in Coq -- in particular, where lines should be broken
    and how sections of the proof should be indented to indicate their
    nested structure.  However, if the places where multiple subgoals
    are generated are marked with explicit bullets at the beginning of
    lines, then the proof will be readable almost no matter what
    choices are made about other aspects of layout.

    This is also a good place to mention one other piece of somewhat
    obvious advice about line lengths.  Beginning Coq users sometimes
    tend to the extremes, either writing each tactic on its own line
    or writing entire proofs on one line.  Good style lies somewhere
    in the middle.  One reasonable convention is to limit yourself to
    80-character lines.

    The [destruct] tactic can be used with any inductively defined
    datatype.  For example, we use it next to prove that boolean
    negation is involutive -- i.e., that negation is its own
    inverse. *)

Theorem negb_involutive : forall b : bool,
  negb (negb b) = b.
Proof.
  intros b. destruct b.
  - reflexivity.
  - reflexivity.  Qed.

(** Note that the [destruct] here has no [as] clause because
    none of the subcases of the [destruct] need to bind any variables,
    so there is no need to specify any names.  (We could also have
    written [as [|]], or [as []].)  In fact, we can omit the [as]
    clause from _any_ [destruct] and Coq will fill in variable names
    automatically.  This is generally considered bad style, since Coq
    often makes confusing choices of names when left to its own
    devices.

    It is sometimes useful to invoke [destruct] inside a subgoal,
    generating yet more proof obligations. In this case, we use
    different kinds of bullets to mark goals on different "levels."
    For example: *)

Theorem andb_commutative : forall b c, andb b c = andb c b.
Proof.
  intros b c. destruct b.
  - destruct c.
    + reflexivity.
    + reflexivity.
  - destruct c.
    + reflexivity.
    + reflexivity.
Qed.

(** Each pair of calls to [reflexivity] corresponds to the
    subgoals that were generated after the execution of the [destruct
    c] line right above it.  Besides [-] and [+], Coq proofs can also
    use [*] (asterisk) as a third kind of bullet. If we ever encounter
    a proof that generates more than three levels of subgoals, we can
    also enclose individual subgoals in curly braces ([{ ... }]): *)

Theorem andb_commutative' : forall b c, andb b c = andb c b.
Proof.
  intros b c. destruct b.
  { destruct c.
    { reflexivity. }
    { reflexivity. } }
  { destruct c.
    { reflexivity. }
    { reflexivity. } }
Qed.

(** Since curly braces mark both the beginning and the end of a
    proof, they can be used for multiple subgoal levels, as this
    example shows. Furthermore, curly braces allow us to reuse the
    same bullet shapes at multiple levels in a proof: *)

Theorem andb3_exchange :
  forall b c d, andb (andb b c) d = andb (andb b d) c.
Proof.
  intros b c d. destruct b.
  - destruct c.
    { destruct d.
      - reflexivity.
      - reflexivity. }
    { destruct d.
      - reflexivity.
      - reflexivity. }
  - destruct c.
    { destruct d.
      - reflexivity.
      - reflexivity. }
    { destruct d.
      - reflexivity.
      - reflexivity. }
Qed.

(** Before closing the chapter, let's mention one final
    convenience.  As you may have noticed, many proofs perform case
    analysis on a variable right after introducing it:

       intros x y. destruct y as [|y].

    This pattern is so common that Coq provides a shorthand for it: we
    can perform case analysis on a variable when introducing it by
    using an intro pattern instead of a variable name. For instance,
    here is a shorter proof of the [plus_1_neq_0] theorem above. *)

Theorem plus_1_neq_0' : forall n : nat,
  beq_nat (n + 1) 0 = false.
Proof.
  intros [|n].
  - reflexivity.
  - reflexivity.  Qed.

(** If there are no arguments to name, we can just write [[]]. *)

Theorem andb_commutative'' :
  forall b c, andb b c = andb c b.
Proof.
  intros [] [].
  - reflexivity.
  - reflexivity.
  - reflexivity.
  - reflexivity.
Qed.

(** **** Exercise: 2 stars (andb_true_elim2)  *)
(** Prove the following claim, marking cases (and subcases) with
    bullets when you use [destruct]. *)

Theorem andb_true_elim2 : forall b c : bool,
  andb b c = true -> c = true.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 1 star (zero_nbeq_plus_1)  *)
Theorem zero_nbeq_plus_1 : forall n : nat,
  beq_nat 0 (n + 1) = false.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(* ================================================================= *)
(** ** More on Notation (Optional) *)

(** (In general, sections marked Optional are not needed to follow the
    rest of the book, except possibly other Optional sections.  On a
    first reading, you might want to skim these sections so that you
    know what's there for future reference.)

    Recall the notation definitions for infix plus and times: *)

Notation "x + y" := (plus x y)
                       (at level 50, left associativity)
                       : nat_scope.
Notation "x * y" := (mult x y)
                       (at level 40, left associativity)
                       : nat_scope.

(** For each notation symbol in Coq, we can specify its _precedence
    level_ and its _associativity_.  The precedence level [n] is
    specified by writing [at level n]; this helps Coq parse compound
    expressions.  The associativity setting helps to disambiguate
    expressions containing multiple occurrences of the same
    symbol. For example, the parameters specified above for [+] and
    [*] say that the expression [1+2*3*4] is shorthand for
    [(1+((2*3)*4))]. Coq uses precedence levels from 0 to 100, and
    _left_, _right_, or _no_ associativity.  We will see more examples
    of this later, e.g., in the [Lists]
    chapter.

    Each notation symbol is also associated with a _notation scope_.
    Coq tries to guess what scope is meant from context, so when it
    sees [S(O*O)] it guesses [nat_scope], but when it sees the
    cartesian product (tuple) type [bool*bool] it guesses
    [type_scope].  Occasionally, it is necessary to help it out with
    percent-notation by writing [(x*y)%nat], and sometimes in what Coq
    prints it will use [%nat] to indicate what scope a notation is in.

    Notation scopes also apply to numeral notation ([3], [4], [5],
    etc.), so you may sometimes see [0%nat], which means [O] (the
    natural number [0] that we're using in this chapter), or [0%Z],
    which means the Integer zero (which comes from a different part of
    the standard library). *)

(* ================================================================= *)
(** ** Fixpoints and Structural Recursion (Optional) *)

(** Here is a copy of the definition of addition: *)

Fixpoint plus' (n : nat) (m : nat) : nat :=
  match n with
  | O => m
  | S n' => S (plus' n' m)
  end.

(** When Coq checks this definition, it notes that [plus'] is
    "decreasing on 1st argument."  What this means is that we are
    performing a _structural recursion_ over the argument [n] -- i.e.,
    that we make recursive calls only on strictly smaller values of
    [n].  This implies that all calls to [plus'] will eventually
    terminate.  Coq demands that some argument of _every_ [Fixpoint]
    definition is "decreasing."

    This requirement is a fundamental feature of Coq's design: In
    particular, it guarantees that every function that can be defined
    in Coq will terminate on all inputs.  However, because Coq's
    "decreasing analysis" is not very sophisticated, it is sometimes
    necessary to write functions in slightly unnatural ways. *)

(** **** Exercise: 2 stars, optional (decreasing)  *)
(** To get a concrete sense of this, find a way to write a sensible
    [Fixpoint] definition (of a simple function on numbers, say) that
    _does_ terminate on all inputs, but that Coq will reject because
    of this restriction. *)

(* FILL IN HERE *)
(** [] *)

(* ################################################################# *)
(** * More Exercises *)

(** **** Exercise: 2 stars (boolean_functions)  *)
(** Use the tactics you have learned so far to prove the following
    theorem about boolean functions. *)

Theorem identity_fn_applied_twice :
  forall (f : bool -> bool),
  (forall (x : bool), f x = x) ->
  forall (b : bool), f (f b) = b.
Proof.
  (* FILL IN HERE *) Admitted.

(** Now state and prove a theorem [negation_fn_applied_twice] similar
    to the previous one but where the second hypothesis says that the
    function [f] has the property that [f x = negb x].*)

(* FILL IN HERE *)
(** [] *)

(** **** Exercise: 2 stars (andb_eq_orb)  *)
(** Prove the following theorem.  (You may want to first prove a
    subsidiary lemma or two. Alternatively, remember that you do
    not have to introduce all hypotheses at the same time.) *)

Theorem andb_eq_orb :
  forall (b c : bool),
  (andb b c = orb b c) ->
  b = c.
Proof.
  (* FILL IN HERE *) Admitted.
(** [] *)

(** **** Exercise: 3 stars (binary)  *)
(** Consider a different, more efficient representation of natural
    numbers using a binary rather than unary system.  That is, instead
    of saying that each natural number is either zero or the successor
    of a natural number, we can say that each binary number is either

      - zero,
      - twice a binary number, or
      - one more than twice a binary number.

    (a) First, write an inductive definition of the type [bin]
        corresponding to this description of binary numbers.

    (Hint: Recall that the definition of [nat] from class,

         Inductive nat : Type :=
           | O : nat
           | S : nat -> nat.

    says nothing about what [O] and [S] "mean."  It just says "[O] is
    in the set called [nat], and if [n] is in the set then so is [S
    n]."  The interpretation of [O] as zero and [S] as successor/plus
    one comes from the way that we _use_ [nat] values, by writing
    functions to do things with them, proving things about them, and
    so on.  Your definition of [bin] should be correspondingly simple;
    it is the functions you will write next that will give it
    mathematical meaning.)

    (b) Next, write an increment function [incr] for binary numbers,
        and a function [bin_to_nat] to convert binary numbers to unary numbers.

    (c) Write five unit tests [test_bin_incr1], [test_bin_incr2], etc.
        for your increment and binary-to-unary functions. Notice that
        incrementing a binary number and then converting it to unary
        should yield the same result as first converting it to unary and
        then incrementing.
*)

(* FILL IN HERE *)
(** [] *)

(** $Date: 2016-07-13 12:41:41 -0400 (Wed, 13 Jul 2016) $ *)

