module Parser.Types where

import           Text.Parsec

type Attr = (String, [String])

--                     Tag    Attributes
data Element = Element String [Attr]
  deriving (Show, Eq)

type Parser = Parsec String ()

