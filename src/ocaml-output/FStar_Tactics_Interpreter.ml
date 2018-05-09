open Prims
let (tacdbg : Prims.bool FStar_ST.ref) = FStar_Util.mk_ref false 
let mk_tactic_interpretation_0 :
  'r .
    Prims.bool ->
      'r FStar_Tactics_Basic.tac ->
        'r FStar_Syntax_Embeddings.embedding ->
          FStar_Ident.lid ->
            FStar_TypeChecker_Normalize.psc ->
              FStar_Syntax_Syntax.args ->
                FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun er  ->
        fun nm  ->
          fun psc  ->
            fun args  ->
              match args with
              | (embedded_state,uu____70)::[] ->
                  let uu____87 =
                    FStar_Syntax_Embeddings.unembed
                      FStar_Tactics_Embedding.e_proofstate embedded_state
                     in
                  FStar_Util.bind_opt uu____87
                    (fun ps  ->
                       let ps1 = FStar_Tactics_Types.set_ps_psc psc ps  in
                       FStar_Tactics_Basic.log ps1
                         (fun uu____100  ->
                            let uu____101 = FStar_Ident.string_of_lid nm  in
                            let uu____102 =
                              FStar_Syntax_Print.args_to_string args  in
                            FStar_Util.print2 "Reached %s, args are: %s\n"
                              uu____101 uu____102);
                       (let res =
                          let uu____104 = FStar_Tactics_Embedding.e_result er
                             in
                          let uu____109 =
                            FStar_TypeChecker_Normalize.psc_range psc  in
                          let uu____110 = FStar_Tactics_Basic.run_safe t ps1
                             in
                          FStar_Syntax_Embeddings.embed uu____104 uu____109
                            uu____110
                           in
                        FStar_Pervasives_Native.Some res))
              | uu____115 ->
                  failwith "Unexpected application of tactic primitive"
  
let mk_tactic_interpretation_1 :
  'a 'r .
    Prims.bool ->
      ('a -> 'r FStar_Tactics_Basic.tac) ->
        'a FStar_Syntax_Embeddings.embedding ->
          'r FStar_Syntax_Embeddings.embedding ->
            FStar_Ident.lid ->
              FStar_TypeChecker_Normalize.psc ->
                FStar_Syntax_Syntax.args ->
                  FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun ea  ->
        fun er  ->
          fun nm  ->
            fun psc  ->
              fun args  ->
                match args with
                | (a,uu____193)::(embedded_state,uu____195)::[] ->
                    let uu____222 =
                      FStar_Syntax_Embeddings.unembed
                        FStar_Tactics_Embedding.e_proofstate embedded_state
                       in
                    FStar_Util.bind_opt uu____222
                      (fun ps  ->
                         let ps1 = FStar_Tactics_Types.set_ps_psc psc ps  in
                         FStar_Tactics_Basic.log ps1
                           (fun uu____235  ->
                              let uu____236 = FStar_Ident.string_of_lid nm
                                 in
                              let uu____237 =
                                FStar_Syntax_Print.term_to_string
                                  embedded_state
                                 in
                              FStar_Util.print2 "Reached %s, goals are: %s\n"
                                uu____236 uu____237);
                         (let uu____238 =
                            FStar_Syntax_Embeddings.unembed ea a  in
                          FStar_Util.bind_opt uu____238
                            (fun a1  ->
                               let res =
                                 let uu____248 = t a1  in
                                 FStar_Tactics_Basic.run_safe uu____248 ps1
                                  in
                               let uu____251 =
                                 let uu____252 =
                                   FStar_Tactics_Embedding.e_result er  in
                                 let uu____257 =
                                   FStar_TypeChecker_Normalize.psc_range psc
                                    in
                                 FStar_Syntax_Embeddings.embed uu____252
                                   uu____257 res
                                  in
                               FStar_Pervasives_Native.Some uu____251)))
                | uu____260 ->
                    let uu____261 =
                      let uu____262 = FStar_Ident.string_of_lid nm  in
                      let uu____263 = FStar_Syntax_Print.args_to_string args
                         in
                      FStar_Util.format2
                        "Unexpected application of tactic primitive %s %s"
                        uu____262 uu____263
                       in
                    failwith uu____261
  
let mk_tactic_interpretation_1_env :
  'a 'r .
    Prims.bool ->
      (FStar_TypeChecker_Normalize.psc -> 'a -> 'r FStar_Tactics_Basic.tac)
        ->
        'a FStar_Syntax_Embeddings.embedding ->
          'r FStar_Syntax_Embeddings.embedding ->
            FStar_Ident.lid ->
              FStar_TypeChecker_Normalize.psc ->
                FStar_Syntax_Syntax.args ->
                  FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun ea  ->
        fun er  ->
          fun nm  ->
            fun psc  ->
              fun args  ->
                match args with
                | (a,uu____346)::(embedded_state,uu____348)::[] ->
                    let uu____375 =
                      FStar_Syntax_Embeddings.unembed
                        FStar_Tactics_Embedding.e_proofstate embedded_state
                       in
                    FStar_Util.bind_opt uu____375
                      (fun ps  ->
                         let ps1 = FStar_Tactics_Types.set_ps_psc psc ps  in
                         FStar_Tactics_Basic.log ps1
                           (fun uu____388  ->
                              let uu____389 = FStar_Ident.string_of_lid nm
                                 in
                              let uu____390 =
                                FStar_Syntax_Print.term_to_string
                                  embedded_state
                                 in
                              FStar_Util.print2 "Reached %s, goals are: %s\n"
                                uu____389 uu____390);
                         (let uu____391 =
                            FStar_Syntax_Embeddings.unembed ea a  in
                          FStar_Util.bind_opt uu____391
                            (fun a1  ->
                               let res =
                                 let uu____401 = t psc a1  in
                                 FStar_Tactics_Basic.run_safe uu____401 ps1
                                  in
                               let uu____404 =
                                 let uu____405 =
                                   FStar_Tactics_Embedding.e_result er  in
                                 let uu____410 =
                                   FStar_TypeChecker_Normalize.psc_range psc
                                    in
                                 FStar_Syntax_Embeddings.embed uu____405
                                   uu____410 res
                                  in
                               FStar_Pervasives_Native.Some uu____404)))
                | uu____413 ->
                    let uu____414 =
                      let uu____415 = FStar_Ident.string_of_lid nm  in
                      let uu____416 = FStar_Syntax_Print.args_to_string args
                         in
                      FStar_Util.format2
                        "Unexpected application of tactic primitive %s %s"
                        uu____415 uu____416
                       in
                    failwith uu____414
  
