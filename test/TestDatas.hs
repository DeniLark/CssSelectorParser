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



