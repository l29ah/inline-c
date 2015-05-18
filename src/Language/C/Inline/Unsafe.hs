-- | @unsafe@ variants of the "Language.C.Inline" quasi-quoters, to call the C code
-- unsafely in the sense of
-- <https://www.haskell.org/onlinereport/haskell2010/haskellch8.html#x15-1590008.4.3>.
-- In GHC, unsafe foreign calls are faster than safe foreign calls, but the user
-- must guarantee the control flow will never enter Haskell code (via a callback
-- or otherwise) before the call is done.
--
-- This module is intended to be imported qualified:
--
-- @
-- import qualified "Language.C.Inline.Unsafe" as CU
-- @

module Language.C.Inline.Unsafe
  ( exp
  , pure
  , block
  ) where

import Language.C.Inline.Internal
import qualified Language.Haskell.TH.Quote as TH
import qualified Language.Haskell.TH.Syntax as TH
import           System.IO.Unsafe (unsafePerformIO) -- for 'pure'

import           Prelude hiding (exp, pure)

-- | C expressions.
exp :: TH.QuasiQuoter
exp = genericQuote $ inlineExp TH.Unsafe

-- | Variant of 'exp', for use with expressions known to have no side effects.
--
-- BEWARE: use this function with caution, only when you know what you are
-- doing. If an expression does in fact have side-effects, then indiscriminate
-- use of 'pure' may endanger referential transparency, and in principle even
-- type safety.
pure :: TH.QuasiQuoter
pure = genericQuote $ UNIMPLEMENTED

-- | C code blocks (i.e. statements).
block :: TH.QuasiQuoter
block = genericQuote $ inlineItems TH.Unsafe
