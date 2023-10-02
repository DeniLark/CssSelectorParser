module Parser where

import           Text.Parsec

import           Control.Applicative     hiding ( (<|>)
                                                , many
                                                )

import           Parser.Attr
import           Parser.Prim
import           Parser.Types
import           Parser.Utils


parserCssSelectors :: String -> Either ParseError [Combinator]
parserCssSelectors = (combinators >>>)

combinators :: Parser [Combinator]
combinators = sepBy1 combinator (lexeme $ char ',')


combinator :: Parser Combinator
combinator = choice
  [ try combSons
  , try combNeighbors
  , try combNext
  , try combChildren
  , One <$> element
  ]

-- Children Element Combinator  -- " "
combChildren :: Parser Combinator
combChildren = liftA2 Children element (lexeme (char ' ') *> combinator)

-- Sons Element Combinator      -- " > "
combSons :: Parser Combinator
combSons = liftA2 Sons element (string " > " *> combinator)

-- Neighbors Element Combinator -- " ~ "
combNeighbors :: Parser Combinator
combNeighbors = liftA2 Neighbors element (string " ~ " *> combinator)

-- Next Element Combinator      -- " + "
combNext :: Parser Combinator
combNext = liftA2 Next element (string " + " *> combinator)

------------------------
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






