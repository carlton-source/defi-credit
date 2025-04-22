;; Title: DeFi Credit Protocol - Decentralized Lending on Stacks
;;
;; Summary: A Bitcoin-compatible lending protocol that enables collateralized loans with
;; dynamic interest rates based on a reputation scoring system.
;;
;; Description:
;; This contract implements a decentralized credit scoring and lending facility for the Stacks ecosystem.
;; Users build credit scores through loan repayment history, unlocking better loan terms over time.
;; The protocol supports partial collateralization based on creditworthiness, variable interest rates,
;; and manages risk through an incentive-aligned scoring system. Built for Bitcoin L2 compliance and
;; optimized for the Stacks blockchain environment.

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-BALANCE (err u2))
(define-constant ERR-INVALID-AMOUNT (err u3))
(define-constant ERR-LOAN-NOT-FOUND (err u4))
(define-constant ERR-LOAN-DEFAULTED (err u5))
(define-constant ERR-INSUFFICIENT-SCORE (err u6))
(define-constant ERR-ACTIVE-LOAN (err u7))
(define-constant ERR-NOT-DUE (err u8))
(define-constant ERR-INVALID-DURATION (err u9))
(define-constant ERR-INVALID-LOAN-ID (err u10))

;; Credit score thresholds
(define-constant MIN-SCORE u50)
(define-constant MAX-SCORE u100)
(define-constant MIN-LOAN-SCORE u70)

;; Data Maps
(define-map UserScores
    { user: principal }
    {
        score: uint,
        total-borrowed: uint,
        total-repaid: uint,
        loans-taken: uint,
        loans-repaid: uint,
        last-update: uint
    }
)

(define-map Loans
    { loan-id: uint }
    {
        borrower: principal,
        amount: uint,
        collateral: uint,
        due-height: uint,
        interest-rate: uint,
        is-active: bool,
        is-defaulted: bool,
        repaid-amount: uint
    }
)

(define-map UserLoans
    { user: principal }
    { active-loans: (list 20 uint) }
)