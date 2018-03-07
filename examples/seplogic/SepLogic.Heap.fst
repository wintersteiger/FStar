module SepLogic.Heap

module S  = FStar.Set
module TS = FStar.TSet

private noeq type heap_rec = {
  next_addr: nat;
  memory   : nat -> Tot (option (a:Type0 & a))  //type, preorder, mm flag, and value
}

let heap = h:heap_rec{(forall (n:nat). n >= h.next_addr ==> None? (h.memory n))}

let ref a = nat

let addr_of #a n = n

private let equal (h1 h2:heap) =
  let _ = () in
  h1.next_addr = h2.next_addr /\
  FStar.FunctionalExtensionality.feq h1.memory h2.memory

private let equal_extensional (h0 h1:heap)
  : Lemma (requires True) (ensures (equal h0 h1 <==> h0 == h1))
  = ()

let join_tot h0 h1 =
  let memory = (fun r' ->  match (h0.memory r', h1.memory r') with
                              | (Some v1, None) -> Some v1
			      | (None, Some v2) -> Some v2
			      | _               -> None) in
  if (h0.next_addr < h1.next_addr)
  then { next_addr = h1.next_addr;  memory = memory }
  else { next_addr = h0.next_addr;  memory = memory }

let disjoint #a #b r0 r1 = r0 =!= r1

let disjoint_heaps h0 h1 =
  let _ = () in
  (forall (r:nat). ~(Some?(h0.memory r) && Some?(h1.memory r)))

let emp = fun h -> forall r . None? (h.memory r)

let ( |> ) #a r x = 
  fun h -> h.memory r == Some (| a , x |) /\ (forall r' . r =!= r' ==> None? (h.memory r'))

let ( <*> ) p q = 
  fun h -> exists h0 h1 . disjoint_heaps h0 h1 /\ h == join_tot h0 h1 /\ p h0 /\ q h1 

private let lemma_disjoint_heaps_emp (h0 h1:heap)
  : Lemma (requires (emp h1))
          (ensures  (disjoint_heaps h0 h1))
  = ()

(*private let lemma_join_tot_emp (h0 h1:heap)
  : Lemma (requires (emp h1))
          (ensures  (join_tot h0 h1 == h0))    //not necessarily if h1.next_addr > h0.next_addr
  = ()*)

// (exists h0 h1 . disjoint_heaps h0 h1 /\ h == join_tot h0 h1 /\ p h0 /\ (emp h1))
//
// <==>
//
// p h

let emp_unit p h = admit ()

private let lemma_disjoint_heaps_comm (h0 h1:heap) 
  : Lemma ((disjoint_heaps h0 h1) <==> (disjoint_heaps h0 h1))
          [SMTPat (disjoint_heaps h0 h1)]
  = ()

private let lemma_join_tot_comm' (h0 h1:heap)
  : Lemma (equal (join_tot h0 h1) (join_tot h1 h0))
  = ()

private let lemma_join_tot_comm (h0 h1:heap)
  : Lemma ((join_tot h0 h1) == (join_tot h1 h0))
          [SMTPat (join_tot h0 h1)]
  = lemma_join_tot_comm' h0 h1

private let lemma_sep_comm (p q:hpred) (h:heap)
  : Lemma ((exists h0 h1 . disjoint_heaps h0 h1 /\ h == join_tot h0 h1 /\ p h0 /\ q h1) 
           <==> 
           (exists h0 h1 . disjoint_heaps h0 h1 /\ h == join_tot h0 h1 /\ p h1 /\ q h0))
  = ()

let sep_comm p q h = lemma_sep_comm p q h

let sep_assoc p q r h = admit ()

let sep_interp p q h = admit ()

let points_to_disj #a #b r s x y h = admit ()

let fresh #a r = admit ()

let contains #a h r = admit ()

let points_to_contains #a r x h = admit ()

let sel_tot #a h r = admit ()

let upd_tot #a h r x = admit ()

let points_to_sel #a r x h = admit ()

let points_to_upd #a r x v h = admit ()