let mk_tactic_interpretation_2 :
  'a 'b 'r .
    Prims.bool ->
      ('a -> 'b -> 'r FStar_Tactics_Basic.tac) ->
        'a FStar_Syntax_Embeddings.embedding ->
          'b FStar_Syntax_Embeddings.embedding ->
            'r FStar_Syntax_Embeddings.embedding ->
              FStar_Ident.lid ->
                FStar_TypeChecker_Normalize.psc ->
                  FStar_Syntax_Syntax.args ->
                    FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun ea  ->
        fun eb  ->
          fun er  ->
            fun nm  ->
              fun psc  ->
                fun args  ->
                  match args with
                  | (a,uu____513)::(b,uu____515)::(embedded_state,uu____517)::[]
                      ->
                      let uu____554 =
                        FStar_Syntax_Embeddings.unembed
                          FStar_Tactics_Embedding.e_proofstate embedded_state
                         in
                      FStar_Util.bind_opt uu____554
                        (fun ps  ->
                           let ps1 = FStar_Tactics_Types.set_ps_psc psc ps
                              in
                           FStar_Tactics_Basic.log ps1
                             (fun uu____567  ->
                                let uu____568 = FStar_Ident.string_of_lid nm
                                   in
                                let uu____569 =
                                  FStar_Syntax_Print.term_to_string
                                    embedded_state
                                   in
                                FStar_Util.print2
                                  "Reached %s, goals are: %s\n" uu____568
                                  uu____569);
                           (let uu____570 =
                              FStar_Syntax_Embeddings.unembed ea a  in
                            FStar_Util.bind_opt uu____570
                              (fun a1  ->
                                 let uu____576 =
                                   FStar_Syntax_Embeddings.unembed eb b  in
                                 FStar_Util.bind_opt uu____576
                                   (fun b1  ->
                                      let res =
                                        let uu____586 = t a1 b1  in
                                        FStar_Tactics_Basic.run_safe
                                          uu____586 ps1
                                         in
                                      let uu____589 =
                                        let uu____590 =
                                          FStar_Tactics_Embedding.e_result er
                                           in
                                        let uu____595 =
                                          FStar_TypeChecker_Normalize.psc_range
                                            psc
                                           in
                                        FStar_Syntax_Embeddings.embed
                                          uu____590 uu____595 res
                                         in
                                      FStar_Pervasives_Native.Some uu____589))))
                  | uu____598 ->
                      let uu____599 =
                        let uu____600 = FStar_Ident.string_of_lid nm  in
                        let uu____601 =
                          FStar_Syntax_Print.args_to_string args  in
                        FStar_Util.format2
                          "Unexpected application of tactic primitive %s %s"
                          uu____600 uu____601
                         in
                      failwith uu____599
  
let mk_tactic_interpretation_3 :
  'a 'b 'c 'r .
    Prims.bool ->
      ('a -> 'b -> 'c -> 'r FStar_Tactics_Basic.tac) ->
        'a FStar_Syntax_Embeddings.embedding ->
          'b FStar_Syntax_Embeddings.embedding ->
            'c FStar_Syntax_Embeddings.embedding ->
              'r FStar_Syntax_Embeddings.embedding ->
                FStar_Ident.lid ->
                  FStar_TypeChecker_Normalize.psc ->
                    FStar_Syntax_Syntax.args ->
                      FStar_Syntax_Syntax.term FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun ea  ->
        fun eb  ->
          fun ec  ->
            fun er  ->
              fun nm  ->
                fun psc  ->
                  fun args  ->
                    match args with
                    | (a,uu____717)::(b,uu____719)::(c,uu____721)::(embedded_state,uu____723)::[]
                        ->
                        let uu____770 =
                          FStar_Syntax_Embeddings.unembed
                            FStar_Tactics_Embedding.e_proofstate
                            embedded_state
                           in
                        FStar_Util.bind_opt uu____770
                          (fun ps  ->
                             let ps1 = FStar_Tactics_Types.set_ps_psc psc ps
                                in
                             FStar_Tactics_Basic.log ps1
                               (fun uu____783  ->
                                  let uu____784 =
                                    FStar_Ident.string_of_lid nm  in
                                  let uu____785 =
                                    FStar_Syntax_Print.term_to_string
                                      embedded_state
                                     in
                                  FStar_Util.print2
                                    "Reached %s, goals are: %s\n" uu____784
                                    uu____785);
                             (let uu____786 =
                                FStar_Syntax_Embeddings.unembed ea a  in
                              FStar_Util.bind_opt uu____786
                                (fun a1  ->
                                   let uu____792 =
                                     FStar_Syntax_Embeddings.unembed eb b  in
                                   FStar_Util.bind_opt uu____792
                                     (fun b1  ->
                                        let uu____798 =
                                          FStar_Syntax_Embeddings.unembed ec
                                            c
                                           in
                                        FStar_Util.bind_opt uu____798
                                          (fun c1  ->
                                             let res =
                                               let uu____808 = t a1 b1 c1  in
                                               FStar_Tactics_Basic.run_safe
                                                 uu____808 ps1
                                                in
                                             let uu____811 =
                                               let uu____812 =
                                                 FStar_Tactics_Embedding.e_result
                                                   er
                                                  in
                                               let uu____817 =
                                                 FStar_TypeChecker_Normalize.psc_range
                                                   psc
                                                  in
                                               FStar_Syntax_Embeddings.embed
                                                 uu____812 uu____817 res
                                                in
                                             FStar_Pervasives_Native.Some
                                               uu____811)))))
                    | uu____820 ->
                        let uu____821 =
                          let uu____822 = FStar_Ident.string_of_lid nm  in
                          let uu____823 =
                            FStar_Syntax_Print.args_to_string args  in
                          FStar_Util.format2
                            "Unexpected application of tactic primitive %s %s"
                            uu____822 uu____823
                           in
                        failwith uu____821
  
let mk_tactic_interpretation_4 :
  'a 'b 'c 'd 'r .
    Prims.bool ->
      ('a -> 'b -> 'c -> 'd -> 'r FStar_Tactics_Basic.tac) ->
        'a FStar_Syntax_Embeddings.embedding ->
          'b FStar_Syntax_Embeddings.embedding ->
            'c FStar_Syntax_Embeddings.embedding ->
              'd FStar_Syntax_Embeddings.embedding ->
                'r FStar_Syntax_Embeddings.embedding ->
                  FStar_Ident.lid ->
                    FStar_TypeChecker_Normalize.psc ->
                      FStar_Syntax_Syntax.args ->
                        FStar_Syntax_Syntax.term
                          FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun ea  ->
        fun eb  ->
          fun ec  ->
            fun ed  ->
              fun er  ->
                fun nm  ->
                  fun psc  ->
                    fun args  ->
                      match args with
                      | (a,uu____958)::(b,uu____960)::(c,uu____962)::
                          (d,uu____964)::(embedded_state,uu____966)::[] ->
                          let uu____1023 =
                            FStar_Syntax_Embeddings.unembed
                              FStar_Tactics_Embedding.e_proofstate
                              embedded_state
                             in
                          FStar_Util.bind_opt uu____1023
                            (fun ps  ->
                               let ps1 =
                                 FStar_Tactics_Types.set_ps_psc psc ps  in
                               FStar_Tactics_Basic.log ps1
                                 (fun uu____1036  ->
                                    let uu____1037 =
                                      FStar_Ident.string_of_lid nm  in
                                    let uu____1038 =
                                      FStar_Syntax_Print.term_to_string
                                        embedded_state
                                       in
                                    FStar_Util.print2
                                      "Reached %s, goals are: %s\n"
                                      uu____1037 uu____1038);
                               (let uu____1039 =
                                  FStar_Syntax_Embeddings.unembed ea a  in
                                FStar_Util.bind_opt uu____1039
                                  (fun a1  ->
                                     let uu____1045 =
                                       FStar_Syntax_Embeddings.unembed eb b
                                        in
                                     FStar_Util.bind_opt uu____1045
                                       (fun b1  ->
                                          let uu____1051 =
                                            FStar_Syntax_Embeddings.unembed
                                              ec c
                                             in
                                          FStar_Util.bind_opt uu____1051
                                            (fun c1  ->
                                               let uu____1057 =
                                                 FStar_Syntax_Embeddings.unembed
                                                   ed d
                                                  in
                                               FStar_Util.bind_opt uu____1057
                                                 (fun d1  ->
                                                    let res =
                                                      let uu____1067 =
                                                        t a1 b1 c1 d1  in
                                                      FStar_Tactics_Basic.run_safe
                                                        uu____1067 ps1
                                                       in
                                                    let uu____1070 =
                                                      let uu____1071 =
                                                        FStar_Tactics_Embedding.e_result
                                                          er
                                                         in
                                                      let uu____1076 =
                                                        FStar_TypeChecker_Normalize.psc_range
                                                          psc
                                                         in
                                                      FStar_Syntax_Embeddings.embed
                                                        uu____1071 uu____1076
                                                        res
                                                       in
                                                    FStar_Pervasives_Native.Some
                                                      uu____1070))))))
                      | uu____1079 ->
                          let uu____1080 =
                            let uu____1081 = FStar_Ident.string_of_lid nm  in
                            let uu____1082 =
                              FStar_Syntax_Print.args_to_string args  in
                            FStar_Util.format2
                              "Unexpected application of tactic primitive %s %s"
                              uu____1081 uu____1082
                             in
                          failwith uu____1080
  
let mk_tactic_interpretation_5 :
  'a 'b 'c 'd 'e 'r .
    Prims.bool ->
      ('a -> 'b -> 'c -> 'd -> 'e -> 'r FStar_Tactics_Basic.tac) ->
        'a FStar_Syntax_Embeddings.embedding ->
          'b FStar_Syntax_Embeddings.embedding ->
            'c FStar_Syntax_Embeddings.embedding ->
              'd FStar_Syntax_Embeddings.embedding ->
                'e FStar_Syntax_Embeddings.embedding ->
                  'r FStar_Syntax_Embeddings.embedding ->
                    FStar_Ident.lid ->
                      FStar_TypeChecker_Normalize.psc ->
                        FStar_Syntax_Syntax.args ->
                          FStar_Syntax_Syntax.term
                            FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun ea  ->
        fun eb  ->
          fun ec  ->
            fun ed  ->
              fun ee  ->
                fun er  ->
                  fun nm  ->
                    fun psc  ->
                      fun args  ->
                        match args with
                        | (a,uu____1236)::(b,uu____1238)::(c,uu____1240)::
                            (d,uu____1242)::(e,uu____1244)::(embedded_state,uu____1246)::[]
                            ->
                            let uu____1313 =
                              FStar_Syntax_Embeddings.unembed
                                FStar_Tactics_Embedding.e_proofstate
                                embedded_state
                               in
                            FStar_Util.bind_opt uu____1313
                              (fun ps  ->
                                 let ps1 =
                                   FStar_Tactics_Types.set_ps_psc psc ps  in
                                 FStar_Tactics_Basic.log ps1
                                   (fun uu____1326  ->
                                      let uu____1327 =
                                        FStar_Ident.string_of_lid nm  in
                                      let uu____1328 =
                                        FStar_Syntax_Print.term_to_string
                                          embedded_state
                                         in
                                      FStar_Util.print2
                                        "Reached %s, goals are: %s\n"
                                        uu____1327 uu____1328);
                                 (let uu____1329 =
                                    FStar_Syntax_Embeddings.unembed ea a  in
                                  FStar_Util.bind_opt uu____1329
                                    (fun a1  ->
                                       let uu____1335 =
                                         FStar_Syntax_Embeddings.unembed eb b
                                          in
                                       FStar_Util.bind_opt uu____1335
                                         (fun b1  ->
                                            let uu____1341 =
                                              FStar_Syntax_Embeddings.unembed
                                                ec c
                                               in
                                            FStar_Util.bind_opt uu____1341
                                              (fun c1  ->
                                                 let uu____1347 =
                                                   FStar_Syntax_Embeddings.unembed
                                                     ed d
                                                    in
                                                 FStar_Util.bind_opt
                                                   uu____1347
                                                   (fun d1  ->
                                                      let uu____1353 =
                                                        FStar_Syntax_Embeddings.unembed
                                                          ee e
                                                         in
                                                      FStar_Util.bind_opt
                                                        uu____1353
                                                        (fun e1  ->
                                                           let res =
                                                             let uu____1363 =
                                                               t a1 b1 c1 d1
                                                                 e1
                                                                in
                                                             FStar_Tactics_Basic.run_safe
                                                               uu____1363 ps1
                                                              in
                                                           let uu____1366 =
                                                             let uu____1367 =
                                                               FStar_Tactics_Embedding.e_result
                                                                 er
                                                                in
                                                             let uu____1372 =
                                                               FStar_TypeChecker_Normalize.psc_range
                                                                 psc
                                                                in
                                                             FStar_Syntax_Embeddings.embed
                                                               uu____1367
                                                               uu____1372 res
                                                              in
                                                           FStar_Pervasives_Native.Some
                                                             uu____1366)))))))
                        | uu____1375 ->
                            let uu____1376 =
                              let uu____1377 = FStar_Ident.string_of_lid nm
                                 in
                              let uu____1378 =
                                FStar_Syntax_Print.args_to_string args  in
                              FStar_Util.format2
                                "Unexpected application of tactic primitive %s %s"
                                uu____1377 uu____1378
                               in
                            failwith uu____1376
  
let mk_tactic_interpretation_6 :
  'a 'b 'c 'd 'e 'f 'r .
    Prims.bool ->
      ('a -> 'b -> 'c -> 'd -> 'e -> 'f -> 'r FStar_Tactics_Basic.tac) ->
        'a FStar_Syntax_Embeddings.embedding ->
          'b FStar_Syntax_Embeddings.embedding ->
            'c FStar_Syntax_Embeddings.embedding ->
              'd FStar_Syntax_Embeddings.embedding ->
                'e FStar_Syntax_Embeddings.embedding ->
                  'f FStar_Syntax_Embeddings.embedding ->
                    'r FStar_Syntax_Embeddings.embedding ->
                      FStar_Ident.lid ->
                        FStar_TypeChecker_Normalize.psc ->
                          FStar_Syntax_Syntax.args ->
                            FStar_Syntax_Syntax.term
                              FStar_Pervasives_Native.option
  =
  fun reflect  ->
    fun t  ->
      fun ea  ->
        fun eb  ->
          fun ec  ->
            fun ed  ->
              fun ee  ->
                fun ef  ->
                  fun er  ->
                    fun nm  ->
                      fun psc  ->
                        fun args  ->
                          match args with
                          | (a,uu____1551)::(b,uu____1553)::(c,uu____1555)::
                              (d,uu____1557)::(e,uu____1559)::(f,uu____1561)::
                              (embedded_state,uu____1563)::[] ->
                              let uu____1640 =
                                FStar_Syntax_Embeddings.unembed
                                  FStar_Tactics_Embedding.e_proofstate
                                  embedded_state
                                 in
                              FStar_Util.bind_opt uu____1640
                                (fun ps  ->
                                   let ps1 =
                                     FStar_Tactics_Types.set_ps_psc psc ps
                                      in
                                   FStar_Tactics_Basic.log ps1
                                     (fun uu____1653  ->
                                        let uu____1654 =
                                          FStar_Ident.string_of_lid nm  in
                                        let uu____1655 =
                                          FStar_Syntax_Print.term_to_string
                                            embedded_state
                                           in
                                        FStar_Util.print2
                                          "Reached %s, goals are: %s\n"
                                          uu____1654 uu____1655);
                                   (let uu____1656 =
                                      FStar_Syntax_Embeddings.unembed ea a
                                       in
                                    FStar_Util.bind_opt uu____1656
                                      (fun a1  ->
                                         let uu____1662 =
                                           FStar_Syntax_Embeddings.unembed eb
                                             b
                                            in
                                         FStar_Util.bind_opt uu____1662
                                           (fun b1  ->
                                              let uu____1668 =
                                                FStar_Syntax_Embeddings.unembed
                                                  ec c
                                                 in
                                              FStar_Util.bind_opt uu____1668
                                                (fun c1  ->
                                                   let uu____1674 =
                                                     FStar_Syntax_Embeddings.unembed
                                                       ed d
                                                      in
                                                   FStar_Util.bind_opt
                                                     uu____1674
                                                     (fun d1  ->
                                                        let uu____1680 =
                                                          FStar_Syntax_Embeddings.unembed
                                                            ee e
                                                           in
                                                        FStar_Util.bind_opt
                                                          uu____1680
                                                          (fun e1  ->
                                                             let uu____1686 =
                                                               FStar_Syntax_Embeddings.unembed
                                                                 ef f
                                                                in
                                                             FStar_Util.bind_opt
                                                               uu____1686
                                                               (fun f1  ->
                                                                  let res =
                                                                    let uu____1696
                                                                    =
                                                                    t a1 b1
                                                                    c1 d1 e1
                                                                    f1  in
                                                                    FStar_Tactics_Basic.run_safe
                                                                    uu____1696
                                                                    ps1  in
                                                                  let uu____1699
                                                                    =
                                                                    let uu____1700
                                                                    =
                                                                    FStar_Tactics_Embedding.e_result
                                                                    er  in
                                                                    let uu____1705
                                                                    =
                                                                    FStar_TypeChecker_Normalize.psc_range
                                                                    psc  in
                                                                    FStar_Syntax_Embeddings.embed
                                                                    uu____1700
                                                                    uu____1705
                                                                    res  in
                                                                  FStar_Pervasives_Native.Some
                                                                    uu____1699))))))))
                          | uu____1708 ->
                              let uu____1709 =
                                let uu____1710 = FStar_Ident.string_of_lid nm
                                   in
                                let uu____1711 =
                                  FStar_Syntax_Print.args_to_string args  in
                                FStar_Util.format2
                                  "Unexpected application of tactic primitive %s %s"
                                  uu____1710 uu____1711
                                 in
                              failwith uu____1709
  
let (step_from_native_step :
  FStar_Tactics_Native.native_primitive_step ->
    FStar_TypeChecker_Normalize.primitive_step)
  =
  fun s  ->
    {
      FStar_TypeChecker_Normalize.name = (s.FStar_Tactics_Native.name);
      FStar_TypeChecker_Normalize.arity = (s.FStar_Tactics_Native.arity);
      FStar_TypeChecker_Normalize.auto_reflect =
        (FStar_Pervasives_Native.Some
           (s.FStar_Tactics_Native.arity - (Prims.parse_int "1")));
      FStar_TypeChecker_Normalize.strong_reduction_ok =
        (s.FStar_Tactics_Native.strong_reduction_ok);
      FStar_TypeChecker_Normalize.requires_binder_substitution = false;
      FStar_TypeChecker_Normalize.interpretation =
        (fun psc  -> fun args  -> s.FStar_Tactics_Native.tactic psc args)
    }
  
let rec e_tactic_0' :
  'r .
    'r FStar_Syntax_Embeddings.embedding ->
      'r FStar_Tactics_Basic.tac FStar_Syntax_Embeddings.embedding
  =
  fun er  ->
    FStar_Syntax_Embeddings.mk_emb
      (fun uu____1855  ->
         fun uu____1856  -> failwith "Impossible: embedding tactic (0)?")
      (fun w  ->
         fun t  ->
           let uu____1864 = unembed_tactic_0 er t  in
           FStar_All.pipe_left
             (fun _0_16  -> FStar_Pervasives_Native.Some _0_16) uu____1864)
      FStar_Syntax_Syntax.t_unit

and e_tactic_1 :
  'a 'r .
    'a FStar_Syntax_Embeddings.embedding ->
      'r FStar_Syntax_Embeddings.embedding ->
        ('a -> 'r FStar_Tactics_Basic.tac) FStar_Syntax_Embeddings.embedding
  =
  fun ea  ->
    fun er  ->
      FStar_Syntax_Embeddings.mk_emb
        (fun uu____1888  ->
           fun uu____1889  -> failwith "Impossible: embedding tactic (1)?")
        (fun w  -> fun t  -> unembed_tactic_1 ea er t)
        FStar_Syntax_Syntax.t_unit

and (primitive_steps :
  unit -> FStar_TypeChecker_Normalize.primitive_step Prims.list) =
  fun uu____1898  ->
    let mk1 nm arity interpretation =
      let nm1 = FStar_Tactics_Embedding.fstar_tactics_lid' ["Builtins"; nm]
         in
      {
        FStar_TypeChecker_Normalize.name = nm1;
        FStar_TypeChecker_Normalize.arity = arity;
        FStar_TypeChecker_Normalize.auto_reflect =
          (FStar_Pervasives_Native.Some (arity - (Prims.parse_int "1")));
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.requires_binder_substitution = true;
        FStar_TypeChecker_Normalize.interpretation =
          (fun psc  -> fun args  -> interpretation nm1 psc args)
      }  in
    let native_tactics = FStar_Tactics_Native.list_all ()  in
    let native_tactics_steps =
      FStar_List.map step_from_native_step native_tactics  in
    let mktac1 name f ea er =
      mk1 name (Prims.parse_int "2")
        (mk_tactic_interpretation_1 false f ea er)
       in
    let mktac2 name f ea eb er =
      mk1 name (Prims.parse_int "3")
        (mk_tactic_interpretation_2 false f ea eb er)
       in
    let mktac3 name f ea eb ec er =
      mk1 name (Prims.parse_int "4")
        (mk_tactic_interpretation_3 false f ea eb ec er)
       in
    let mktac5 name f ea eb ec ed ee er =
      mk1 name (Prims.parse_int "6")
        (mk_tactic_interpretation_5 false f ea eb ec ed ee er)
       in
    let decr_depth_interp psc args =
      match args with
      | (ps,uu____2304)::[] ->
          let uu____2321 =
            FStar_Syntax_Embeddings.unembed
              FStar_Tactics_Embedding.e_proofstate ps
             in
          FStar_Util.bind_opt uu____2321
            (fun ps1  ->
               let ps2 = FStar_Tactics_Types.set_ps_psc psc ps1  in
               let uu____2329 =
                 let uu____2330 = FStar_TypeChecker_Normalize.psc_range psc
                    in
                 let uu____2331 = FStar_Tactics_Types.decr_depth ps2  in
                 FStar_Syntax_Embeddings.embed
                   FStar_Tactics_Embedding.e_proofstate uu____2330 uu____2331
                  in
               FStar_Pervasives_Native.Some uu____2329)
      | uu____2332 -> failwith "Unexpected application of decr_depth"  in
    let decr_depth_step =
      let uu____2336 =
        FStar_Ident.lid_of_str "FStar.Tactics.Types.decr_depth"  in
      {
        FStar_TypeChecker_Normalize.name = uu____2336;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "1");
        FStar_TypeChecker_Normalize.auto_reflect =
          FStar_Pervasives_Native.None;
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.requires_binder_substitution = false;
        FStar_TypeChecker_Normalize.interpretation = decr_depth_interp
      }  in
    let incr_depth_interp psc args =
      match args with
      | (ps,uu____2353)::[] ->
          let uu____2370 =
            FStar_Syntax_Embeddings.unembed
              FStar_Tactics_Embedding.e_proofstate ps
             in
          FStar_Util.bind_opt uu____2370
            (fun ps1  ->
               let ps2 = FStar_Tactics_Types.set_ps_psc psc ps1  in
               let uu____2378 =
                 let uu____2379 = FStar_TypeChecker_Normalize.psc_range psc
                    in
                 let uu____2380 = FStar_Tactics_Types.incr_depth ps2  in
                 FStar_Syntax_Embeddings.embed
                   FStar_Tactics_Embedding.e_proofstate uu____2379 uu____2380
                  in
               FStar_Pervasives_Native.Some uu____2378)
      | uu____2381 -> failwith "Unexpected application of incr_depth"  in
    let incr_depth_step =
      let uu____2385 =
        FStar_Ident.lid_of_str "FStar.Tactics.Types.incr_depth"  in
      {
        FStar_TypeChecker_Normalize.name = uu____2385;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "1");
        FStar_TypeChecker_Normalize.auto_reflect =
          FStar_Pervasives_Native.None;
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.requires_binder_substitution = false;
        FStar_TypeChecker_Normalize.interpretation = incr_depth_interp
      }  in
    let tracepoint_interp psc args =
      match args with
      | (ps,uu____2402)::[] ->
          let uu____2419 =
            FStar_Syntax_Embeddings.unembed
              FStar_Tactics_Embedding.e_proofstate ps
             in
          FStar_Util.bind_opt uu____2419
            (fun ps1  ->
               let ps2 = FStar_Tactics_Types.set_ps_psc psc ps1  in
               FStar_Tactics_Types.tracepoint ps2;
               FStar_Pervasives_Native.Some FStar_Syntax_Util.exp_unit)
      | uu____2428 -> failwith "Unexpected application of tracepoint"  in
    let set_proofstate_range_interp psc args =
      match args with
      | (ps,uu____2447)::(r,uu____2449)::[] ->
          let uu____2476 =
            FStar_Syntax_Embeddings.unembed
              FStar_Tactics_Embedding.e_proofstate ps
             in
          FStar_Util.bind_opt uu____2476
            (fun ps1  ->
               let uu____2482 =
                 FStar_Syntax_Embeddings.unembed
                   FStar_Syntax_Embeddings.e_range r
                  in
               FStar_Util.bind_opt uu____2482
                 (fun r1  ->
                    let ps' = FStar_Tactics_Types.set_proofstate_range ps1 r1
                       in
                    let uu____2490 =
                      let uu____2491 =
                        FStar_TypeChecker_Normalize.psc_range psc  in
                      FStar_Syntax_Embeddings.embed
                        FStar_Tactics_Embedding.e_proofstate uu____2491 ps'
                       in
                    FStar_Pervasives_Native.Some uu____2490))
      | uu____2492 ->
          failwith "Unexpected application of set_proofstate_range"
       in
    let push_binder_interp psc args =
      match args with
      | (env_t,uu____2511)::(b,uu____2513)::[] ->
          let uu____2540 =
            FStar_Syntax_Embeddings.unembed FStar_Reflection_Embeddings.e_env
              env_t
             in
          FStar_Util.bind_opt uu____2540
            (fun env  ->
               let uu____2546 =
                 FStar_Syntax_Embeddings.unembed
                   FStar_Reflection_Embeddings.e_binder b
                  in
               FStar_Util.bind_opt uu____2546
                 (fun b1  ->
                    let env1 = FStar_TypeChecker_Env.push_binders env [b1]
                       in
                    let uu____2562 =
                      FStar_Syntax_Embeddings.embed
                        FStar_Reflection_Embeddings.e_env
                        env_t.FStar_Syntax_Syntax.pos env1
                       in
                    FStar_Pervasives_Native.Some uu____2562))
      | uu____2563 -> failwith "Unexpected application of push_binder"  in
    let set_proofstate_range_step =
      let nm =
        FStar_Ident.lid_of_str "FStar.Tactics.Types.set_proofstate_range"  in
      {
        FStar_TypeChecker_Normalize.name = nm;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "2");
        FStar_TypeChecker_Normalize.auto_reflect =
          FStar_Pervasives_Native.None;
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.requires_binder_substitution = false;
        FStar_TypeChecker_Normalize.interpretation =
          set_proofstate_range_interp
      }  in
    let tracepoint_step =
      let nm = FStar_Ident.lid_of_str "FStar.Tactics.Types.tracepoint"  in
      {
        FStar_TypeChecker_Normalize.name = nm;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "1");
        FStar_TypeChecker_Normalize.auto_reflect =
          FStar_Pervasives_Native.None;
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.requires_binder_substitution = true;
        FStar_TypeChecker_Normalize.interpretation = tracepoint_interp
      }  in
    let push_binder_step =
      let nm =
        FStar_Tactics_Embedding.fstar_tactics_lid'
          ["Builtins"; "push_binder"]
         in
      {
        FStar_TypeChecker_Normalize.name = nm;
        FStar_TypeChecker_Normalize.arity = (Prims.parse_int "2");
        FStar_TypeChecker_Normalize.auto_reflect =
          FStar_Pervasives_Native.None;
        FStar_TypeChecker_Normalize.strong_reduction_ok = false;
        FStar_TypeChecker_Normalize.requires_binder_substitution = true;
        FStar_TypeChecker_Normalize.interpretation = push_binder_interp
      }  in
    let uu____2572 =
      let uu____2575 =
        mktac2 "fail" (fun uu____2577  -> FStar_Tactics_Basic.fail)
          FStar_Syntax_Embeddings.e_any FStar_Syntax_Embeddings.e_string
          FStar_Syntax_Embeddings.e_any
         in
      let uu____2578 =
        let uu____2581 =
          mktac1 "trivial" FStar_Tactics_Basic.trivial
            FStar_Syntax_Embeddings.e_unit FStar_Syntax_Embeddings.e_unit
           in
        let uu____2582 =
          let uu____2585 =
            let uu____2586 = e_tactic_0' FStar_Syntax_Embeddings.e_any  in
            let uu____2591 =
              FStar_Syntax_Embeddings.e_option FStar_Syntax_Embeddings.e_any
               in
            mktac2 "__trytac" (fun uu____2601  -> FStar_Tactics_Basic.trytac)
              FStar_Syntax_Embeddings.e_any uu____2586 uu____2591
             in
          let uu____2602 =
            let uu____2605 =
              mktac1 "intro" FStar_Tactics_Basic.intro
                FStar_Syntax_Embeddings.e_unit
                FStar_Reflection_Embeddings.e_binder
               in
            let uu____2606 =
              let uu____2609 =
                let uu____2610 =
                  FStar_Syntax_Embeddings.e_tuple2
                    FStar_Reflection_Embeddings.e_binder
                    FStar_Reflection_Embeddings.e_binder
                   in
                mktac1 "intro_rec" FStar_Tactics_Basic.intro_rec
                  FStar_Syntax_Embeddings.e_unit uu____2610
                 in
              let uu____2621 =
                let uu____2624 =
                  let uu____2625 =
                    FStar_Syntax_Embeddings.e_list
                      FStar_Syntax_Embeddings.e_norm_step
                     in
                  mktac1 "norm" FStar_Tactics_Basic.norm uu____2625
                    FStar_Syntax_Embeddings.e_unit
                   in
                let uu____2632 =
                  let uu____2635 =
                    let uu____2636 =
                      FStar_Syntax_Embeddings.e_list
                        FStar_Syntax_Embeddings.e_norm_step
                       in
                    mktac3 "norm_term_env" FStar_Tactics_Basic.norm_term_env
                      FStar_Reflection_Embeddings.e_env uu____2636
                      FStar_Reflection_Embeddings.e_term
                      FStar_Reflection_Embeddings.e_term
                     in
                  let uu____2643 =
                    let uu____2646 =
                      let uu____2647 =
                        FStar_Syntax_Embeddings.e_list
                          FStar_Syntax_Embeddings.e_norm_step
                         in
                      mktac2 "norm_binder_type"
                        FStar_Tactics_Basic.norm_binder_type uu____2647
                        FStar_Reflection_Embeddings.e_binder
                        FStar_Syntax_Embeddings.e_unit
                       in
                    let uu____2654 =
                      let uu____2657 =
                        mktac2 "rename_to" FStar_Tactics_Basic.rename_to
                          FStar_Reflection_Embeddings.e_binder
                          FStar_Syntax_Embeddings.e_string
                          FStar_Syntax_Embeddings.e_unit
                         in
                      let uu____2658 =
                        let uu____2661 =
                          mktac1 "binder_retype"
                            FStar_Tactics_Basic.binder_retype
                            FStar_Reflection_Embeddings.e_binder
                            FStar_Syntax_Embeddings.e_unit
                           in
                        let uu____2662 =
                          let uu____2665 =
                            mktac1 "revert" FStar_Tactics_Basic.revert
                              FStar_Syntax_Embeddings.e_unit
                              FStar_Syntax_Embeddings.e_unit
                             in
                          let uu____2666 =
                            let uu____2669 =
                              mktac1 "clear_top"
                                FStar_Tactics_Basic.clear_top
                                FStar_Syntax_Embeddings.e_unit
                                FStar_Syntax_Embeddings.e_unit
                               in
                            let uu____2670 =
                              let uu____2673 =
                                mktac1 "clear" FStar_Tactics_Basic.clear
                                  FStar_Reflection_Embeddings.e_binder
                                  FStar_Syntax_Embeddings.e_unit
                                 in
                              let uu____2674 =
                                let uu____2677 =
                                  mktac1 "rewrite"
                                    FStar_Tactics_Basic.rewrite
                                    FStar_Reflection_Embeddings.e_binder
                                    FStar_Syntax_Embeddings.e_unit
                                   in
                                let uu____2678 =
                                  let uu____2681 =
                                    mktac1 "smt" FStar_Tactics_Basic.smt
                                      FStar_Syntax_Embeddings.e_unit
                                      FStar_Syntax_Embeddings.e_unit
                                     in
                                  let uu____2682 =
                                    let uu____2685 =
                                      mktac1 "refine_intro"
                                        FStar_Tactics_Basic.refine_intro
                                        FStar_Syntax_Embeddings.e_unit
                                        FStar_Syntax_Embeddings.e_unit
                                       in
                                    let uu____2686 =
                                      let uu____2689 =
                                        mktac2 "t_exact"
                                          FStar_Tactics_Basic.t_exact
                                          FStar_Syntax_Embeddings.e_bool
                                          FStar_Reflection_Embeddings.e_term
                                          FStar_Syntax_Embeddings.e_unit
                                         in
                                      let uu____2690 =
                                        let uu____2693 =
                                          mktac1 "apply"
                                            (FStar_Tactics_Basic.apply true)
                                            FStar_Reflection_Embeddings.e_term
                                            FStar_Syntax_Embeddings.e_unit
                                           in
                                        let uu____2694 =
                                          let uu____2697 =
                                            mktac1 "apply_raw"
                                              (FStar_Tactics_Basic.apply
                                                 false)
                                              FStar_Reflection_Embeddings.e_term
                                              FStar_Syntax_Embeddings.e_unit
                                             in
                                          let uu____2698 =
                                            let uu____2701 =
                                              mktac1 "apply_lemma"
                                                FStar_Tactics_Basic.apply_lemma
                                                FStar_Reflection_Embeddings.e_term
                                                FStar_Syntax_Embeddings.e_unit
                                               in
                                            let uu____2702 =
                                              let uu____2705 =
                                                let uu____2706 =
                                                  e_tactic_0'
                                                    FStar_Syntax_Embeddings.e_any
                                                   in
                                                let uu____2711 =
                                                  e_tactic_0'
                                                    FStar_Syntax_Embeddings.e_any
                                                   in
                                                let uu____2716 =
                                                  FStar_Syntax_Embeddings.e_tuple2
                                                    FStar_Syntax_Embeddings.e_any
                                                    FStar_Syntax_Embeddings.e_any
                                                   in
                                                mktac5 "__divide"
                                                  (fun uu____2733  ->
                                                     fun uu____2734  ->
                                                       FStar_Tactics_Basic.divide)
                                                  FStar_Syntax_Embeddings.e_any
                                                  FStar_Syntax_Embeddings.e_any
                                                  FStar_Syntax_Embeddings.e_int
                                                  uu____2706 uu____2711
                                                  uu____2716
                                                 in
                                              let uu____2735 =
                                                let uu____2738 =
                                                  let uu____2739 =
                                                    e_tactic_0'
                                                      FStar_Syntax_Embeddings.e_unit
                                                     in
                                                  let uu____2744 =
                                                    e_tactic_0'
                                                      FStar_Syntax_Embeddings.e_unit
                                                     in
                                                  mktac2 "__seq"
                                                    FStar_Tactics_Basic.seq
                                                    uu____2739 uu____2744
                                                    FStar_Syntax_Embeddings.e_unit
                                                   in
                                                let uu____2753 =
                                                  let uu____2756 =
                                                    mktac1 "set_options"
                                                      FStar_Tactics_Basic.set_options
                                                      FStar_Syntax_Embeddings.e_string
                                                      FStar_Syntax_Embeddings.e_unit
                                                     in
                                                  let uu____2757 =
                                                    let uu____2760 =
                                                      mktac1 "tc"
                                                        FStar_Tactics_Basic.tc
                                                        FStar_Reflection_Embeddings.e_term
                                                        FStar_Reflection_Embeddings.e_term
                                                       in
                                                    let uu____2761 =
                                                      let uu____2764 =
                                                        mktac1 "unshelve"
                                                          FStar_Tactics_Basic.unshelve
                                                          FStar_Reflection_Embeddings.e_term
                                                          FStar_Syntax_Embeddings.e_unit
                                                         in
                                                      let uu____2765 =
                                                        let uu____2768 =
                                                          mktac2 "unquote"
                                                            FStar_Tactics_Basic.unquote
                                                            FStar_Syntax_Embeddings.e_any
                                                            FStar_Reflection_Embeddings.e_term
                                                            FStar_Syntax_Embeddings.e_any
                                                           in
                                                        let uu____2769 =
                                                          let uu____2772 =
                                                            mktac1 "prune"
                                                              FStar_Tactics_Basic.prune
                                                              FStar_Syntax_Embeddings.e_string
                                                              FStar_Syntax_Embeddings.e_unit
                                                             in
                                                          let uu____2773 =
                                                            let uu____2776 =
                                                              mktac1 "addns"
                                                                FStar_Tactics_Basic.addns
                                                                FStar_Syntax_Embeddings.e_string
                                                                FStar_Syntax_Embeddings.e_unit
                                                               in
                                                            let uu____2777 =
                                                              let uu____2780
                                                                =
                                                                mktac1
                                                                  "print"
                                                                  FStar_Tactics_Basic.print
                                                                  FStar_Syntax_Embeddings.e_string
                                                                  FStar_Syntax_Embeddings.e_unit
                                                                 in
                                                              let uu____2781
                                                                =
                                                                let uu____2784
                                                                  =
                                                                  mktac1
                                                                    "debug"
                                                                    FStar_Tactics_Basic.debug
                                                                    FStar_Syntax_Embeddings.e_string
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                   in
                                                                let uu____2785
                                                                  =
                                                                  let uu____2788
                                                                    =
                                                                    mktac1
                                                                    "dump"
                                                                    FStar_Tactics_Basic.print_proof_state
                                                                    FStar_Syntax_Embeddings.e_string
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                  let uu____2789
                                                                    =
                                                                    let uu____2792
                                                                    =
                                                                    mktac1
                                                                    "dump1"
                                                                    FStar_Tactics_Basic.print_proof_state1
                                                                    FStar_Syntax_Embeddings.e_string
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2793
                                                                    =
                                                                    let uu____2796
                                                                    =
                                                                    let uu____2797
                                                                    =
                                                                    e_tactic_0'
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    mktac2
                                                                    "__pointwise"
                                                                    FStar_Tactics_Basic.pointwise
                                                                    FStar_Tactics_Embedding.e_direction
                                                                    uu____2797
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2804
                                                                    =
                                                                    let uu____2807
                                                                    =
                                                                    let uu____2808
                                                                    =
                                                                    let uu____2820
                                                                    =
                                                                    FStar_Syntax_Embeddings.e_tuple2
                                                                    FStar_Syntax_Embeddings.e_bool
                                                                    FStar_Syntax_Embeddings.e_int
                                                                     in
                                                                    e_tactic_1
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    uu____2820
                                                                     in
                                                                    let uu____2831
                                                                    =
                                                                    e_tactic_0'
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    mktac2
                                                                    "__topdown_rewrite"
                                                                    FStar_Tactics_Basic.topdown_rewrite
                                                                    uu____2808
                                                                    uu____2831
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2847
                                                                    =
                                                                    let uu____2850
                                                                    =
                                                                    mktac1
                                                                    "trefl"
                                                                    FStar_Tactics_Basic.trefl
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2851
                                                                    =
                                                                    let uu____2854
                                                                    =
                                                                    mktac1
                                                                    "later"
                                                                    FStar_Tactics_Basic.later
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2855
                                                                    =
                                                                    let uu____2858
                                                                    =
                                                                    mktac1
                                                                    "dup"
                                                                    FStar_Tactics_Basic.dup
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2859
                                                                    =
                                                                    let uu____2862
                                                                    =
                                                                    mktac1
                                                                    "flip"
                                                                    FStar_Tactics_Basic.flip
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2863
                                                                    =
                                                                    let uu____2866
                                                                    =
                                                                    mktac1
                                                                    "qed"
                                                                    FStar_Tactics_Basic.qed
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2867
                                                                    =
                                                                    let uu____2870
                                                                    =
                                                                    mktac1
                                                                    "dismiss"
                                                                    FStar_Tactics_Basic.dismiss
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2871
                                                                    =
                                                                    let uu____2874
                                                                    =
                                                                    mktac1
                                                                    "tadmit"
                                                                    FStar_Tactics_Basic.tadmit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2875
                                                                    =
                                                                    let uu____2878
                                                                    =
                                                                    let uu____2879
                                                                    =
                                                                    FStar_Syntax_Embeddings.e_tuple2
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    FStar_Reflection_Embeddings.e_term
                                                                     in
                                                                    mktac1
                                                                    "cases"
                                                                    FStar_Tactics_Basic.cases
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    uu____2879
                                                                     in
                                                                    let uu____2890
                                                                    =
                                                                    let uu____2893
                                                                    =
                                                                    mktac1
                                                                    "top_env"
                                                                    FStar_Tactics_Basic.top_env
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Reflection_Embeddings.e_env
                                                                     in
                                                                    let uu____2894
                                                                    =
                                                                    let uu____2897
                                                                    =
                                                                    mktac1
                                                                    "cur_env"
                                                                    FStar_Tactics_Basic.cur_env
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Reflection_Embeddings.e_env
                                                                     in
                                                                    let uu____2898
                                                                    =
                                                                    let uu____2901
                                                                    =
                                                                    mktac1
                                                                    "cur_goal"
                                                                    FStar_Tactics_Basic.cur_goal'
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Reflection_Embeddings.e_term
                                                                     in
                                                                    let uu____2902
                                                                    =
                                                                    let uu____2905
                                                                    =
                                                                    mktac1
                                                                    "cur_witness"
                                                                    FStar_Tactics_Basic.cur_witness
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Reflection_Embeddings.e_term
                                                                     in
                                                                    let uu____2906
                                                                    =
                                                                    let uu____2909
                                                                    =
                                                                    mktac1
                                                                    "inspect"
                                                                    FStar_Tactics_Basic.inspect
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    FStar_Reflection_Embeddings.e_term_view
                                                                     in
                                                                    let uu____2910
                                                                    =
                                                                    let uu____2913
                                                                    =
                                                                    mktac1
                                                                    "pack"
                                                                    FStar_Tactics_Basic.pack
                                                                    FStar_Reflection_Embeddings.e_term_view
                                                                    FStar_Reflection_Embeddings.e_term
                                                                     in
                                                                    let uu____2914
                                                                    =
                                                                    let uu____2917
                                                                    =
                                                                    mktac1
                                                                    "fresh"
                                                                    FStar_Tactics_Basic.fresh
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_int
                                                                     in
                                                                    let uu____2918
                                                                    =
                                                                    let uu____2921
                                                                    =
                                                                    mktac1
                                                                    "ngoals"
                                                                    FStar_Tactics_Basic.ngoals
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_int
                                                                     in
                                                                    let uu____2922
                                                                    =
                                                                    let uu____2925
                                                                    =
                                                                    mktac1
                                                                    "ngoals_smt"
                                                                    FStar_Tactics_Basic.ngoals_smt
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_int
                                                                     in
                                                                    let uu____2926
                                                                    =
                                                                    let uu____2929
                                                                    =
                                                                    mktac1
                                                                    "is_guard"
                                                                    FStar_Tactics_Basic.is_guard
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Syntax_Embeddings.e_bool
                                                                     in
                                                                    let uu____2930
                                                                    =
                                                                    let uu____2933
                                                                    =
                                                                    let uu____2934
                                                                    =
                                                                    FStar_Syntax_Embeddings.e_option
                                                                    FStar_Reflection_Embeddings.e_term
                                                                     in
                                                                    mktac2
                                                                    "uvar_env"
                                                                    FStar_Tactics_Basic.uvar_env
                                                                    FStar_Reflection_Embeddings.e_env
                                                                    uu____2934
                                                                    FStar_Reflection_Embeddings.e_term
                                                                     in
                                                                    let uu____2941
                                                                    =
                                                                    let uu____2944
                                                                    =
                                                                    mktac2
                                                                    "unify"
                                                                    FStar_Tactics_Basic.unify
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    FStar_Syntax_Embeddings.e_bool
                                                                     in
                                                                    let uu____2945
                                                                    =
                                                                    let uu____2948
                                                                    =
                                                                    let uu____2949
                                                                    =
                                                                    FStar_Syntax_Embeddings.e_list
                                                                    FStar_Syntax_Embeddings.e_string
                                                                     in
                                                                    mktac3
                                                                    "launch_process"
                                                                    FStar_Tactics_Basic.launch_process
                                                                    FStar_Syntax_Embeddings.e_string
                                                                    uu____2949
                                                                    FStar_Syntax_Embeddings.e_string
                                                                    FStar_Syntax_Embeddings.e_string
                                                                     in
                                                                    let uu____2956
                                                                    =
                                                                    let uu____2959
                                                                    =
                                                                    mktac2
                                                                    "fresh_bv_named"
                                                                    FStar_Tactics_Basic.fresh_bv_named
                                                                    FStar_Syntax_Embeddings.e_string
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    FStar_Reflection_Embeddings.e_bv
                                                                     in
                                                                    let uu____2960
                                                                    =
                                                                    let uu____2963
                                                                    =
                                                                    mktac1
                                                                    "change"
                                                                    FStar_Tactics_Basic.change
                                                                    FStar_Reflection_Embeddings.e_term
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    let uu____2964
                                                                    =
                                                                    let uu____2967
                                                                    =
                                                                    mktac1
                                                                    "get_guard_policy"
                                                                    FStar_Tactics_Basic.get_guard_policy
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                    FStar_Tactics_Embedding.e_guard_policy
                                                                     in
                                                                    let uu____2968
                                                                    =
                                                                    let uu____2971
                                                                    =
                                                                    mktac1
                                                                    "set_guard_policy"
                                                                    FStar_Tactics_Basic.set_guard_policy
                                                                    FStar_Tactics_Embedding.e_guard_policy
                                                                    FStar_Syntax_Embeddings.e_unit
                                                                     in
                                                                    [uu____2971;
                                                                    decr_depth_step;
                                                                    incr_depth_step;
                                                                    tracepoint_step;
                                                                    set_proofstate_range_step;
                                                                    push_binder_step]
                                                                     in
                                                                    uu____2967
                                                                    ::
                                                                    uu____2968
                                                                     in
                                                                    uu____2963
                                                                    ::
                                                                    uu____2964
                                                                     in
                                                                    uu____2959
                                                                    ::
                                                                    uu____2960
                                                                     in
                                                                    uu____2948
                                                                    ::
                                                                    uu____2956
                                                                     in
                                                                    uu____2944
                                                                    ::
                                                                    uu____2945
                                                                     in
                                                                    uu____2933
                                                                    ::
                                                                    uu____2941
                                                                     in
                                                                    uu____2929
                                                                    ::
                                                                    uu____2930
                                                                     in
                                                                    uu____2925
                                                                    ::
                                                                    uu____2926
                                                                     in
                                                                    uu____2921
                                                                    ::
                                                                    uu____2922
                                                                     in
                                                                    uu____2917
                                                                    ::
                                                                    uu____2918
                                                                     in
                                                                    uu____2913
                                                                    ::
                                                                    uu____2914
                                                                     in
                                                                    uu____2909
                                                                    ::
                                                                    uu____2910
                                                                     in
                                                                    uu____2905
                                                                    ::
                                                                    uu____2906
                                                                     in
                                                                    uu____2901
                                                                    ::
                                                                    uu____2902
                                                                     in
                                                                    uu____2897
                                                                    ::
                                                                    uu____2898
                                                                     in
                                                                    uu____2893
                                                                    ::
                                                                    uu____2894
                                                                     in
                                                                    uu____2878
                                                                    ::
                                                                    uu____2890
                                                                     in
                                                                    uu____2874
                                                                    ::
                                                                    uu____2875
                                                                     in
                                                                    uu____2870
                                                                    ::
                                                                    uu____2871
                                                                     in
                                                                    uu____2866
                                                                    ::
                                                                    uu____2867
                                                                     in
                                                                    uu____2862
                                                                    ::
                                                                    uu____2863
                                                                     in
                                                                    uu____2858
                                                                    ::
                                                                    uu____2859
                                                                     in
                                                                    uu____2854
                                                                    ::
                                                                    uu____2855
                                                                     in
                                                                    uu____2850
                                                                    ::
                                                                    uu____2851
                                                                     in
                                                                    uu____2807
                                                                    ::
                                                                    uu____2847
                                                                     in
                                                                    uu____2796
                                                                    ::
                                                                    uu____2804
                                                                     in
                                                                    uu____2792
                                                                    ::
                                                                    uu____2793
                                                                     in
                                                                  uu____2788
                                                                    ::
                                                                    uu____2789
                                                                   in
                                                                uu____2784 ::
                                                                  uu____2785
                                                                 in
                                                              uu____2780 ::
                                                                uu____2781
                                                               in
                                                            uu____2776 ::
                                                              uu____2777
                                                             in
                                                          uu____2772 ::
                                                            uu____2773
                                                           in
                                                        uu____2768 ::
                                                          uu____2769
                                                         in
                                                      uu____2764 ::
                                                        uu____2765
                                                       in
                                                    uu____2760 :: uu____2761
                                                     in
                                                  uu____2756 :: uu____2757
                                                   in
                                                uu____2738 :: uu____2753  in
                                              uu____2705 :: uu____2735  in
                                            uu____2701 :: uu____2702  in
                                          uu____2697 :: uu____2698  in
                                        uu____2693 :: uu____2694  in
                                      uu____2689 :: uu____2690  in
                                    uu____2685 :: uu____2686  in
                                  uu____2681 :: uu____2682  in
                                uu____2677 :: uu____2678  in
                              uu____2673 :: uu____2674  in
                            uu____2669 :: uu____2670  in
                          uu____2665 :: uu____2666  in
                        uu____2661 :: uu____2662  in
                      uu____2657 :: uu____2658  in
                    uu____2646 :: uu____2654  in
                  uu____2635 :: uu____2643  in
                uu____2624 :: uu____2632  in
              uu____2609 :: uu____2621  in
            uu____2605 :: uu____2606  in
          uu____2585 :: uu____2602  in
        uu____2581 :: uu____2582  in
      uu____2575 :: uu____2578  in
    FStar_List.append uu____2572
      (FStar_List.append FStar_Reflection_Interpreter.reflection_primops
         native_tactics_steps)

