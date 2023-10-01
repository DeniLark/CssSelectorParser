module Parser.Attr where

import           Control.Applicative            ( Applicative(liftA2) )
import           Parser.Types
import           Parser.Utils
import           Text.Parsec

attrs :: Parser [Attr]
attrs = between (char '[') (char ']') (sepBy attr (char ',')) <|> pure []

attr :: Parser Attr
attr =
  liftA2 (,) attrString
    $ (char '=' *> ((: []) <$> between (char '\"') (char '\"') attrValueString))
    <|> pure []

--------------------
attrString :: Parser String
attrString = many1 letter

attrValueString :: Parser String
attrValueString = many1 letter
