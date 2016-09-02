{-
Copyright (c) 2016 Albert Krewinkel

Permission to use, copy, modify, and/or distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright notice
and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
THIS SOFTWARE.
-}

{-|
Module      :  Text.Huskydoc.Blocks
Copyright   :  © 2016 Albert Krewinkel
License     :  ISC

Maintainer  :  Albert Krewinkel <tarleb@zeitkraut.de>
Stability   :  experimental
Portability :  portable

Parsers for block elements
-}
module Text.Huskydoc.Blocks
  ( blockElement
  -- individual block parsers
  , paragraph
  ) where

import           Text.Huskydoc.Attributes
import qualified Text.Huskydoc.Builders as B
import           Text.Huskydoc.Inlines (inlines)
import           Text.Huskydoc.Parsing
import           Text.Huskydoc.Types

blockElement :: Parser BlockElement
blockElement = choice
  [ paragraph
  ] <?> "blocks"

paragraph :: Parser BlockElement
paragraph = try $ do
  _ <- skipMany blankline
  attributes <- optional parseAttributes
  contents <- inlines
  return $ contents `B.paragraphWith'` attributes