and unembed_tactic_1 :
  'Aa 'Ar .
    'Aa FStar_Syntax_Embeddings.embedding ->
      'Ar FStar_Syntax_Embeddings.embedding ->
        FStar_Syntax_Syntax.term ->
          ('Aa -> 'Ar FStar_Tactics_Basic.tac) FStar_Pervasives_Native.option
  =
  fun ea  ->
    fun er  ->
      fun f  ->
        FStar_Pervasives_Native.Some
          (fun x  ->
             let rng = FStar_Range.dummyRange  in
             let x_tm = FStar_Syntax_Embeddings.embed ea rng x  in
             let app =
               let uu____2994 =
                 let uu____2999 =
                   let uu____3000 = FStar_Syntax_Syntax.as_arg x_tm  in
                   [uu____3000]  in
                 FStar_Syntax_Syntax.mk_Tm_app f uu____2999  in
               uu____2994 FStar_Pervasives_Native.None rng  in
             unembed_tactic_0 er app)

and unembed_tactic_0 :
  'Ab .
    'Ab FStar_Syntax_Embeddings.embedding ->
      FStar_Syntax_Syntax.term -> 'Ab FStar_Tactics_Basic.tac
  =
  fun eb  ->
    fun embedded_tac_b  ->
      FStar_Tactics_Basic.bind FStar_Tactics_Basic.get
        (fun proof_state  ->
           let rng = embedded_tac_b.FStar_Syntax_Syntax.pos  in
           let tm =
             let uu____3041 =
               let uu____3046 =
                 let uu____3047 =
                   let uu____3054 =
                     FStar_Syntax_Embeddings.embed
                       FStar_Tactics_Embedding.e_proofstate rng proof_state
                      in
                   FStar_Syntax_Syntax.as_arg uu____3054  in
                 [uu____3047]  in
               FStar_Syntax_Syntax.mk_Tm_app embedded_tac_b uu____3046  in
             uu____3041 FStar_Pervasives_Native.None rng  in
           let steps =
             [FStar_TypeChecker_Normalize.Weak;
             FStar_TypeChecker_Normalize.Reify;
             FStar_TypeChecker_Normalize.UnfoldUntil
               FStar_Syntax_Syntax.delta_constant;
             FStar_TypeChecker_Normalize.UnfoldTac;
             FStar_TypeChecker_Normalize.Primops;
             FStar_TypeChecker_Normalize.Unascribe]  in
           (let uu____3073 =
              FStar_TypeChecker_Env.debug
                proof_state.FStar_Tactics_Types.main_context
                (FStar_Options.Other "TacVerbose")
               in
            if uu____3073
            then
              let uu____3074 = FStar_Syntax_Print.term_to_string tm  in
              FStar_Util.print1 "Starting normalizer with %s\n" uu____3074
            else ());
           (let result =
              let uu____3077 = primitive_steps ()  in
              FStar_TypeChecker_Normalize.normalize_with_primitive_steps
                uu____3077 steps proof_state.FStar_Tactics_Types.main_context
                tm
               in
            (let uu____3081 =
               FStar_TypeChecker_Env.debug
                 proof_state.FStar_Tactics_Types.main_context
                 (FStar_Options.Other "TacVerbose")
                in
             if uu____3081
             then
               let uu____3082 = FStar_Syntax_Print.term_to_string result  in
               FStar_Util.print1 "Reduced tactic: got %s\n" uu____3082
             else ());
            (let res =
               let uu____3089 = FStar_Tactics_Embedding.e_result eb  in
               FStar_Syntax_Embeddings.unembed uu____3089 result  in
             match res with
             | FStar_Pervasives_Native.Some (FStar_Tactics_Result.Success
                 (b,ps)) ->
                 let uu____3102 = FStar_Tactics_Basic.set ps  in
                 FStar_Tactics_Basic.bind uu____3102
                   (fun uu____3106  -> FStar_Tactics_Basic.ret b)
             | FStar_Pervasives_Native.Some (FStar_Tactics_Result.Failed
                 (msg,ps)) ->
                 let uu____3111 = FStar_Tactics_Basic.set ps  in
                 FStar_Tactics_Basic.bind uu____3111
                   (fun uu____3115  -> FStar_Tactics_Basic.fail msg)
             | FStar_Pervasives_Native.None  ->
                 let uu____3118 =
                   let uu____3123 =
                     let uu____3124 =
                       FStar_Syntax_Print.term_to_string result  in
                     FStar_Util.format1
                       "Tactic got stuck! Please file a bug report with a minimal reproduction of this issue.\n%s"
                       uu____3124
                      in
                   (FStar_Errors.Fatal_TacticGotStuck, uu____3123)  in
                 FStar_Errors.raise_error uu____3118
                   (proof_state.FStar_Tactics_Types.main_context).FStar_TypeChecker_Env.range)))

