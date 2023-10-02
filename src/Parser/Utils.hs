module Parser.Utils where

import           Control.Applicative

import           Text.Parsec

import           Parser.Types


(>>>) :: Parser a -> String -> Either ParseError a
(>>>) p = parse p ""

(!>>>) :: Parser a -> String -> Either ParseError a
(!>>>) p = parse (p <* eof) ""

($>>>) :: Parser a -> String -> Either ParseError (a, String)
($>>>) p = parse (liftA2 (,) p remainingInput) ""

remainingInput :: Parser String
remainingInput = manyTill anyChar eof

lexeme :: Parser a -> Parser a
lexeme = (<* spaces)
