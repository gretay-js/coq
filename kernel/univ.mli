(***********************************************************************)
(*  v      *   The Coq Proof Assistant  /  The Coq Development Team    *)
(* <O___,, *        INRIA-Rocquencourt  &  LRI-CNRS-Orsay              *)
(*   \VV/  *************************************************************)
(*    //   *      This file is distributed under the terms of the      *)
(*         *       GNU Lesser General Public License Version 2.1       *)
(***********************************************************************)

(*i $Id$ i*)

(*i*)
open Names
(*i*)

(* Universes. *)

type universe

val implicit_univ : universe

val prop_univ : universe

val set_module : dir_path -> unit

val new_univ : unit -> universe

(*s Graphs of universes. *)

type universes

val initial_universes : universes

(*s Constraints. *)

type univ_constraint

module Constraint : Set.S with type elt = univ_constraint

type constraints = Constraint.t

type constraint_function = universe -> universe -> constraints -> constraints

val enforce_geq : constraint_function
val enforce_eq : constraint_function

val super : universe -> universe * constraints

val sup : universe -> universe -> universes -> universe * constraints

(*s Merge of constraints in a universes graph. 
  The function [merge_constraints] merges a set of constraints in a given
  universes graph. It raises the exception [UniverseInconsistency] if the
  constraints are not satisfiable. *)

exception UniverseInconsistency

val merge_constraints : constraints -> universes -> universes

(*s Pretty-printing of universes. *)

val pr_uni : universe -> Pp.std_ppcmds
val pr_universes : universes -> Pp.std_ppcmds

val string_of_univ : universe -> string

(*s Dumping to a file *)

val dump_universes : out_channel -> universes -> unit

val hcons1_univ : universe -> universe