and unembed_tactic_0' :
  'Ab .
    'Ab FStar_Syntax_Embeddings.embedding ->
      FStar_Syntax_Syntax.term ->
        'Ab FStar_Tactics_Basic.tac FStar_Pervasives_Native.option
  =
  fun eb  ->
    fun embedded_tac_b  ->
      let uu____3131 = unembed_tactic_0 eb embedded_tac_b  in
      FStar_All.pipe_left (fun _0_17  -> FStar_Pervasives_Native.Some _0_17)
        uu____3131

let (report_implicits :
  FStar_Tactics_Types.proofstate -> FStar_TypeChecker_Env.implicits -> unit)
  =
  fun ps  ->
    fun is  ->
      let errs =
        FStar_List.map
          (fun uu____3184  ->
             match uu____3184 with
             | (r,ty,uv,rng,uu____3205) ->
                 let uu____3206 =
                   let uu____3207 =
                     FStar_Syntax_Print.uvar_to_string
                       uv.FStar_Syntax_Syntax.ctx_uvar_head
                      in
                   let uu____3208 = FStar_Syntax_Print.term_to_string ty  in
                   FStar_Util.format3
                     "Tactic left uninstantiated unification variable %s of type %s (reason = \"%s\")"
                     uu____3207 uu____3208 r
                    in
                 (FStar_Errors.Error_UninstantiatedUnificationVarInTactic,
                   uu____3206, rng)) is
         in
      match errs with
      | [] -> ()
      | (e,msg,r)::tl1 ->
          (FStar_Tactics_Basic.dump_proofstate ps
             "failing due to uninstantiated implicits";
           FStar_Errors.add_errors tl1;
           FStar_Errors.raise_error (e, msg) r)
  
