#light "off"
module FStar.Tactics.Embedding

open FStar.Ident
open FStar.Syntax.Syntax
open FStar.Syntax.Embeddings
open FStar.Tactics.Types
open FStar.Tactics.Result

val embed_proofstate   : embedder<proofstate>
val unembed_proofstate : unembedder<proofstate>

val embed_result   : embedder<'a> -> typ -> embedder<__result<'a>>
val unembed_result : term -> unembedder<'a> -> option<FStar.Util.either<('a * proofstate), (string * proofstate)>>
// wat? why not unembedder<__result<'a>>?

val embed_direction   : embedder<direction>
val unembed_direction : unembedder<direction>

val fstar_tactics_lid' : list<string> -> FStar.Ident.lid
val pair_typ : typ -> typ -> typ
