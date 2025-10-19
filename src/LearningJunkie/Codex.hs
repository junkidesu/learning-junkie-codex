module LearningJunkie.Codex (Environment (..), executeCode, ExecutionResult (..)) where

import Data.Text (Text, pack)
import Data.UUID (toString)
import Data.UUID.V4 (nextRandom)
import System.Exit (ExitCode (ExitFailure, ExitSuccess))
import System.Process

data Environment = Haskell | Node | Python
        deriving (Show, Read, Eq)

data ExecutionResult
        = Success
                { executionOutput :: Text
                }
        | Failure
                { executionError :: Text
                }
        deriving (Show, Read, Eq)

executeCode :: Environment -> String -> IO ExecutionResult
executeCode Node program = do
        randomFileName <- toString <$> nextRandom

        let temporaryFilePath = "node/" ++ randomFileName ++ ".js"

        writeFile temporaryFilePath program

        callCommand $
                "docker build -f node/Dockerfile -t "
                        ++ randomFileName
                        ++ " --build-arg filepath="
                        ++ temporaryFilePath
                        ++ "  ."

        _processOutput@(processExitCode, stdOut, stdErr) <-
                readCreateProcessWithExitCode
                        (shell $ "docker run --rm " ++ randomFileName ++ ":latest")
                        ""

        callCommand $ "rm " ++ temporaryFilePath
        callCommand $ "docker image rm " ++ randomFileName

        return $ case processExitCode of
                ExitSuccess -> Success $ pack stdOut
                ExitFailure _ -> Failure $ pack stdErr
executeCode Haskell program = do
        randomFileName <- toString <$> nextRandom

        let temporaryFilePath = "haskell/" ++ randomFileName ++ ".hs"

        writeFile temporaryFilePath program

        callCommand $
                "docker build -f haskell/Dockerfile -t "
                        ++ randomFileName
                        ++ " --build-arg filepath="
                        ++ temporaryFilePath
                        ++ "  ."

        _processOutput@(processExitCode, stdOut, stdErr) <-
                readCreateProcessWithExitCode
                        (shell $ "docker run --rm " ++ randomFileName ++ ":latest")
                        ""

        callCommand $ "rm " ++ temporaryFilePath
        callCommand $ "docker image rm " ++ randomFileName

        return $ case processExitCode of
                ExitSuccess -> Success $ pack stdOut
                ExitFailure _ -> Failure $ pack stdErr
executeCode _ _ = error "To be implemented"