let (run_tactic_on_typ :
  FStar_Syntax_Syntax.term ->
    FStar_TypeChecker_Env.env ->
      FStar_Syntax_Syntax.typ ->
        (FStar_Tactics_Basic.goal Prims.list,FStar_Syntax_Syntax.term)
          FStar_Pervasives_Native.tuple2)
  =
  fun tactic  ->
    fun env  ->
      fun typ  ->
        let rng = tactic.FStar_Syntax_Syntax.pos  in
        (let uu____3264 = FStar_ST.op_Bang tacdbg  in
         if uu____3264
         then
           let uu____3288 = FStar_Syntax_Print.term_to_string tactic  in
           FStar_Util.print1 "About to reduce uvars on: %s\n" uu____3288
         else ());
        (let tactic1 =
           FStar_TypeChecker_Normalize.reduce_uvar_solutions env tactic  in
         (let uu____3292 = FStar_ST.op_Bang tacdbg  in
          if uu____3292
          then
            let uu____3316 = FStar_Syntax_Print.term_to_string tactic1  in
            FStar_Util.print1 "About to check tactic term: %s\n" uu____3316
          else ());
         (let uu____3318 =
            FStar_TypeChecker_TcTerm.tc_reified_tactic env tactic1  in
          match uu____3318 with
          | (uu____3331,uu____3332,g) ->
              (FStar_TypeChecker_Rel.force_trivial_guard env g;
               FStar_Errors.stop_if_err ();
               (let tau =
                  unembed_tactic_0 FStar_Syntax_Embeddings.e_unit tactic1  in
                let uu____3339 = FStar_TypeChecker_Env.clear_expected_typ env
                   in
                match uu____3339 with
                | (env1,uu____3353) ->
                    let env2 =
                      let uu___84_3359 = env1  in
                      {
                        FStar_TypeChecker_Env.solver =
                          (uu___84_3359.FStar_TypeChecker_Env.solver);
                        FStar_TypeChecker_Env.range =
                          (uu___84_3359.FStar_TypeChecker_Env.range);
                        FStar_TypeChecker_Env.curmodule =
                          (uu___84_3359.FStar_TypeChecker_Env.curmodule);
                        FStar_TypeChecker_Env.gamma =
                          (uu___84_3359.FStar_TypeChecker_Env.gamma);
                        FStar_TypeChecker_Env.gamma_sig =
                          (uu___84_3359.FStar_TypeChecker_Env.gamma_sig);
                        FStar_TypeChecker_Env.gamma_cache =
                          (uu___84_3359.FStar_TypeChecker_Env.gamma_cache);
                        FStar_TypeChecker_Env.modules =
                          (uu___84_3359.FStar_TypeChecker_Env.modules);
                        FStar_TypeChecker_Env.expected_typ =
                          (uu___84_3359.FStar_TypeChecker_Env.expected_typ);
                        FStar_TypeChecker_Env.sigtab =
                          (uu___84_3359.FStar_TypeChecker_Env.sigtab);
                        FStar_TypeChecker_Env.is_pattern =
                          (uu___84_3359.FStar_TypeChecker_Env.is_pattern);
                        FStar_TypeChecker_Env.instantiate_imp = false;
                        FStar_TypeChecker_Env.effects =
                          (uu___84_3359.FStar_TypeChecker_Env.effects);
                        FStar_TypeChecker_Env.generalize =
                          (uu___84_3359.FStar_TypeChecker_Env.generalize);
                        FStar_TypeChecker_Env.letrecs =
                          (uu___84_3359.FStar_TypeChecker_Env.letrecs);
                        FStar_TypeChecker_Env.top_level =
                          (uu___84_3359.FStar_TypeChecker_Env.top_level);
                        FStar_TypeChecker_Env.check_uvars =
                          (uu___84_3359.FStar_TypeChecker_Env.check_uvars);
                        FStar_TypeChecker_Env.use_eq =
                          (uu___84_3359.FStar_TypeChecker_Env.use_eq);
                        FStar_TypeChecker_Env.is_iface =
                          (uu___84_3359.FStar_TypeChecker_Env.is_iface);
                        FStar_TypeChecker_Env.admit =
                          (uu___84_3359.FStar_TypeChecker_Env.admit);
                        FStar_TypeChecker_Env.lax =
                          (uu___84_3359.FStar_TypeChecker_Env.lax);
                        FStar_TypeChecker_Env.lax_universes =
                          (uu___84_3359.FStar_TypeChecker_Env.lax_universes);
                        FStar_TypeChecker_Env.failhard =
                          (uu___84_3359.FStar_TypeChecker_Env.failhard);
                        FStar_TypeChecker_Env.nosynth =
                          (uu___84_3359.FStar_TypeChecker_Env.nosynth);
                        FStar_TypeChecker_Env.tc_term =
                          (uu___84_3359.FStar_TypeChecker_Env.tc_term);
                        FStar_TypeChecker_Env.type_of =
                          (uu___84_3359.FStar_TypeChecker_Env.type_of);
                        FStar_TypeChecker_Env.universe_of =
                          (uu___84_3359.FStar_TypeChecker_Env.universe_of);
                        FStar_TypeChecker_Env.check_type_of =
                          (uu___84_3359.FStar_TypeChecker_Env.check_type_of);
                        FStar_TypeChecker_Env.use_bv_sorts =
                          (uu___84_3359.FStar_TypeChecker_Env.use_bv_sorts);
                        FStar_TypeChecker_Env.qtbl_name_and_index =
                          (uu___84_3359.FStar_TypeChecker_Env.qtbl_name_and_index);
                        FStar_TypeChecker_Env.normalized_eff_names =
                          (uu___84_3359.FStar_TypeChecker_Env.normalized_eff_names);
                        FStar_TypeChecker_Env.proof_ns =
                          (uu___84_3359.FStar_TypeChecker_Env.proof_ns);
                        FStar_TypeChecker_Env.synth_hook =
                          (uu___84_3359.FStar_TypeChecker_Env.synth_hook);
                        FStar_TypeChecker_Env.splice =
                          (uu___84_3359.FStar_TypeChecker_Env.splice);
                        FStar_TypeChecker_Env.is_native_tactic =
                          (uu___84_3359.FStar_TypeChecker_Env.is_native_tactic);
                        FStar_TypeChecker_Env.identifier_info =
                          (uu___84_3359.FStar_TypeChecker_Env.identifier_info);
                        FStar_TypeChecker_Env.tc_hooks =
                          (uu___84_3359.FStar_TypeChecker_Env.tc_hooks);
                        FStar_TypeChecker_Env.dsenv =
                          (uu___84_3359.FStar_TypeChecker_Env.dsenv);
                        FStar_TypeChecker_Env.dep_graph =
                          (uu___84_3359.FStar_TypeChecker_Env.dep_graph)
                      }  in
                    let env3 =
                      let uu___85_3361 = env2  in
                      {
                        FStar_TypeChecker_Env.solver =
                          (uu___85_3361.FStar_TypeChecker_Env.solver);
                        FStar_TypeChecker_Env.range =
                          (uu___85_3361.FStar_TypeChecker_Env.range);
                        FStar_TypeChecker_Env.curmodule =
                          (uu___85_3361.FStar_TypeChecker_Env.curmodule);
                        FStar_TypeChecker_Env.gamma =
                          (uu___85_3361.FStar_TypeChecker_Env.gamma);
                        FStar_TypeChecker_Env.gamma_sig =
                          (uu___85_3361.FStar_TypeChecker_Env.gamma_sig);
                        FStar_TypeChecker_Env.gamma_cache =
                          (uu___85_3361.FStar_TypeChecker_Env.gamma_cache);
                        FStar_TypeChecker_Env.modules =
                          (uu___85_3361.FStar_TypeChecker_Env.modules);
                        FStar_TypeChecker_Env.expected_typ =
                          (uu___85_3361.FStar_TypeChecker_Env.expected_typ);
                        FStar_TypeChecker_Env.sigtab =
                          (uu___85_3361.FStar_TypeChecker_Env.sigtab);
                        FStar_TypeChecker_Env.is_pattern =
                          (uu___85_3361.FStar_TypeChecker_Env.is_pattern);
                        FStar_TypeChecker_Env.instantiate_imp =
                          (uu___85_3361.FStar_TypeChecker_Env.instantiate_imp);
                        FStar_TypeChecker_Env.effects =
                          (uu___85_3361.FStar_TypeChecker_Env.effects);
                        FStar_TypeChecker_Env.generalize =
                          (uu___85_3361.FStar_TypeChecker_Env.generalize);
                        FStar_TypeChecker_Env.letrecs =
                          (uu___85_3361.FStar_TypeChecker_Env.letrecs);
                        FStar_TypeChecker_Env.top_level =
                          (uu___85_3361.FStar_TypeChecker_Env.top_level);
                        FStar_TypeChecker_Env.check_uvars =
                          (uu___85_3361.FStar_TypeChecker_Env.check_uvars);
                        FStar_TypeChecker_Env.use_eq =
                          (uu___85_3361.FStar_TypeChecker_Env.use_eq);
                        FStar_TypeChecker_Env.is_iface =
                          (uu___85_3361.FStar_TypeChecker_Env.is_iface);
                        FStar_TypeChecker_Env.admit =
                          (uu___85_3361.FStar_TypeChecker_Env.admit);
                        FStar_TypeChecker_Env.lax =
                          (uu___85_3361.FStar_TypeChecker_Env.lax);
                        FStar_TypeChecker_Env.lax_universes = true;
                        FStar_TypeChecker_Env.failhard =
                          (uu___85_3361.FStar_TypeChecker_Env.failhard);
                        FStar_TypeChecker_Env.nosynth =
                          (uu___85_3361.FStar_TypeChecker_Env.nosynth);
                        FStar_TypeChecker_Env.tc_term =
                          (uu___85_3361.FStar_TypeChecker_Env.tc_term);
                        FStar_TypeChecker_Env.type_of =
                          (uu___85_3361.FStar_TypeChecker_Env.type_of);
                        FStar_TypeChecker_Env.universe_of =
                          (uu___85_3361.FStar_TypeChecker_Env.universe_of);
                        FStar_TypeChecker_Env.check_type_of =
                          (uu___85_3361.FStar_TypeChecker_Env.check_type_of);
                        FStar_TypeChecker_Env.use_bv_sorts =
                          (uu___85_3361.FStar_TypeChecker_Env.use_bv_sorts);
                        FStar_TypeChecker_Env.qtbl_name_and_index =
                          (uu___85_3361.FStar_TypeChecker_Env.qtbl_name_and_index);
                        FStar_TypeChecker_Env.normalized_eff_names =
                          (uu___85_3361.FStar_TypeChecker_Env.normalized_eff_names);
                        FStar_TypeChecker_Env.proof_ns =
                          (uu___85_3361.FStar_TypeChecker_Env.proof_ns);
                        FStar_TypeChecker_Env.synth_hook =
                          (uu___85_3361.FStar_TypeChecker_Env.synth_hook);
                        FStar_TypeChecker_Env.splice =
                          (uu___85_3361.FStar_TypeChecker_Env.splice);
                        FStar_TypeChecker_Env.is_native_tactic =
                          (uu___85_3361.FStar_TypeChecker_Env.is_native_tactic);
                        FStar_TypeChecker_Env.identifier_info =
                          (uu___85_3361.FStar_TypeChecker_Env.identifier_info);
                        FStar_TypeChecker_Env.tc_hooks =
                          (uu___85_3361.FStar_TypeChecker_Env.tc_hooks);
                        FStar_TypeChecker_Env.dsenv =
                          (uu___85_3361.FStar_TypeChecker_Env.dsenv);
                        FStar_TypeChecker_Env.dep_graph =
                          (uu___85_3361.FStar_TypeChecker_Env.dep_graph)
                      }  in
                    let uu____3362 =
                      FStar_Tactics_Basic.proofstate_of_goal_ty rng env3 typ
                       in
                    (match uu____3362 with
                     | (ps,w) ->
                         ((let uu____3376 = FStar_ST.op_Bang tacdbg  in
                           if uu____3376
                           then
                             let uu____3400 =
                               FStar_Syntax_Print.term_to_string typ  in
                             FStar_Util.print1
                               "Running tactic with goal = %s\n" uu____3400
                           else ());
                          (let uu____3402 =
                             FStar_Util.record_time
                               (fun uu____3412  ->
                                  FStar_Tactics_Basic.run tau ps)
                              in
                           match uu____3402 with
                           | (res,ms) ->
                               ((let uu____3426 = FStar_ST.op_Bang tacdbg  in
                                 if uu____3426
                                 then
                                   let uu____3450 =
                                     FStar_Syntax_Print.term_to_string
                                       tactic1
                                      in
                                   let uu____3451 =
                                     FStar_Util.string_of_int ms  in
                                   let uu____3452 =
                                     FStar_Syntax_Print.lid_to_string
                                       env3.FStar_TypeChecker_Env.curmodule
                                      in
                                   FStar_Util.print3
                                     "Tactic %s ran in %s ms (%s)\n"
                                     uu____3450 uu____3451 uu____3452
                                 else ());
                                (match res with
                                 | FStar_Tactics_Result.Success
                                     (uu____3460,ps1) ->
                                     ((let uu____3463 =
                                         FStar_ST.op_Bang tacdbg  in
                                       if uu____3463
                                       then
                                         let uu____3487 =
                                           FStar_Syntax_Print.term_to_string
                                             w
                                            in
                                         FStar_Util.print1
                                           "Tactic generated proofterm %s\n"
                                           uu____3487
                                       else ());
                                      FStar_List.iter
                                        (fun g1  ->
                                           let uu____3494 =
                                             FStar_Tactics_Basic.is_irrelevant
                                               g1
                                              in
                                           if uu____3494
                                           then
                                             let uu____3495 =
                                               let uu____3496 =
                                                 FStar_Tactics_Types.goal_env
                                                   g1
                                                  in
                                               let uu____3497 =
                                                 FStar_Tactics_Types.goal_witness
                                                   g1
                                                  in
                                               FStar_TypeChecker_Rel.teq_nosmt
                                                 uu____3496 uu____3497
                                                 FStar_Syntax_Util.exp_unit
                                                in
                                             (if uu____3495
                                              then ()
                                              else
                                                (let uu____3499 =
                                                   let uu____3500 =
                                                     let uu____3501 =
                                                       FStar_Tactics_Types.goal_witness
                                                         g1
                                                        in
                                                     FStar_Syntax_Print.term_to_string
                                                       uu____3501
                                                      in
                                                   FStar_Util.format1
                                                     "Irrelevant tactic witness does not unify with (): %s"
                                                     uu____3500
                                                    in
                                                 failwith uu____3499))
                                           else ())
                                        (FStar_List.append
                                           ps1.FStar_Tactics_Types.goals
                                           ps1.FStar_Tactics_Types.smt_goals);
                                      (let g1 =
                                         let uu___86_3504 =
                                           FStar_TypeChecker_Rel.trivial_guard
                                            in
                                         {
                                           FStar_TypeChecker_Env.guard_f =
                                             (uu___86_3504.FStar_TypeChecker_Env.guard_f);
                                           FStar_TypeChecker_Env.deferred =
                                             (uu___86_3504.FStar_TypeChecker_Env.deferred);
                                           FStar_TypeChecker_Env.univ_ineqs =
                                             (uu___86_3504.FStar_TypeChecker_Env.univ_ineqs);
                                           FStar_TypeChecker_Env.implicits =
                                             (ps1.FStar_Tactics_Types.all_implicits)
                                         }  in
                                       let g2 =
                                         let uu____3506 =
                                           FStar_TypeChecker_Rel.solve_deferred_constraints
                                             env3 g1
                                            in
                                         FStar_All.pipe_right uu____3506
                                           (FStar_TypeChecker_Rel.resolve_implicits_tac
                                              env3)
                                          in
                                       report_implicits ps1
                                         g2.FStar_TypeChecker_Env.implicits;
                                       ((FStar_List.append
                                           ps1.FStar_Tactics_Types.goals
                                           ps1.FStar_Tactics_Types.smt_goals),
                                         w)))
                                 | FStar_Tactics_Result.Failed (s,ps1) ->
                                     ((let uu____3513 =
                                         let uu____3514 =
                                           FStar_TypeChecker_Normalize.psc_subst
                                             ps1.FStar_Tactics_Types.psc
                                            in
                                         FStar_Tactics_Types.subst_proof_state
                                           uu____3514 ps1
                                          in
                                       FStar_Tactics_Basic.dump_proofstate
                                         uu____3513 "at the time of failure");
                                      (let uu____3515 =
                                         let uu____3520 =
                                           FStar_Util.format1
                                             "user tactic failed: %s" s
                                            in
                                         (FStar_Errors.Fatal_UserTacticFailure,
                                           uu____3520)
                                          in
                                       FStar_Errors.raise_error uu____3515
                                         ps1.FStar_Tactics_Types.entry_range)))))))))))
  
