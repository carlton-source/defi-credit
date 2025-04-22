# DeFi Credit Protocol — Decentralized Lending on Stacks

**A Bitcoin-secured, decentralized credit and lending protocol powered by reputation-based scoring.**

## Overview

The **DeFi Credit Protocol** is a Clarity smart contract built for the [Stacks](https://stacks.co) blockchain, enabling decentralized, reputation-driven lending with partial collateralization and dynamic interest rates. It empowers users to access credit by building trust over time—without relying on traditional credit bureaus.

This protocol is designed to be:

- **Credit-Scored**: Users build on-chain credit scores based on repayment history.
- **Partially Collateralized**: Borrowers with higher scores can access loans with lower collateral requirements.
- **Risk-Aligned**: Interest rates adjust according to creditworthiness.
- **Bitcoin-Secure**: Integrates Bitcoin finality through the Stacks L2 architecture.

## Features

### Credit Scoring System

- On-chain scores range from **50 to 100**.
- Repaid loans boost scores; defaults penalize them.
- Scores impact access to loans and terms.

### Lending Protocol

- Borrowers request STX loans by locking collateral.
- Collateral requirements are **score-adjusted**.
- Interest rates decrease as credit scores improve.

### Dynamic Risk Management

- Admins can flag overdue loans as **defaulted**.
- Loans are capped to limit protocol exposure.
- Users with active or defaulted loans are restricted from new borrowing.

## Smart Contract Architecture

### Maps

- `UserScores`: Tracks credit score, loan stats, and repayment history.
- `Loans`: Stores individual loan records including amount, collateral, and repayment status.
- `UserLoans`: Associates borrowers with their active loans.

### Key Public Functions

| Function | Description |
|---------|-------------|
| `initialize-score` | Bootstraps a user’s credit profile with minimum score. |
| `request-loan` | Requests a new loan, based on amount, collateral, and duration. |
| `repay-loan` | Repays active loans; returns collateral if fully repaid. |
| `mark-loan-defaulted` | Admin-only. Flags overdue loans as defaulted and penalizes score. |

### Score Tiers

- **Minimum Score:** `u50` — needed to initialize.
- **Loan Eligibility Score:** `u70` — required to borrow.
- **Maximum Score:** `u100` — best terms, lowest interest.

### Loan Limits

- **Max duration**: `~1 year` (up to 52,560 blocks assuming 10-min blocks).
- **Active loan cap**: Max 5 concurrent loans per user.

## Interest & Collateral Logic

### Interest Rate Formula

```clojure
(base-rate) - ((score * 5) / 100)
```

- Base rate is `u10` (10%)
- Higher scores reduce rates proportionally

### Collateral Requirement

```clojure
required = amount * (100 - (score * 50 / 100)) / 100
```

- Higher scores = lower required collateral

---

## 🛠 Development & Deployment

### Requirements

- Clarity Language (Stacks smart contracts)
- [Clarinet](https://docs.stacks.co/concepts/clarity/overview) for local development and testing

### Compile & Test

```bash
clarinet check
clarinet test
```

### Deployment (via Clarinet)

Ensure your local environment or testnet wallet is configured:

```bash
clarinet deploy
```

## Read-Only Functions

| Function | Description |
|---------|-------------|
| `get-user-score` | Fetches a user's credit score and repayment stats. |
| `get-loan` | Returns full details of a specific loan. |
| `get-user-active-loans` | Lists currently active loans by a user. |

## Future Improvements

- NFT-based credit badges
- Integration with Bitcoin DeFi liquidity pools
- Automated default detection via cron jobs
- Score portability via DID/VCs

## Related Links

- [Stacks Documentation](https://docs.stacks.co/)
- [Clarity Language Reference](https://docs.stacks.co/guides-and-tutorials/clarity-crash-course)
