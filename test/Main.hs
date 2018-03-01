-- |
-- Description : Basic tests for profile decoding.
-- Copyright   : (c) Mateusz Kowalczyk, 2018
-- License     : BSD3
module Main (main, ghcManualSample) where

import qualified Data.Aeson as A
import qualified Data.ByteString.Lazy as BSL
import           Data.Either (isRight)
import           Test.Hspec
import           Data.String (fromString)
import           Profiling.GHC.Aeson (GhcProfile)

main :: IO ()
main = hspec $ do
  describe "Profiling.GHC.Aeson" $ do
    context "decoding" $ do
      it "Parses GHC manual example." $
        let er :: Either String GhcProfile
            er = A.eitherDecode' ghcManualSample
        in er `shouldSatisfy` isRight

ghcManualSample :: BSL.ByteString
ghcManualSample = fromString $ Prelude.unlines
  [ "{"
  , "  \"program\": \"Main\","
  , "  \"arguments\": ["
  , "    \"nofib/shootout/n-body/Main\","
  , "    \"50000\""
  , "  ],"
  , "  \"rts_arguments\": ["
  , "    \"-pj\","
  , "    \"-hy\""
  , "  ],"
  , "  \"end_time\": \"Thu Feb 23 17:15 2017\","
  , "  \"initial_capabilities\": 0,"
  , "  \"total_time\": 1.7,"
  , "  \"total_ticks\": 1700,"
  , "  \"tick_interval\": 1000,"
  , "  \"total_alloc\": 3770785728,"
  , "  \"cost_centres\": ["
  , "    {"
  , "      \"id\": 168,"
  , "      \"label\": \"IDLE\","
  , "      \"module\": \"IDLE\","
  , "      \"src_loc\": \"<built-in>\","
  , "      \"is_caf\": false"
  , "    },"
  , "    {"
  , "      \"id\": 156,"
  , "      \"label\": \"CAF\","
  , "      \"module\": \"GHC.Integer.Logarithms.Internals\","
  , "      \"src_loc\": \"<entire-module>\","
  , "      \"is_caf\": true"
  , "    },"
  , "    {"
  , "      \"id\": 155,"
  , "      \"label\": \"CAF\","
  , "      \"module\": \"GHC.Integer.Logarithms\","
  , "      \"src_loc\": \"<entire-module>\","
  , "      \"is_caf\": true"
  , "    },"
  , "    {"
  , "      \"id\": 154,"
  , "      \"label\": \"CAF\","
  , "      \"module\": \"GHC.Event.Array\","
  , "      \"src_loc\": \"<entire-module>\","
  , "      \"is_caf\": true"
  , "    }"
  , "  ],"
  , "  \"profile\": {"
  , "    \"id\": 162,"
  , "    \"entries\": 0,"
  , "    \"alloc\": 688,"
  , "    \"ticks\": 0,"
  , "    \"children\": ["
  , "      {"
  , "        \"id\": 1,"
  , "        \"entries\": 0,"
  , "        \"alloc\": 208,"
  , "        \"ticks\": 0,"
  , "        \"children\": ["
  , "          {"
  , "            \"id\": 22,"
  , "            \"entries\": 1,"
  , "            \"alloc\": 80,"
  , "            \"ticks\": 0,"
  , "            \"children\": []"
  , "          }"
  , "        ]"
  , "      },"
  , "      {"
  , "        \"id\": 42,"
  , "        \"entries\": 1,"
  , "        \"alloc\": 1632,"
  , "        \"ticks\": 0,"
  , "        \"children\": []"
  , "      }"
  , "    ]"
  , "  }"
  , "}"
  ]
