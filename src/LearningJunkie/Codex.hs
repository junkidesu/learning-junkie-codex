module LearningJunkie.Codex (Environment (..), executeCode, ExecutionResult (..)) where

import Data.Text (Text, pack)
import Data.Text.IO (writeFile)
import Data.UUID (toString)
import Data.UUID.V4 (nextRandom)
import LearningJunkie.Codex.Environment (Environment (..))
import LearningJunkie.Codex.ExecutionResult (ExecutionResult (..))
import System.Exit (ExitCode (ExitFailure, ExitSuccess))
import System.Process
import Prelude hiding (writeFile)

executeCode :: Environment -> Text -> IO ExecutionResult
executeCode environment program = do
        randomFileName <- toString <$> nextRandom

        let
                temporaryFilePath = case environment of
                        Node -> "src/node/" ++ randomFileName ++ ".js"
                        Python -> "src/python/" ++ randomFileName ++ ".py"
                        Haskell -> "src/haskell/" ++ randomFileName ++ ".hs"
                dockerFileLocation = case environment of
                        Node -> "src/node/Dockerfile"
                        Python -> "src/python/Dockerfile"
                        Haskell -> "src/haskell/Dockerfile"

        writeFile temporaryFilePath program

        callCommand $
                "docker build -f "
                        ++ dockerFileLocation
                        ++ " -t "
                        ++ randomFileName
                        ++ " --build-arg filepath="
                        ++ temporaryFilePath
                        ++ " ."

        _processOutput@(processExitCode, stdOut, stdErr) <-
                readCreateProcessWithExitCode
                        (shell $ "docker run --rm " ++ randomFileName ++ ":latest")
                        ""

        callCommand $ "rm " ++ temporaryFilePath
        callCommand $ "docker image rm " ++ randomFileName

        return $ case processExitCode of
                ExitSuccess -> Success $ pack stdOut
                ExitFailure _ -> Failure $ pack stdErr
