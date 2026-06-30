# terraform-google-project

> Baseline engineering guidance for this repository, **shared with the team**. Applies to AI coding
> assistants (Claude Code, Gemini, Codex, GitHub Copilot) and humans alike. Self-contained and tool-agnostic —
> edit freely. (This is the team's standard file; any private/framework wiring lives elsewhere.)
>
> **Public-safe:** this file is committed and may be public. Keep it to **generic standards + only
> non-identifying context**. Do NOT put personal names, employer/client names, concrete cloud
> project/account IDs, state-bucket names, or internal hostnames here — those belong in the private,
> un-pushed complement, not a shared/public repo.

## Project context
- **Purpose:** Reusable Terraform module that provisions one or more Google Cloud projects
  from a single `map(object)` input — generating each project ID with a random suffix,
  enabling a configurable set of APIs per project, and applying labels (always merging
  `managed = "terraform"`).
- **Stack:** Terraform; providers `hashicorp/google ~> 6` and `hashicorp/random`. Library
  module only — no backend of its own.
- **Environments:** N/A — this is a consumable module; environments, `*.tfvars`, and state
  belong to the root configuration that calls it.
- **State / backend:** N/A — the module declares no backend; the calling root config owns
  remote state.

## Working intelligence — before writing anything
- **Reuse before you create — never add a new resource without first ruling out an existing pattern.**
  Adding a brand-new resource block is the *last* resort, not the first move. For the concern at hand
  (e.g. an IAM grant, a database, a bucket, a service account, a firewall rule), search the repo in
  this order and stop at the first that fits:
  1. **An existing iteration construct that already creates this kind of thing** — a `for_each` /
     `count` / `dynamic` block, or the `map` / `list` / `locals` / `*.tfvars` collection that drives
     one (e.g. an IAM bindings map keyed by `role||member`, an instances map). If it exists, **add an
     entry to that collection** — do not write a standalone resource alongside it.
  2. **A module that wraps this concern** — a local module, a registry/published module the repo
     already uses, or one in a sibling repo — call or extend it rather than re-implementing.
  3. **A root-module loop or established convention** for this resource type — follow it.
  4. **Only if none of the above fits**, author a new resource from scratch — and say so explicitly:
     name what you searched for (the map/module/loop) and why nothing could absorb the change.
- **Read before you write.** Match the surrounding structure, naming, and idioms.
- **Proportional effort.** Smallest change that fully solves it; don't reinvent or gold-plate.

## Cloud infrastructure
- Least privilege by default — explicit, scoped IAM; no broad/primitive roles.
- Consistent resource naming + labels/tags (owner, environment, cost-centre) on every resource.
- Remote state, per-environment isolation; environments parameterised, never hardcoded.
- Prefer keyless / workload-identity auth over long-lived credentials.

## Terraform
- Clear module structure; typed variables, documented outputs.
- Pin provider and module versions; no floating `latest`.
- No secrets in code, variables, or state inputs — source them from a secrets manager.
- `plan` before `apply`; `apply`/`destroy` are deliberate, reviewed actions — never automatic.
- Reuse existing/published modules over bespoke ones; extend, don't fork-and-drift.

## Code quality
- Readable and consistent with the surrounding code; clarity over cleverness.
- Small, focused changes; one concern at a time.
- DRY — factor duplication into shared modules/locals/helpers.
- Validate: format + lint + the project's tests (for Terraform: `fmt`, `validate`, then `plan`).
- Comment only the non-obvious; no dead or commented-out code.

## Security
- Never commit secrets, credentials, or identifying data — keep them out of code, inputs, and logs (rotate if exposed).
- Least privilege everywhere; restrict network egress; follow CIS-style hardening.
- No side-effecting commands (cloud mutations, `apply`/`destroy`, `git push`) without explicit human approval.
- Treat generated changes as **drafts for human review**.
