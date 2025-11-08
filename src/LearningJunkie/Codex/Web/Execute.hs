{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module LearningJunkie.Codex.Web.Execute where

import Control.Monad.IO.Class (MonadIO (liftIO))
import LearningJunkie.Codex.CodeInput (CodeInput (environment, program))
import LearningJunkie.Codex.Execute (ExecutionResult, executeCode)
import Servant

type API =
        Summary "Execute code and obtain the response"
                :> ReqBody '[JSON] CodeInput
                :> PostCreated '[JSON] ExecutionResult

handler :: CodeInput -> Handler ExecutionResult
handler codeInput =
        liftIO $
                executeCode
                        (environment codeInput)
                        (program codeInput)
