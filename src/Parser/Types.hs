module Parser.Types where

import           Text.Parsec

type Attr = (String, [String])

--                     Tag    Attributes
data Element = Element String [Attr]
  deriving (Show, Eq)

type Parser = Parsec String ()

data Combinator =
    One Element
  -- | List [Element]                -- ", "
  | Children Element Combinator  -- " "
  | Sons Element Combinator      -- " > "
  | Neighbors Element Combinator -- " ~ "
  | Next Element Combinator      -- " + "
  -- | нет псевдоклассов
  deriving (Show, Eq)
