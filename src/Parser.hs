module Parser where



import           Text.Parsec

import           Control.Applicative     hiding ( (<|>)
                                                , many
                                                )

import           Parser.Attr
import           Parser.Prim
import           Parser.Types
import           Parser.Utils


element :: Parser Element
element = liftA2 Element tagP attributes

attributes :: Parser [Attr]
attributes =
  -- id-classes | classes-id
  try (liftA2 (\(i, cs) as -> i : cs : as) idAndClasses attrs)
    -- classes
    <|> liftA2 (:) (("class", ) <$> classesP) attrs
    -- id
    <|> liftA2 (:) idP                        attrs
    <|> attrs






