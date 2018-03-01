{-# LANGUAGE DeriveGeneric #-}
-- |
-- Description : Aeson decoders and encoders for GHC's profiling data.
-- Copyright   : (c) Mateusz Kowalczyk, 2018
-- License     : BSD3
module Profiling.GHC.Aeson
  ( CostCentre(..)
  , CostCentreStack(..)
  , GhcProfile(..)
  ) where

import qualified Data.Text as T
import qualified Data.Vector as V
import qualified Data.Aeson as A
import GHC.Generics (Generic)
import Data.List (stripPrefix)
import Data.Maybe (fromMaybe)

-- | Drops the given prefix from an aeson field name. Returns the
-- original field name if the prefix does not match exactly.
dropFieldPrefix
  :: String -- ^ Prefix
  -> String -- ^ Field name
  -> String
dropFieldPrefix pref fld = fromMaybe fld $ Data.List.stripPrefix pref fld

data CostCentre = CostCentre
  { _cc_id :: !Int
  , _cc_label :: !T.Text
  , _cc_module :: !T.Text
  , _cc_src_loc :: !T.Text
  , _cc_is_caf :: !Bool
  } deriving (Show, Eq, Ord, Generic)

instance A.FromJSON CostCentre where
  parseJSON = A.genericParseJSON A.defaultOptions
    { A.fieldLabelModifier = dropFieldPrefix "_cc_" }

data CostCentreStack = CostCentreStack
  { _ccs_id :: !Int
  , _ccs_entries :: !Int
  , _ccs_alloc :: !Int
  , _ccs_ticks :: !Int
  , _ccs_children :: !(V.Vector CostCentreStack)
  } deriving (Show, Eq, Ord, Generic)

instance A.FromJSON CostCentreStack where
  parseJSON = A.genericParseJSON A.defaultOptions
    { A.fieldLabelModifier = dropFieldPrefix "_ccs_" }

data GhcProfile = GhcProfile
  { _gp_program :: !T.Text
  , _gp_arguments :: !(V.Vector T.Text)
  , _gp_rts_arguments :: !(V.Vector T.Text)
  , _gp_end_time :: !T.Text
  , _gp_initial_capabilities :: !Int
  , _gp_total_time :: !Double
  , _gp_total_ticks :: !Int
  , _gp_tick_interval :: !Int
  , _gp_total_alloc :: !Int
  , _gp_cost_centres :: !(V.Vector CostCentre)
  , _gp_profile :: !CostCentreStack
  } deriving (Show, Eq, Ord, Generic)

instance A.FromJSON GhcProfile where
  parseJSON = A.genericParseJSON A.defaultOptions
    { A.fieldLabelModifier = dropFieldPrefix "_gp_" }