type pol =
  | Pos 
  | Neg 
  | Both 
let (uu___is_Pos : pol -> Prims.bool) =
  fun projectee  -> match projectee with | Pos  -> true | uu____3532 -> false 
let (uu___is_Neg : pol -> Prims.bool) =
  fun projectee  -> match projectee with | Neg  -> true | uu____3538 -> false 
let (uu___is_Both : pol -> Prims.bool) =
  fun projectee  ->
    match projectee with | Both  -> true | uu____3544 -> false
  
type 'a tres_m =
  | Unchanged of 'a 
  | Simplified of ('a,FStar_Tactics_Basic.goal Prims.list)
  FStar_Pervasives_Native.tuple2 
  | Dual of ('a,'a,FStar_Tactics_Basic.goal Prims.list)
  FStar_Pervasives_Native.tuple3 
let uu___is_Unchanged : 'a . 'a tres_m -> Prims.bool =
  fun projectee  ->
    match projectee with | Unchanged _0 -> true | uu____3599 -> false
  
let __proj__Unchanged__item___0 : 'a . 'a tres_m -> 'a =
  fun projectee  -> match projectee with | Unchanged _0 -> _0 
let uu___is_Simplified : 'a . 'a tres_m -> Prims.bool =
  fun projectee  ->
    match projectee with | Simplified _0 -> true | uu____3639 -> false
  
let __proj__Simplified__item___0 :
  'a .
    'a tres_m ->
      ('a,FStar_Tactics_Basic.goal Prims.list) FStar_Pervasives_Native.tuple2
  = fun projectee  -> match projectee with | Simplified _0 -> _0 
let uu___is_Dual : 'a . 'a tres_m -> Prims.bool =
  fun projectee  ->
    match projectee with | Dual _0 -> true | uu____3693 -> false
  
let __proj__Dual__item___0 :
  'a .
    'a tres_m ->
      ('a,'a,FStar_Tactics_Basic.goal Prims.list)
        FStar_Pervasives_Native.tuple3
  = fun projectee  -> match projectee with | Dual _0 -> _0 
type tres = FStar_Syntax_Syntax.term tres_m
let tpure : 'Auu____3734 . 'Auu____3734 -> 'Auu____3734 tres_m =
  fun x  -> Unchanged x 
let (flip : pol -> pol) =
  fun p  -> match p with | Pos  -> Neg | Neg  -> Pos | Both  -> Both 
let (by_tactic_interp :
  pol -> FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> tres) =
  fun pol  ->
    fun e  ->
      fun t  ->
        let uu____3762 = FStar_Syntax_Util.head_and_args t  in
        match uu____3762 with
        | (hd1,args) ->
            let uu____3799 =
              let uu____3814 =
                let uu____3815 = FStar_Syntax_Util.un_uinst hd1  in
                uu____3815.FStar_Syntax_Syntax.n  in
              (uu____3814, args)  in
            (match uu____3799 with
             | (FStar_Syntax_Syntax.Tm_fvar
                fv,(rett,FStar_Pervasives_Native.Some
                    (FStar_Syntax_Syntax.Implicit uu____3830))::(tactic,FStar_Pervasives_Native.None
                                                                 )::(assertion,FStar_Pervasives_Native.None
                                                                    )::[])
                 when
                 FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.by_tactic_lid
                 ->
                 (match pol with
                  | Pos  ->
                      let uu____3893 = run_tactic_on_typ tactic e assertion
                         in
                      (match uu____3893 with
                       | (gs,uu____3901) ->
                           Simplified (FStar_Syntax_Util.t_true, gs))
                  | Both  ->
                      let uu____3908 = run_tactic_on_typ tactic e assertion
                         in
                      (match uu____3908 with
                       | (gs,uu____3916) ->
                           Dual (assertion, FStar_Syntax_Util.t_true, gs))
                  | Neg  -> Simplified (assertion, []))
             | (FStar_Syntax_Syntax.Tm_fvar
                fv,(assertion,FStar_Pervasives_Native.None )::[]) when
                 FStar_Syntax_Syntax.fv_eq_lid fv
                   FStar_Parser_Const.spinoff_lid
                 ->
                 (match pol with
                  | Pos  ->
                      let uu____3959 =
                        let uu____3966 =
                          let uu____3969 =
                            let uu____3970 =
                              FStar_Tactics_Basic.goal_of_goal_ty e assertion
                               in
                            FStar_All.pipe_left FStar_Pervasives_Native.fst
                              uu____3970
                             in
                          [uu____3969]  in
                        (FStar_Syntax_Util.t_true, uu____3966)  in
                      Simplified uu____3959
                  | Both  ->
                      let uu____3981 =
                        let uu____3990 =
                          let uu____3993 =
                            let uu____3994 =
                              FStar_Tactics_Basic.goal_of_goal_ty e assertion
                               in
                            FStar_All.pipe_left FStar_Pervasives_Native.fst
                              uu____3994
                             in
                          [uu____3993]  in
                        (assertion, FStar_Syntax_Util.t_true, uu____3990)  in
                      Dual uu____3981
                  | Neg  -> Simplified (assertion, []))
             | uu____4007 -> Unchanged t)
  
let explode :
  'a .
    'a tres_m ->
      ('a,'a,FStar_Tactics_Basic.goal Prims.list)
        FStar_Pervasives_Native.tuple3
  =
  fun t  ->
    match t with
    | Unchanged t1 -> (t1, t1, [])
    | Simplified (t1,gs) -> (t1, t1, gs)
    | Dual (tn,tp,gs) -> (tn, tp, gs)
  
let comb1 : 'a 'b . ('a -> 'b) -> 'a tres_m -> 'b tres_m =
  fun f  ->
    fun uu___83_4097  ->
      match uu___83_4097 with
      | Unchanged t -> let uu____4103 = f t  in Unchanged uu____4103
      | Simplified (t,gs) ->
          let uu____4110 = let uu____4117 = f t  in (uu____4117, gs)  in
          Simplified uu____4110
      | Dual (tn,tp,gs) ->
          let uu____4127 =
            let uu____4136 = f tn  in
            let uu____4137 = f tp  in (uu____4136, uu____4137, gs)  in
          Dual uu____4127
  
let comb2 :
  'a 'b 'c . ('a -> 'b -> 'c) -> 'a tres_m -> 'b tres_m -> 'c tres_m =
  fun f  ->
    fun x  ->
      fun y  ->
        match (x, y) with
        | (Unchanged t1,Unchanged t2) ->
            let uu____4200 = f t1 t2  in Unchanged uu____4200
        | (Unchanged t1,Simplified (t2,gs)) ->
            let uu____4212 = let uu____4219 = f t1 t2  in (uu____4219, gs)
               in
            Simplified uu____4212
        | (Simplified (t1,gs),Unchanged t2) ->
            let uu____4233 = let uu____4240 = f t1 t2  in (uu____4240, gs)
               in
            Simplified uu____4233
        | (Simplified (t1,gs1),Simplified (t2,gs2)) ->
            let uu____4259 =
              let uu____4266 = f t1 t2  in
              (uu____4266, (FStar_List.append gs1 gs2))  in
            Simplified uu____4259
        | uu____4269 ->
            let uu____4278 = explode x  in
            (match uu____4278 with
             | (n1,p1,gs1) ->
                 let uu____4296 = explode y  in
                 (match uu____4296 with
                  | (n2,p2,gs2) ->
                      let uu____4314 =
                        let uu____4323 = f n1 n2  in
                        let uu____4324 = f p1 p2  in
                        (uu____4323, uu____4324, (FStar_List.append gs1 gs2))
                         in
                      Dual uu____4314))
  
let comb_list : 'a . 'a tres_m Prims.list -> 'a Prims.list tres_m =
  fun rs  ->
    let rec aux rs1 acc =
      match rs1 with
      | [] -> acc
      | hd1::tl1 ->
          let uu____4396 = comb2 (fun l  -> fun r  -> l :: r) hd1 acc  in
          aux tl1 uu____4396
       in
    aux (FStar_List.rev rs) (tpure [])
  
let emit : 'a . FStar_Tactics_Basic.goal Prims.list -> 'a tres_m -> 'a tres_m
  =
  fun gs  ->
    fun m  -> comb2 (fun uu____4444  -> fun x  -> x) (Simplified ((), gs)) m
  
let rec (traverse :
  (pol -> FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> tres) ->
    pol -> FStar_TypeChecker_Env.env -> FStar_Syntax_Syntax.term -> tres)
  =
  fun f  ->
    fun pol  ->
      fun e  ->
        fun t  ->
          let r =
            let uu____4486 =
              let uu____4487 = FStar_Syntax_Subst.compress t  in
              uu____4487.FStar_Syntax_Syntax.n  in
            match uu____4486 with
            | FStar_Syntax_Syntax.Tm_uinst (t1,us) ->
                let tr = traverse f pol e t1  in
                let uu____4499 =
                  comb1 (fun t'  -> FStar_Syntax_Syntax.Tm_uinst (t', us))
                   in
                uu____4499 tr
            | FStar_Syntax_Syntax.Tm_meta (t1,m) ->
                let tr = traverse f pol e t1  in
                let uu____4525 =
                  comb1 (fun t'  -> FStar_Syntax_Syntax.Tm_meta (t', m))  in
                uu____4525 tr
            | FStar_Syntax_Syntax.Tm_app
                ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
                   FStar_Syntax_Syntax.pos = uu____4545;
                   FStar_Syntax_Syntax.vars = uu____4546;_},(p,uu____4548)::
                 (q,uu____4550)::[])
                when
                FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.imp_lid
                ->
                let x =
                  let uu____4590 =
                    FStar_Syntax_Util.mk_squash FStar_Syntax_Syntax.U_zero p
                     in
                  FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                    uu____4590
                   in
                let r1 = traverse f (flip pol) e p  in
                let r2 =
                  let uu____4593 = FStar_TypeChecker_Env.push_bv e x  in
                  traverse f pol uu____4593 q  in
                comb2
                  (fun l  ->
                     fun r  ->
                       let uu____4607 = FStar_Syntax_Util.mk_imp l r  in
                       uu____4607.FStar_Syntax_Syntax.n) r1 r2
            | FStar_Syntax_Syntax.Tm_app
                ({ FStar_Syntax_Syntax.n = FStar_Syntax_Syntax.Tm_fvar fv;
                   FStar_Syntax_Syntax.pos = uu____4611;
                   FStar_Syntax_Syntax.vars = uu____4612;_},(p,uu____4614)::
                 (q,uu____4616)::[])
                when
                FStar_Syntax_Syntax.fv_eq_lid fv FStar_Parser_Const.iff_lid
                ->
                let xp =
                  let uu____4656 =
                    FStar_Syntax_Util.mk_squash FStar_Syntax_Syntax.U_zero p
                     in
                  FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                    uu____4656
                   in
                let xq =
                  let uu____4658 =
                    FStar_Syntax_Util.mk_squash FStar_Syntax_Syntax.U_zero q
                     in
                  FStar_Syntax_Syntax.new_bv FStar_Pervasives_Native.None
                    uu____4658
                   in
                let r1 =
                  let uu____4660 = FStar_TypeChecker_Env.push_bv e xq  in
                  traverse f Both uu____4660 p  in
                let r2 =
                  let uu____4662 = FStar_TypeChecker_Env.push_bv e xp  in
                  traverse f Both uu____4662 q  in
                (match (r1, r2) with
                 | (Unchanged uu____4669,Unchanged uu____4670) ->
                     comb2
                       (fun l  ->
                          fun r  ->
                            let uu____4688 = FStar_Syntax_Util.mk_iff l r  in
                            uu____4688.FStar_Syntax_Syntax.n) r1 r2
                 | uu____4691 ->
                     let uu____4700 = explode r1  in
                     (match uu____4700 with
                      | (pn,pp,gs1) ->
                          let uu____4718 = explode r2  in
                          (match uu____4718 with
                           | (qn,qp,gs2) ->
                               let t1 =
                                 let uu____4739 =
                                   FStar_Syntax_Util.mk_imp pn qp  in
                                 let uu____4742 =
                                   FStar_Syntax_Util.mk_imp qn pp  in
                                 FStar_Syntax_Util.mk_conj uu____4739
                                   uu____4742
                                  in
                               Simplified
                                 ((t1.FStar_Syntax_Syntax.n),
                                   (FStar_List.append gs1 gs2)))))
            | FStar_Syntax_Syntax.Tm_app (hd1,args) ->
                let r0 = traverse f pol e hd1  in
                let r1 =
                  FStar_List.fold_right
                    (fun uu____4796  ->
                       fun r  ->
                         match uu____4796 with
                         | (a,q) ->
                             let r' = traverse f pol e a  in
                             comb2
                               (fun a1  -> fun args1  -> (a1, q) :: args1) r'
                               r) args (tpure [])
                   in
                comb2
                  (fun hd2  ->
                     fun args1  -> FStar_Syntax_Syntax.Tm_app (hd2, args1))
                  r0 r1
            | FStar_Syntax_Syntax.Tm_abs (bs,t1,k) ->
                let uu____4914 = FStar_Syntax_Subst.open_term bs t1  in
                (match uu____4914 with
                 | (bs1,topen) ->
                     let e' = FStar_TypeChecker_Env.push_binders e bs1  in
                     let r0 =
                       FStar_List.map
                         (fun uu____4948  ->
                            match uu____4948 with
                            | (bv,aq) ->
                                let r =
                                  traverse f (flip pol) e
                                    bv.FStar_Syntax_Syntax.sort
                                   in
                                let uu____4962 =
                                  comb1
                                    (fun s'  ->
                                       ((let uu___87_4988 = bv  in
                                         {
                                           FStar_Syntax_Syntax.ppname =
                                             (uu___87_4988.FStar_Syntax_Syntax.ppname);
                                           FStar_Syntax_Syntax.index =
                                             (uu___87_4988.FStar_Syntax_Syntax.index);
                                           FStar_Syntax_Syntax.sort = s'
                                         }), aq))
                                   in
                                uu____4962 r) bs1
                        in
                     let rbs = comb_list r0  in
                     let rt = traverse f pol e' topen  in
                     comb2
                       (fun bs2  ->
                          fun t2  ->
                            let uu____5012 = FStar_Syntax_Util.abs bs2 t2 k
                               in
                            uu____5012.FStar_Syntax_Syntax.n) rbs rt)
            | FStar_Syntax_Syntax.Tm_ascribed (t1,asc,ef) ->
                let uu____5058 = traverse f pol e t1  in
                let uu____5063 =
                  comb1
                    (fun t2  -> FStar_Syntax_Syntax.Tm_ascribed (t2, asc, ef))
                   in
                uu____5063 uu____5058
            | x -> tpure x  in
          match r with
          | Unchanged tn' ->
              f pol e
                (let uu___88_5103 = t  in
                 {
                   FStar_Syntax_Syntax.n = tn';
                   FStar_Syntax_Syntax.pos =
                     (uu___88_5103.FStar_Syntax_Syntax.pos);
                   FStar_Syntax_Syntax.vars =
                     (uu___88_5103.FStar_Syntax_Syntax.vars)
                 })
          | Simplified (tn',gs) ->
              let uu____5110 =
                f pol e
                  (let uu___89_5114 = t  in
                   {
                     FStar_Syntax_Syntax.n = tn';
                     FStar_Syntax_Syntax.pos =
                       (uu___89_5114.FStar_Syntax_Syntax.pos);
                     FStar_Syntax_Syntax.vars =
                       (uu___89_5114.FStar_Syntax_Syntax.vars)
                   })
                 in
              emit gs uu____5110
          | Dual (tn,tp,gs) ->
              let rp =
                f pol e
                  (let uu___90_5124 = t  in
                   {
                     FStar_Syntax_Syntax.n = tp;
                     FStar_Syntax_Syntax.pos =
                       (uu___90_5124.FStar_Syntax_Syntax.pos);
                     FStar_Syntax_Syntax.vars =
                       (uu___90_5124.FStar_Syntax_Syntax.vars)
                   })
                 in
              let uu____5125 = explode rp  in
              (match uu____5125 with
               | (uu____5134,p',gs') ->
                   Dual
                     ((let uu___91_5144 = t  in
                       {
                         FStar_Syntax_Syntax.n = tn;
                         FStar_Syntax_Syntax.pos =
                           (uu___91_5144.FStar_Syntax_Syntax.pos);
                         FStar_Syntax_Syntax.vars =
                           (uu___91_5144.FStar_Syntax_Syntax.vars)
                       }), p', (FStar_List.append gs gs')))
  
