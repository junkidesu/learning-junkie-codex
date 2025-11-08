{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}

module LearningJunkie.Codex.Initialize where

import Control.Monad (forM_, unless)
import qualified Data.ByteString as BS
import Data.FileEmbed (embedFile)
import System.Directory (createDirectoryIfMissing, doesFileExist)

pythonDockerfile :: BS.ByteString
pythonDockerfile = $(embedFile "codex/python/Dockerfile")

nodeDockerfile :: BS.ByteString
nodeDockerfile = $(embedFile "codex/node/Dockerfile")

haskellDockerfile :: BS.ByteString
haskellDockerfile = $(embedFile "codex/haskell/Dockerfile")

dockerfiles :: [(FilePath, BS.ByteString)]
dockerfiles =
        [ ("codex/python/Dockerfile", pythonDockerfile)
        , ("codex/node/Dockerfile", nodeDockerfile)
        , ("codex/haskell/Dockerfile", haskellDockerfile)
        ]

initializeDockerfiles :: IO ()
initializeDockerfiles = do
        createDirectoryIfMissing True "codex/haskell"
        createDirectoryIfMissing True "codex/node"
        createDirectoryIfMissing True "codex/python"

        forM_ dockerfiles $ \(filepath, dockerfile) -> do
                dockerfileExists <- doesFileExist filepath

                unless dockerfileExists $ BS.writeFile filepath dockerfile
