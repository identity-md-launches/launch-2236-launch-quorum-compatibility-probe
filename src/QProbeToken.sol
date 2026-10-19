// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;
import {QuorumLaunchToken} from "./QuorumLaunchToken.sol";
/// Compatibility test only. Constants refer to prerequisites, NOT a production release.
contract QProbeToken is QuorumLaunchToken {
 constructor() QuorumLaunchToken("Quorum Compatibility Probe","QPROBE",
  address(bytes20(hex"d34a99bc0f67ae1bbd63c660e6d0b0dd03e263b7")),62500 ether,
  address(bytes20(hex"3a0178ebfac181b9abad2fc980507b43ebf4f161")),address(bytes20(hex"a0ffc637788cf803d05f459128f475487cf9224a"))) {}
}