let (getprop :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      FStar_Syntax_Syntax.term FStar_Pervasives_Native.option)
  =
  fun e  ->
    fun t  ->
      let tn =
        FStar_TypeChecker_Normalize.normalize
          [FStar_TypeChecker_Normalize.Weak;
          FStar_TypeChecker_Normalize.HNF;
          FStar_TypeChecker_Normalize.UnfoldUntil
            FStar_Syntax_Syntax.delta_constant] e t
         in
      FStar_Syntax_Util.un_squash tn
  
let (preprocess :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term ->
      (FStar_TypeChecker_Env.env,FStar_Syntax_Syntax.term,FStar_Options.optionstate)
        FStar_Pervasives_Native.tuple3 Prims.list)
  =
  fun env  ->
    fun goal  ->
      (let uu____5187 =
         FStar_TypeChecker_Env.debug env (FStar_Options.Other "Tac")  in
       FStar_ST.op_Colon_Equals tacdbg uu____5187);
      (let uu____5212 = FStar_ST.op_Bang tacdbg  in
       if uu____5212
       then
         let uu____5236 =
           let uu____5237 = FStar_TypeChecker_Env.all_binders env  in
           FStar_All.pipe_right uu____5237
             (FStar_Syntax_Print.binders_to_string ",")
            in
         let uu____5238 = FStar_Syntax_Print.term_to_string goal  in
         FStar_Util.print2 "About to preprocess %s |= %s\n" uu____5236
           uu____5238
       else ());
      (let initial = ((Prims.parse_int "1"), [])  in
       let uu____5267 =
         let uu____5274 = traverse by_tactic_interp Pos env goal  in
         match uu____5274 with
         | Unchanged t' -> (t', [])
         | Simplified (t',gs) -> (t', gs)
         | uu____5292 -> failwith "no"  in
       match uu____5267 with
       | (t',gs) ->
           ((let uu____5314 = FStar_ST.op_Bang tacdbg  in
             if uu____5314
             then
               let uu____5338 =
                 let uu____5339 = FStar_TypeChecker_Env.all_binders env  in
                 FStar_All.pipe_right uu____5339
                   (FStar_Syntax_Print.binders_to_string ", ")
                  in
               let uu____5340 = FStar_Syntax_Print.term_to_string t'  in
               FStar_Util.print2 "Main goal simplified to: %s |- %s\n"
                 uu____5338 uu____5340
             else ());
            (let s = initial  in
             let s1 =
               FStar_List.fold_left
                 (fun uu____5388  ->
                    fun g  ->
                      match uu____5388 with
                      | (n1,gs1) ->
                          let phi =
                            let uu____5433 =
                              let uu____5436 = FStar_Tactics_Types.goal_env g
                                 in
                              let uu____5437 =
                                FStar_Tactics_Types.goal_type g  in
                              getprop uu____5436 uu____5437  in
                            match uu____5433 with
                            | FStar_Pervasives_Native.None  ->
                                let uu____5438 =
                                  let uu____5443 =
                                    let uu____5444 =
                                      let uu____5445 =
                                        FStar_Tactics_Types.goal_type g  in
                                      FStar_Syntax_Print.term_to_string
                                        uu____5445
                                       in
                                    FStar_Util.format1
                                      "Tactic returned proof-relevant goal: %s"
                                      uu____5444
                                     in
                                  (FStar_Errors.Fatal_TacticProofRelevantGoal,
                                    uu____5443)
                                   in
                                FStar_Errors.raise_error uu____5438
                                  env.FStar_TypeChecker_Env.range
                            | FStar_Pervasives_Native.Some phi -> phi  in
                          ((let uu____5448 = FStar_ST.op_Bang tacdbg  in
                            if uu____5448
                            then
                              let uu____5472 = FStar_Util.string_of_int n1
                                 in
                              let uu____5473 =
                                FStar_Tactics_Basic.goal_to_string g  in
                              FStar_Util.print2 "Got goal #%s: %s\n"
                                uu____5472 uu____5473
                            else ());
                           (let gt' =
                              let uu____5476 =
                                let uu____5477 = FStar_Util.string_of_int n1
                                   in
                                Prims.strcat "Could not prove goal #"
                                  uu____5477
                                 in
                              FStar_TypeChecker_Util.label uu____5476
                                goal.FStar_Syntax_Syntax.pos phi
                               in
                            let uu____5478 =
                              let uu____5487 =
                                let uu____5494 =
                                  FStar_Tactics_Types.goal_env g  in
                                (uu____5494, gt',
                                  (g.FStar_Tactics_Types.opts))
                                 in
                              uu____5487 :: gs1  in
                            ((n1 + (Prims.parse_int "1")), uu____5478)))) s
                 gs
                in
             let uu____5509 = s1  in
             match uu____5509 with
             | (uu____5530,gs1) ->
                 let uu____5548 =
                   let uu____5555 = FStar_Options.peek ()  in
                   (env, t', uu____5555)  in
                 uu____5548 :: gs1)))
  
let (reify_tactic : FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term) =
  fun a  ->
    let r =
      let uu____5568 =
        let uu____5569 =
          FStar_Syntax_Syntax.lid_as_fv FStar_Parser_Const.reify_tactic_lid
            FStar_Syntax_Syntax.delta_equational FStar_Pervasives_Native.None
           in
        FStar_Syntax_Syntax.fv_to_tm uu____5569  in
      FStar_Syntax_Syntax.mk_Tm_uinst uu____5568 [FStar_Syntax_Syntax.U_zero]
       in
    let uu____5570 =
      let uu____5575 =
        let uu____5576 = FStar_Syntax_Syntax.iarg FStar_Syntax_Syntax.t_unit
           in
        let uu____5583 =
          let uu____5592 = FStar_Syntax_Syntax.as_arg a  in [uu____5592]  in
        uu____5576 :: uu____5583  in
      FStar_Syntax_Syntax.mk_Tm_app r uu____5575  in
    uu____5570 FStar_Pervasives_Native.None a.FStar_Syntax_Syntax.pos
  
let (synthesize :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.typ ->
      FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.term)
  =
  fun env  ->
    fun typ  ->
      fun tau  ->
        (let uu____5635 =
           FStar_TypeChecker_Env.debug env (FStar_Options.Other "Tac")  in
         FStar_ST.op_Colon_Equals tacdbg uu____5635);
        (let tau1 = reify_tactic tau  in
         let uu____5660 = run_tactic_on_typ tau1 env typ  in
         match uu____5660 with
         | (gs,w) ->
             ((let uu____5674 =
                 FStar_List.existsML
                   (fun g  ->
                      let uu____5678 =
                        let uu____5679 =
                          let uu____5682 = FStar_Tactics_Types.goal_env g  in
                          let uu____5683 = FStar_Tactics_Types.goal_type g
                             in
                          getprop uu____5682 uu____5683  in
                        FStar_Option.isSome uu____5679  in
                      Prims.op_Negation uu____5678) gs
                  in
               if uu____5674
               then
                 FStar_Errors.raise_error
                   (FStar_Errors.Fatal_OpenGoalsInSynthesis,
                     "synthesis left open goals") typ.FStar_Syntax_Syntax.pos
               else ());
              w))
  
let (splice :
  FStar_TypeChecker_Env.env ->
    FStar_Syntax_Syntax.term -> FStar_Syntax_Syntax.sigelt Prims.list)
  =
  fun env  ->
    fun tau  ->
      (let uu____5700 =
         FStar_TypeChecker_Env.debug env (FStar_Options.Other "Tac")  in
       FStar_ST.op_Colon_Equals tacdbg uu____5700);
      (let typ = FStar_Syntax_Syntax.t_decls  in
       let uu____5725 =
         let uu____5732 = reify_tactic tau  in
         run_tactic_on_typ uu____5732 env typ  in
       match uu____5725 with
       | (gs,w) ->
           ((let uu____5742 =
               FStar_List.existsML
                 (fun g  ->
                    let uu____5746 =
                      let uu____5747 =
                        let uu____5750 = FStar_Tactics_Types.goal_env g  in
                        let uu____5751 = FStar_Tactics_Types.goal_type g  in
                        getprop uu____5750 uu____5751  in
                      FStar_Option.isSome uu____5747  in
                    Prims.op_Negation uu____5746) gs
                in
             if uu____5742
             then
               FStar_Errors.raise_error
                 (FStar_Errors.Fatal_OpenGoalsInSynthesis,
                   "splice left open goals") typ.FStar_Syntax_Syntax.pos
             else ());
            (let w1 =
               FStar_TypeChecker_Normalize.normalize
                 [FStar_TypeChecker_Normalize.Weak;
                 FStar_TypeChecker_Normalize.HNF;
                 FStar_TypeChecker_Normalize.UnfoldUntil
                   FStar_Syntax_Syntax.delta_constant;
                 FStar_TypeChecker_Normalize.Primops;
                 FStar_TypeChecker_Normalize.Unascribe;
                 FStar_TypeChecker_Normalize.Unmeta] env w
                in
             let uu____5754 =
               let uu____5759 =
                 FStar_Syntax_Embeddings.e_list
                   FStar_Reflection_Embeddings.e_sigelt
                  in
               FStar_Syntax_Embeddings.unembed uu____5759 w1  in
             match uu____5754 with
             | FStar_Pervasives_Native.Some sigelts -> sigelts
             | FStar_Pervasives_Native.None  ->
                 FStar_Errors.raise_error
                   (FStar_Errors.Fatal_SpliceUnembedFail,
                     "splice: failed to unembed sigelts")
                   typ.FStar_Syntax_Syntax.pos)))
  