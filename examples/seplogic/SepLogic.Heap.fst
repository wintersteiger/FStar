module SepLogic.Heap

module OS = FStar.OrdSet

let addrs = OS.ordset nat (fun n m -> n <= m)

unfold let disjoint_addrs (s0 s1:addrs) = OS.intersect s0 s1 = OS.empty

private noeq type heap_rec = {
  next_addr : nat;
  hdomain   : addrs;
  memory    : nat -> Tot (option (a:Type0 & a))
}

let heap = h:heap_rec
  {(forall (r:nat) . 
      OS.mem r h.hdomain ==> r < h.next_addr) /\
      (forall (r:nat) . OS.mem r h.hdomain ==> Some? (h.memory r)) /\ 
      (forall (r:nat) . not (OS.mem r h.hdomain) ==> None? (h.memory r))}

private let equal_heaps (h0 h1:heap) =
  let _ = () in
  h0.next_addr = h1.next_addr /\
  h0.hdomain = h1.hdomain /\ 
  FStar.FunctionalExtensionality.feq h0.memory h1.memory
  
private noeq type memory_rec = {
  domain   : addrs; 
  contents : nat -> Tot (option (a:Type0 & a))
}

let memory = m:(option memory_rec)
  {forall m' . m == Some m' ==> 
               ((forall r . OS.mem r m'.domain ==> Some? (m'.contents r)) /\ 
                (forall r . not (OS.mem r m'.domain) ==> None? (m'.contents r)))}

private let equal_memories (m0 m1:memory) =
  match (m0, m1) with
  | (Some m0', Some m1') -> m0'.domain = m1'.domain /\ 
                            FStar.FunctionalExtensionality.feq m0'.contents m1'.contents
  | (Some _, None)     -> False
  | (None, Some _)     -> False
  | (None, None)       -> True

let defined m = Some? m

let emp = 
  let domain = OS.empty in
  let contents = fun _ -> None in
  Some ({ domain = domain; contents = contents })
  
let ref a = nat

let addr_of #a n = n

let heap_memory h = Some ({ domain   = h.hdomain;
                            contents = h.memory   })

let disjoint_heaps (h0 h1:heap) =
  let _ = () in
  disjoint_addrs h0.hdomain h1.hdomain

let join h0 h1 =
  let domain = OS.union h0.hdomain h1.hdomain in 
  let memory = (fun r ->  match (h0.memory r, h1.memory r) with
                          | (Some v1, None) -> Some v1
			  | (None, Some v2) -> Some v2
			  | (None, None)    -> None) in
  if (h0.next_addr < h1.next_addr)
  then { next_addr = h1.next_addr; hdomain = domain; memory = memory }
  else { next_addr = h0.next_addr; hdomain = domain; memory = memory }

let ( |> ) #a r x = 
  let domain = OS.singleton r in
  let contents : nat -> Tot (option (a:Type0 & a)) = 
    (fun r' -> if r = r' then Some (| a , x |)
                         else None) in
  Some ({ domain = domain; contents = contents })

let ( <*> ) m0 m1 = 
  match (m0, m1) with
  | (Some m0', Some m1') ->
      (if (disjoint_addrs m0'.domain m1'.domain)
       then (let domain = OS.union m0'.domain m1'.domain in
             let contents = (fun r -> match (m0'.contents r, m1'.contents r) with
                                     | (Some v1, None) -> Some v1
                                     | (None, Some v2) -> Some v2
                                     | (None, None)    -> None) in
             Some ({ domain = domain; contents = contents }))
       else None)
  | _ -> None

