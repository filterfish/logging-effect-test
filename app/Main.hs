{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE DataKinds #-}

module Main where

import           Protolude hiding (log)

import           System.IO
import           Control.Monad.Log (Severity(..))
import           Text.PrettyPrint.Leijen.Text (text)

import qualified Logging as Log


main :: IO ()
main = do
  setStdoutBufferOptions
  forever $ do
    logMessage
    threadDelay (1000 * 1000)

logMessage :: IO ()
logMessage =
  Log.withLogging Debug $ Log.log Warning (text "However, for longer running high performance applications there is a slight problem")

setStdoutBufferOptions :: IO ()
setStdoutBufferOptions = hSetBuffering stdout LineBuffering
