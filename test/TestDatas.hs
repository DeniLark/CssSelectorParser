module TestDatas where

import           Parser.Types

testElement :: [(String, Element)]
testElement =
  [ ("div"              , Element "div" [])
  , ("div#id"           , Element "div" [("id", ["id"])])
  , ("span[lang]"       , Element "span" [("lang", [])])
  , ("span[lang=\"pt\"]", Element "span" [("lang", ["pt"])])
  , ("span.class[lang]", Element "span" [("class", ["class"]), ("lang", [])])
  , ( ".class1.class2#id.class3.class4[lang=\"ru\"]"
    , Element
      ""
      [ ("id"   , ["id"])
      , ("class", ["class1", "class2", "class3", "class4"])
      , ("lang" , ["ru"])
      ]
    )
  , ("#div", Element "" [("id", ["div"])])
  , (".div", Element "" [("class", ["div"])])
  , ( "#id.class1.class2"
    , Element "" [("id", ["id"]), ("class", ["class1", "class2"])]
    )
  , ( ".class1.class2#id.class3.class4"
    , Element
      ""
      [("id", ["id"]), ("class", ["class1", "class2", "class3", "class4"])]
    )
  , ( ".class1.class2[lang]"
    , Element "" [("class", ["class1", "class2"]), ("lang", [])]
    )
  , ( ".class1.class2[lang=\"ru\"]"
    , Element "" [("class", ["class1", "class2"]), ("lang", ["ru"])]
    )
  ]

testCombinator :: [(String, Combinator)]
testCombinator =
  [ ( "div span a"
    , Children (Element "div" [])
               (Children (Element "span" []) (One (Element "a" [])))
    )
  , ( "div > span a"
    , Sons (Element "div" [])
           (Children (Element "span" []) (One (Element "a" [])))
    )
  , ("div ~ span", Neighbors (Element "div" []) (One (Element "span" [])))
  , ("div + span", Next (Element "div" []) (One (Element "span" [])))
  , ( "div.class1#id1.class2"
    , One (Element "div" [("id", ["id1"]), ("class", ["class1", "class2"])])
    )
  ]

testCombinators :: [(String, [Combinator])]
testCombinators =
  [ ( "div,span,span"
    , [One (Element "div" []), One (Element "span" []), One (Element "span" [])]
    )
  ]