let split_heap m0 m1 h = 
  match (m0, m1) with 
  | (Some m0', Some m1') -> 
      let h0 = { next_addr = h.next_addr; 
                 hdomain = m0'.domain; 
                 memory = m0'.contents } in
      let h1 = { next_addr = h.next_addr; 
                 hdomain = m1'.domain; 
                 memory = m1'.contents } in
      (h0,h1)

let hcontains #a h r = 
  let _ = () in 
  exists x . h.memory r == Some (| a , x |)

let mcontains #a m r = 
  match m with
  | Some m' -> exists x . m'.contents r == Some (| a , x |)
  | None    -> False

let sel #a h r =
  let Some (| _, x |) = h.memory r in
  x

let upd' (#a:Type0) (h:heap) (r:ref a) (x:a) =
  { h with memory = (fun r' -> if r = r' then Some (| a, x |)
                                         else h.memory r') }

let upd #a h r x = upd' h r x

let fresh #a r h = 
  addr_of r >= h.next_addr

let alloc #a h0 x = 
  let r = h0.next_addr in 
  let next_addr = h0.next_addr + 1 in
  let domain = OS.union h0.hdomain (OS.singleton r) in
  let memory = (fun r' -> if r = r' then Some (| a , x |)
                                    else h0.memory r') in
  let h1 = { next_addr = next_addr; hdomain = domain; memory = memory } in
  (r, h1)

let dealloc #a h0 r =
  let next_addr = h0.next_addr in
  let domain = OS.remove r h0.hdomain in
  let memory = (fun r' -> if r <> r' then h0.memory r'
                                     else None) in
  { next_addr = next_addr; hdomain = domain; memory = memory }
  
let addrs_in m = 
  match m with
  | Some m' -> OS.as_set m'.domain
  | None    -> S.empty

let addr_to_ref m r = 
  match m with
  | Some m' ->
    match m'.contents r with
    | Some v -> (| dfst v, r |)

let restrict_memory rs m = admit ()
  (*match m with
  | Some m' -> 
      let domain = OS.intersect_with_set m'.domain rs in 
      let contents = (fun r -> if OS.mem r domain 
                               then m'.contents r
                               else None) in
      Some ({ domain = domain; contents = contents })*)

let complement_memory rs m = admit () //skipping this to do non alloc/dealloc parts first
  (*match m with 
  | Some m' -> 
      let domain = S.intersect (S.complement rs) m'.domain in 
      let contents = (fun r -> if S.mem r domain
                               then m'.contents r
                               else None) in
      Some ({ domain = domain; contents = contents })*)

let lemma_disjoint_heaps_comm h0 h1 = ()

let lemma_disjoint_heaps_memories h0 h1 = ()

let lemma_sep_defined_disjoint_heaps h0 h1 = ()

let lemma_join_comm h0 h1 =
  assert (OS.equal (OS.union h0.hdomain h1.hdomain) (OS.union h1.hdomain h0.hdomain));
  assert (equal_heaps (join h0 h1) (join h1 h0))

let lemma_sep_unit m = 
  match m with 
  | None    -> ()
  | Some m' -> 
      let (Some e) = emp in 
      assert (OS.equal (OS.intersect m'.domain e.domain) OS.empty);
      let (Some m'') = m <*> emp in 
      assert (OS.equal m''.domain m'.domain);
      assert (equal_memories (m <*> emp) m)

let lemma_sep_comm m0 m1 =
  match (m0,m1) with
  | (Some m0', Some m1') -> 
      if (disjoint_addrs m0'.domain m1'.domain)
      then (assert (OS.equal (OS.union m0'.domain m1'.domain) (OS.union m1'.domain m0'.domain));
            let (Some m)  = m0 <*> m1 in
            let (Some m') = m1 <*> m0 in
            assert (equal_memories (m0 <*> m1) (m1 <*> m0)))
      else (assert (equal_memories (m0 <*> m1) (m1 <*> m0)))
  | _ -> ()

let lemma_sep_assoc m0 m1 m2 = 
  match (m0,m1,m2) with
  | (Some m0', Some m1', Some m2') -> 
      if (disjoint_addrs m0'.domain m1'.domain && 
          disjoint_addrs m1'.domain m2'.domain && 
          disjoint_addrs m0'.domain m2'.domain)
      then (assert (OS.equal (OS.union m0'.domain (OS.union m1'.domain m2'.domain)) 
                             (OS.union (OS.union m0'.domain m1'.domain) m2'.domain));
            assert (equal_memories (m0 <*> (m1 <*> m2)) ((m0 <*> m1) <*> m2)))
      else if (not (disjoint_addrs m0'.domain m1'.domain))
      then (assert (equal_memories (m0 <*> (m1 <*> m2)) ((m0 <*> m1) <*> m2)))
      else if (not (disjoint_addrs m1'.domain m2'.domain))
      then (assert (equal_memories (m0 <*> (m1 <*> m2)) ((m0 <*> m1) <*> m2)))
      else if (not (disjoint_addrs m0'.domain m2'.domain))
      then (assert (equal_memories (m0 <*> (m1 <*> m2)) ((m0 <*> m1) <*> m2)))
  | _ -> ()

let lemma_sep_join (h0 h1:heap) = 
  assert (equal_memories (heap_memory (join h0 h1)) 
                         ((heap_memory h0) <*> (heap_memory h1)))

let lemma_emp_defined () = ()

let lemma_points_to_defined #a r x = ()

let lemma_sep_defined m0 m1 = ()

let lemma_heap_memory_defined h = ()

let lemma_split_heap_disjoint m0 m1 h = ()

let lemma_split_heap_join m0 m1 h = 
  assert (let (h0,h1) = split_heap m0 m1 h in
          equal_heaps h (join h0 h1))

let lemma_split_heap_memories m0 m1 h = ()

let lemma_split_heap_fresh m0 m1 h = ()

let lemma_hcontains_mcontains #a r h = ()

let lemma_points_to_mcontains #a r x = ()

let lemma_points_to_sel #a r x h = ()

let lemma_points_to_upd #a r x v h = 
  assert (equal_memories (heap_memory ((upd h r v))) (r |> v))

let lemma_alloc_fresh #a h0 x = ()

let lemma_alloc_contains #a h0 x = ()

let lemma_alloc_sel #a h0 x = ()

let lemma_alloc_heap_memory #a h0 x = //TODO
  admit ()
  //let (r,h1) = alloc h0 x in 
  //assert (equal_memories (heap_memory h1) (heap_memory h0 <*> (r |> x)))

let lemma_fresh_in_complement #a r h = ()

let lemma_fresh_join #a r h0 h1 = ()

let lemma_dealloc_contains #a h0 r = ()

let lemma_points_to_dealloc #a h0 r = //TODO
  admit ()
  //assert (equal_memories (heap_memory (dealloc h0 r)) emp)

let lemma_addrs_in_emp () = ()

let lemma_addrs_in_disjoint_heaps h0 h1 = ()

let lemma_addrs_in_points_to #a r x = ()

let lemma_addrs_in_join m0 m1 = ()

let lemma_addr_to_ref_addr_of m r = ()

let lemma_restrict_complement_disjoint rs m = //TODO
  admit ()

let lemma_restrict_complement_sep rs m = //TODO
  admit ()
  //assert (equal_memories m ((restrict_memory rs m) <*> (complement_memory rs m)))

let lemma_fresh_or_old_refl h = 
  FStar.Classical.exists_intro (fun m -> fresh_or_old' h h (fst m) (snd m)) (heap_memory h,emp)

private let exists_intro_2 (#a:Type) (#b:Type) (p:(a -> b -> Type)) (witness:a) (witness':b)
  : Lemma (requires (p witness witness'))
	  (ensures (exists x y. p x y))
  = ()

private let forall_to_exists_2 (#a:Type) (#b:Type) 
                               (#p:(a -> b -> Type)) (#r:Type) 
                               ($f:(x:a -> y:b -> Lemma (p x y ==> r)))
  : Lemma ((exists x y . p x y) ==> r)
  = FStar.Classical.forall_to_exists (fun x -> 
      FStar.Classical.forall_to_exists (fun y -> 
        f x y))

private let forall_to_exists_4 (#a:Type) (#b:Type) (#c:Type) (#d:Type) 
                               (#p:(a -> b -> c -> d -> Type)) (#r:Type) 
                               ($f:(x:a -> y:b -> z:c -> w:d -> Lemma (p x y z w ==> r)))
  : Lemma ((exists x y z w . p x y z w) ==> r)
  = FStar.Classical.forall_to_exists (fun x -> 
      FStar.Classical.forall_to_exists (fun y -> 
        FStar.Classical.forall_to_exists (fun z -> 
          FStar.Classical.forall_to_exists (fun w -> 
            f x y z w))))

private let lemma_fresh_or_old_trans' (h0 h1 h2:heap) (m_old m_fresh m_old' m_fresh':memory)
  : Lemma (requires (fresh_or_old' h0 h1 m_old m_fresh /\ fresh_or_old' h1 h2 m_old' m_fresh'))
          (ensures  (let m_old'' = restrict_memory (addrs_in m_old) m_old' in
                     let m_fresh'' = complement_memory (addrs_in m_old) m_old' <*> m_fresh' in
                     fresh_or_old' h0 h2 m_old'' m_fresh''))
  = () 

private let lemma_fresh_or_old_trans'' (h0 h1 h2:heap) (m_old m_fresh m_old' m_fresh':memory)
  : Lemma (requires (fresh_or_old' h0 h1 m_old m_fresh /\ fresh_or_old' h1 h2 m_old' m_fresh'))
          (ensures  (fresh_or_old h0 h2))
  = let m_old'' = restrict_memory (addrs_in m_old) m_old' in
    let m_fresh'' = complement_memory (addrs_in m_old) m_old' <*> m_fresh' in 
    lemma_fresh_or_old_trans' h0 h1 h2 m_old m_fresh m_old' m_fresh';
    exists_intro_2 (fun m_old'' m_fresh'' -> 
      fresh_or_old' h0 h2 m_old'' m_fresh'') m_old'' m_fresh''

private let lemma_fresh_or_old_trans''' (h0 h1 h2:heap) (m_old m_fresh m_old' m_fresh':memory)
  : Lemma (fresh_or_old' h0 h1 m_old m_fresh /\ fresh_or_old' h1 h2 m_old' m_fresh' 
           ==> 
           fresh_or_old h0 h2)
  = FStar.Classical.move_requires (fun _ -> 
      lemma_fresh_or_old_trans'' h0 h1 h2 m_old m_fresh m_old' m_fresh') ()

let lemma_fresh_or_old_trans (h0 h1 h2:heap) 
  : Lemma (requires (exists m_old m_fresh m_old' m_fresh' . 
                       fresh_or_old' h0 h1 m_old m_fresh /\ fresh_or_old' h1 h2 m_old' m_fresh'))
          (ensures  (fresh_or_old h0 h2))
  = forall_to_exists_4 (fun m_old m_fresh m_old' m_fresh' -> 
      lemma_fresh_or_old_trans''' h0 h1 h2 m_old m_fresh m_old' m_fresh')

private let lemma_fresh_or_old_disjoint' (h0 h1 h2:heap) (m_old m_fresh:memory)
  : Lemma (requires (fresh_or_old' h0 h1 m_old m_fresh /\ 
                     disjoint_heaps h0 h2 /\ same_freshness h0 h2))
          (ensures  (disjoint_heaps h1 h2))
  = admit () //TODO
    //assert (defined (m_old <*> m_fresh))

private let lemma_fresh_or_old_disjoint'' (h0 h1 h2:heap) (m_old m_fresh:memory)
  : Lemma (fresh_or_old' h0 h1 m_old m_fresh /\ 
           disjoint_heaps h0 h2 /\ same_freshness h0 h2 ==> disjoint_heaps h1 h2)
  = FStar.Classical.move_requires (fun _ -> 
      lemma_fresh_or_old_disjoint' h0 h1 h2 m_old m_fresh) ()

let lemma_fresh_or_old_disjoint (h0 h1 h2:heap)
  : Lemma (requires (fresh_or_old h0 h1 /\ disjoint_heaps h0 h2 /\ same_freshness h0 h2))
          (ensures  (disjoint_heaps h1 h2))
          [SMTPat (fresh_or_old h0 h1);
           SMTPat (same_freshness h0 h2)]
  = FStar.Classical.forall_to_exists #memory (fun m_old -> 
      FStar.Classical.forall_to_exists #memory (fun m_fresh -> 
        lemma_fresh_or_old_disjoint'' h0 h1 h2 m_old m_fresh))

#set-options "--max_fuel 0 --max_ifuel 0"

private let lemma_fresh_or_old_sep' (h0 h1 h2:heap) (m_old m_fresh:memory) 
  : Lemma (requires (fresh_or_old' h0 h1 m_old m_fresh /\ 
                     disjoint_heaps h0 h2 /\ disjoint_heaps h1 h2 /\ same_freshness h0 h2))
          (ensures  (fresh_or_old' (join h0 h2) (join h1 h2) (m_old <*> heap_memory h2) m_fresh))
  = lemma_sep_comm (heap_memory h2) m_fresh

#reset-options "--max_fuel 8 --max_ifuel 2"

private let lemma_fresh_or_old_sep'' (h0 h1 h2:heap) (m_old m_fresh:memory)
  : Lemma (requires (fresh_or_old' h0 h1 m_old m_fresh /\ 
                     disjoint_heaps h0 h2 /\ disjoint_heaps h1 h2 /\ same_freshness h0 h2))
          (ensures  (fresh_or_old (join h0 h2) (join h1 h2)))
  = lemma_fresh_or_old_sep' h0 h1 h2 m_old m_fresh;
    exists_intro_2 (fun m_old' m_fresh' -> 
                      fresh_or_old' (join h0 h2) (join h1 h2) (m_old <*> heap_memory h2) m_fresh)
                   (m_old <*> heap_memory h2) (m_fresh)
  
private let lemma_fresh_or_old_sep''' (h0 h1:heap) 
                                      (h2:heap{disjoint_heaps h0 h2 /\ disjoint_heaps h1 h2 /\ same_freshness h0 h2}) 
                                      (m_old m_fresh:memory)
  : Lemma ((fresh_or_old' h0 h1 m_old m_fresh) ==> (fresh_or_old (join h0 h2) (join h1 h2)))
  = FStar.Classical.move_requires (fun _ -> lemma_fresh_or_old_sep'' h0 h1 h2 m_old m_fresh) ()

private let lemma_fresh_or_old_sep'''' (h0 h1:heap) 
                                       (h2:heap{disjoint_heaps h0 h2 /\ disjoint_heaps h1 h2 /\ same_freshness h0 h2})
  : Lemma (fresh_or_old h0 h1 ==> fresh_or_old (join h0 h2) (join h1 h2))
  = forall_to_exists_2 
      (fun m_old m_fresh -> lemma_fresh_or_old_sep''' h0 h1 h2 m_old m_fresh)

let lemma_fresh_or_old_sep h0 h1 h2 = 
  lemma_fresh_or_old_sep'''' h0 h1 h2

let lemma_fresh_or_old_alloc #a x h0 =
  let (r,h1) = alloc h0 x in 
  exists_intro_2 (fun m_old m_fresh -> 
    fresh_or_old' h0 h1 m_old m_fresh) (heap_memory h0) (r |> x)

let lemma_fresh_or_old_dealloc #a r h0 =
  exists_intro_2 (fun m_old m_fresh -> 
    fresh_or_old' h0 (dealloc h0 r) m_old m_fresh) (heap_memory (dealloc h0 r)) emp

let lemma_fresh_or_old_upd #a r x h0 =
  exists_intro_2 (fun m_old m_fresh -> 
    fresh_or_old' h0 (upd h0 r x) m_old m_fresh) (heap_memory (upd h0 r x)) emp
