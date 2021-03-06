(**************************************************************************)
(*                                                                        *)
(*  This file is part of Frama-C.                                         *)
(*                                                                        *)
(*  Copyright (C) 2007-2018                                               *)
(*    CEA (Commissariat à l'énergie atomique et aux énergies              *)
(*         alternatives)                                                  *)
(*                                                                        *)
(*  you can redistribute it and/or modify it under the terms of the GNU   *)
(*  Lesser General Public License as published by the Free Software       *)
(*  Foundation, version 2.1.                                              *)
(*                                                                        *)
(*  It is distributed in the hope that it will be useful,                 *)
(*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *)
(*  GNU Lesser General Public License for more details.                   *)
(*                                                                        *)
(*  See the GNU Lesser General Public License version 2.1                 *)
(*  for more details (enclosed in the file licenses/LGPLv2.1).            *)
(*                                                                        *)
(**************************************************************************)

(** Value builtins related to functions in string.h. *)

(** The actual builtins are registered through {!Builtins.register_builtin}.
    The functions below are also  used for the evaluation of logical predicates
    [valid_string] and [valid_read_string]. *)

(** Alarms are pairs (assertion, warning_msg):
    - ACSL "assertion"
    - Informative message on why the evaluation raised an alarm
*)
module String_alarms:
  Datatype.S_with_collections with type t = string * string

type expterm =
  | Exp of Cil_types.exp
  | Term of Cil_types.term

type str_builtin_sig =
  Cvalue.Model.t (*state*) ->
  (expterm * Cvalue.V.t) list (*args*) ->
  Value_types.call_result * String_alarms.Set.t (*res,alarms*)

val frama_c_strlen_wrapper: str_builtin_sig

val frama_c_strnlen_wrapper: str_builtin_sig

val frama_c_rawmemchr_wrapper: str_builtin_sig

val frama_c_memchr_wrapper: str_builtin_sig

val frama_c_strchr_wrapper: str_builtin_sig

val frama_c_wcslen_wrapper: unit -> str_builtin_sig

val frama_c_wcschr_wrapper: unit -> str_builtin_sig

val frama_c_wmemchr_wrapper: unit -> str_builtin_sig
