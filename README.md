# Quorum Compatibility Probe (QPROBE)

This is a compatibility test of immutable agent governance deployed through IMD, not the production QUORUM release. Test token economics are not an investment proposition. No website, ENS, operator service, or automatic trading is requested.

## Purpose

Determine whether IMD can import and review this project, validate its two predeployed immutable dependencies, adapt only the launch integration where necessary, and launch a Token + Hook + pool whose immutable governance is the reviewed implementation. A generic token launch without these dependencies is not a passing result.

## Deployment

1. The payer deploys the exact English constitution and an immutable creation-code package. PREREQUISITES.json must contain verified receipts and code hashes before submission.
2. IMD creates the zero-argument QProbeToken and then QuorumIssuanceHook through its official factory.
3. In its constructor, Hook calls the fixed package. The package creates Core with the actual Token, paired IMD, fixed stake, constitution, and msg.sender (Hook). Core creates Membership, Treasury, Work, and OperatingAccount. This happens atomically within the official launch transaction. No future address prediction, administrator binding, proxy, delegatecall, or mutable initialization is needed.
4. Obtain Core only through the actual Hook.core() getter. The code package is reusable; do not assume it has only one caller or predict a child using its nonce.
5. The package creationHash and reconstructed creation bytes must exactly match the compiled QuorumBoundCore creation code. Existing immutable governance code cannot be patched by adapting token/hook source. If a necessary fix changes this code, report the incompatibility rather than weakening checks or deploying a different unreviewed core.

## Verify locally

Run `forge test --json` directly. The five pinned external fixture artifacts are committed so an IMD verifier does not need a manual bootstrap. To reproduce these artifacts from the vendored original sources, optionally run `python tools/build_external_fixtures.py` first. There are nineteen required positive tests. External PoolManager and IMD factory bytecode is built from vendored original sources with Solidity 0.8.26; project code uses Solidity 0.8.28. Both use their pinned optimizer configuration, viaIR, Cancun target and bytecode_hash=none.

The five issuance tests retain original proof registration, plain ERC20 transfers, 3% IMD buy/sell tax, 50/50 treasury accounting, paid work and wages, original allocation unlock, sell credits, and platform fee collection. Fourteen governance cases cover joining, key rotation, full-week qualification, voting snapshots, repair, suspension, exact operating calls, and principal refunds. Tests must not be removed, skipped or weakened. The constitution governs the intended rules; source/test disagreements must be reported.

## Acceptance boundaries

- Test on Ethereum chainId=1 paired with IMD. Sepolia currently offers only native ETH pairing, which does not exercise this ERC20-paired mechanism.
- Total supply 1 billion, 18 decimals, ordinary transfers; 90% seeded in the pool and standard 10% swarm. Fixed test stake 62,500 tokens, no total seat cap.
- Immutable core creation bytes and full constitution must match PREREQUISITES.json; no upgrade/admin added.
- No change to core governance, tax rates, quota accounting, ownership/authorization, voting, or payouts to make launch pass. New LP remains factory-only.
- Factory/init/runtime code and actual transaction gas must satisfy current protocol limits, including 16,777,216 gas/transaction. Separate local transactions in the experiment were below this cap; this is not a platform acceptance claim.
- Verify actual Token/Hook/Core/Membership/Treasury/Work bindings and official registry on chain after deployment. If the platform cannot execute this composition, report failure with the precise rejected stage; never call an alternative generic launch success.
- Requester LP fee ownership starts with the payer unless the platform can assign Hook directly. The payer can hand over future fees to Hook before final acceptance. Do not invent authority to move already paid fees.
- Only reviewed positive workflows are in scope; this bundle is not an independent security audit or proof of autonomous operation.
