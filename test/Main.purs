module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Control.Monad.Eff.Exception (EXCEPTION)
import Node.ReadLine (READLINE, prompt, close, setLineHandler, setPrompt, 
                      noCompletion, createConsoleInterface)

main::forall e. 
 Eff (readline::READLINE, console::CONSOLE, err :: EXCEPTION | e) Unit
main = do
  interface <- createConsoleInterface noCompletion
  
  setPrompt "> " 2 interface
  prompt interface
  setLineHandler interface $ \s ->
    if s == "quit"
       then close interface
       else do
        log $ "You typed: " <> s
        prompt interface
