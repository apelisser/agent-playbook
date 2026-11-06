---
name: cost-aware-model-router
description: Use when choosing a model or reasoning effort for a task or subagent, or deciding whether a failed attempt warrants a more capable configuration.
---

# Cost-aware model router

Choose the lowest expected-consumption configuration that can complete the task with verifiable quality. Apply this to a task before starting it, and reconsider only when new evidence changes the estimate. Do not spend more effort classifying a small task than doing it.

## Check what can actually be controlled

- Identify which models and reasoning levels the current host and account offer. Do not assume API availability implies availability in the agent host, or that a named model has the same cost across authentication modes.
- Distinguish the primary session from a new task or subagent. A skill is guidance; it does not by itself change the running model. Use a host control only if it can apply the selection to the intended execution. Confirm the effective model and effort when the host exposes that information.
- If no control is available, state the recommendation only when useful and continue with the current configuration. Do not claim automatic routing or launch a replacement session merely to simulate it.

## Select the level

Use a quick estimate of reasoning difficulty, ambiguity, error impact, available validation, and previous attempts. File count and technology names alone do not determine the level.

| Level | Use when | Starting configuration |
| --- | --- | --- |
| ECONOMY | Clear, bounded work with cheap verification | Least costly capable model; low effort if supported |
| STANDARD | Ordinary implementation or investigation with several steps | Efficient general model; default or medium effort |
| ADVANCED | Difficult diagnosis, interacting constraints, or significant risk | More capable model; medium or high effort |
| PREMIUM | Exceptional complexity or critical decisions that cheaper configurations cannot handle reliably | Most capable available model; high or higher supported effort |

Choose concrete model and effort from the host's available options. Consider the cost of retries, not only the cost of one call. Preserve required tests, review, and security checks at every level.

## Escalate with evidence

First improve missing context or the approach when that is likely to resolve the difficulty. Escalate for a materially new reasoning need, a validated inconsistency, or repeated failures with distinct diagnoses. An environment failure, missing dependency, flaky test, or unclear requirement is a reason to fix or clarify that condition, not to buy more reasoning. Avoid repeating the same failed approach.

Before selecting PREMIUM, an effort above high, or exceeding an explicit usage limit, ask for authorization if the user has not already authorized that specific cost level. State the current and proposed settings, technical reason, and expected benefit. Give a consumption estimate only when the host supplies a reliable basis. If declined, use the best allowed setting or explain the remaining limit. When an executor enforces a budget, its approval gate must be real; instructions alone cannot enforce it.

After completing a high-cost task, reassess the next task from ECONOMY instead of carrying over the prior classification. Report actual model, effort, usage, and escalation only when observable; label estimates and unavailable metrics honestly. Do not log secrets or task content solely for routing.
