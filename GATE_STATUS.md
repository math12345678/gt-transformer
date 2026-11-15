# Gate Status — gt-transformer-web Hardening

## Gate — Milestone 3 Iteration 2
| Agent | Role | Verdict | Source | Notes |
|-------|------|---------|--------|-------|
| worker_m3_gen2 | teamwork_preview_worker | DONE | handoff.md | Adjusted test_16 Sarbecovirus timing assertion to pre-M4 baseline, relaxed isolated clone timeout to 240s, all 48/48 tests PASS, commit 96684ca |
| reviewer_m3_1 | teamwork_preview_reviewer | APPROVE | handoff.md | Validation gateway & error codes, 0 alert() calls, web live 4/4 PASS, core suites 5/5 PASS, standalone portability PASS |
| reviewer_m3_iter2_2 | teamwork_preview_reviewer | APPROVE | handoff.md | Battery 2 19/19 PASS (31.1s), portability 4/4 PASS (88.5s), challenger stress 21/21 PASS (15.0s), 0 alert() calls, web live 4/4 PASS |
| challenger_m3_1 | teamwork_preview_challenger | APPROVE | handoff.md | 21-battery empirical test harness 21/21 PASS; boundary attacks; zero unhandled 500 tracebacks |
| challenger_m3_2 | teamwork_preview_challenger | APPROVE | handoff.md | Biological sensitivity (test_neisseria bp=204, honest attribution), Sarbecovirus scaling, RNA support, Battery 1 null 5/5 PASS |
| auditor_m3_1 | teamwork_preview_auditor | CLEAN | handoff.md | Zero hardcoding, dynamic parsimony informative site counts, authentic HTTP 400/422 flows, clean working tree |

Gate Result: **PASS**

All Milestone 3 criteria satisfied:
- Structured input validation gateway returning RFC-compliant HTTP 400 (empty/binary) and HTTP 422 (unaligned, panel < 4, sites < 10, all-gaps)
- Empirical alignment support: RNA $U \to T$ normalization with `is_rna=True` telemetry; gap-tolerant fallback for scattered gaps $\le 25\%$
- Linear zero-padding for short alignments ($M_{tx} < 314$) eliminating circular wraparound distortion while preserving authentic biological sensitivity (Neisseria $bp=204$)
- Short-alignment corroboration gate ($z \ge 10.5, best\_sw \ge 2.0$) suppressing false positives on clonal controls
- Non-blocking error banners (`#globalErrorBanner`, `#uploadModalErrorBanner`) with 0 `alert()` dialogs remaining
- Diagnostic honesty: OOD warnings rendered in `#diagnosticsWarningsBox` and `#sumWarningsTag`, `.tag-attribution` badges displaying `flank_kl_heuristic_only`, `hybrid_flank`, and `transformer_corroborated`
- Automated verification: Battery 2 (19/19 PASS), Battery 1 (5/5 PASS), Challenger Stress (21/21 PASS), Live Web (4/4 PASS), Standalone Portability (4/4 PASS), Core Invariants (100% PASS)
- Clean commit `96684ca` on `main`

---

## Gate — Milestone 3 Iteration 1
| Agent | Role | Verdict | Source | Notes |
|-------|------|---------|--------|-------|
| worker_m3_1 | teamwork_preview_worker | DONE | handoff.md | Validation gateway, empirical alignments (RNA, gaps, linear zero-padding), non-blocking UI error banners, commit d45de7b |
| reviewer_m3_1 | teamwork_preview_reviewer | APPROVE | handoff.md | Validation gateway & error codes, 0 alert() calls, web live 4/4 PASS, core suites 5/5 PASS, standalone portability PASS |
| reviewer_m3_2 | teamwork_preview_reviewer | REQUEST_CHANGES | handoff.md | test_battery_2_empirical.py fails on test_16 (assertLess 5000ms on 30.6kb Sarbecovirus; latency belongs to M4); test_portability timeout fragility |
| challenger_m3_1 | teamwork_preview_challenger | APPROVE | handoff.md | 21-battery empirical test harness 21/21 PASS; boundary attacks; zero unhandled 500 tracebacks; noted premature 5000ms assertion in test_16 |
| challenger_m3_2 | teamwork_preview_challenger | APPROVE | handoff.md | Biological sensitivity (test_neisseria bp=204, honest attribution), Sarbecovirus scaling, RNA support, Battery 1 null 5/5 PASS |
| auditor_m3_1 | teamwork_preview_auditor | CLEAN | handoff.md | Zero hardcoding, dynamic parsimony informative site counts, authentic HTTP 400/422 flows, clean working tree |

Gate Result: **FAIL** (reviewer_m3_2 REQUEST_CHANGES on test_battery_2_empirical.py:176 assertion and attestation)

---

## Gate — Milestone 2 Iteration 1
| Agent | Role | Verdict | Source | Notes |
|-------|------|---------|--------|-------|
| worker_m2_gen2 | teamwork_preview_worker | DONE | handoff.md | Standalone packaging of gt_core (7 modules + __init__.py), checkpoints/ (2.29MB), sample_data/ (10 FASTAs), benchmark_data/, dynamic run_server.sh, commit 4e0210f |
| reviewer_m2_1 | teamwork_preview_reviewer | APPROVE | handoff.md | gt_core relative imports, haldec.py:496 eff_min preservation, sys.modules aliasing, web live 4/4 PASS, portability 4/4 PASS, core 5/5 PASS |
| reviewer_m2_2 | teamwork_preview_reviewer | APPROVE | handoff.md | run_server.sh dynamic Python resolution, requirements.txt (9 minimal pkgs), battery 1 null 5/5 PASS (462.5s), isolated /tmp execution PASS |
| challenger_m2_1 | teamwork_preview_challenger | APPROVE | handoff.md | Empirical isolated portability challenge in /tmp/challenger_m2_env; server boot on port 8877; live HTTP API verified on presets and raw FASTAs |
| challenger_m2_2 | teamwork_preview_challenger | APPROVE | handoff.md | Zero regressions: battery 1 null 5/5 PASS, test_neisseria bp=204, d048 2 events, d005 3 events, adversarial edge recall 72.5%, short tract 88.9% |
| auditor_m2_1 | teamwork_preview_auditor | CLEAN | handoff.md | Zero hardcoding, dynamic checkpoint scanning, genuine JAX PyTree weights (SHA256 match), zero mock stubs, clean working tree |

Gate Result: **PASS**

All Milestone 2 criteria satisfied:
- Self-contained packaging in `web/gt_core/` (7 modules with PEP 328 relative imports + module aliasing)
- Bundled default checkpoint `web/checkpoints/ckpt_N10000_extreme/params.pkl` (~2.29 MB)
- Bundled sample FASTAs in `web/sample_data/` and summaries in `web/benchmark_data/`
- Portable boot script `web/run_server.sh` with 5-step dynamic Python locator
- Standalone execution verified in isolated `/tmp` directory with detached parent monorepo
- Clean commit `4e0210f` on `main`

---

## Gate — Milestone 1 Iteration 3
| Agent | Role | Verdict | Source | Notes |
|-------|------|---------|--------|-------|
| worker_m1_iter3_1 | teamwork_preview_worker | DONE | handoff.md | Fixed haldec.py:491 eff_min, distinct parent check, multi-site contiguous tract evidence, negative logit veto, M_tx < 314 short alignment gate, schema field fix |
| reviewer_m1_iter3_1 | teamwork_preview_reviewer | APPROVE | handoff.md | 4/4 web live PASS, 5/5 battery 1 null PASS (0 FPs on ext_0101, homoplasy, permuted), 5/5 core suites PASS, 0 shortcuts/bypasses |
| reviewer_m1_iter3_2 | teamwork_preview_reviewer | APPROVE | handoff.md | Distinct parent check + contiguous tract support verified, test_neisseria preserved at bp=204 with honest flank_kl attribution |
| challenger_m1_iter3_2 | teamwork_preview_challenger | APPROVE | handoff.md | Planted edges 72.5% recall, short tracts 88.9% recall, d048 (2 events) & d005 (3 events) preserved without regression |
| auditor_m1_iter3_1 | teamwork_preview_auditor | CLEAN | handoff.md | Zero bypasses, zero hardcoding, authentic vector math verified |

Gate Result: **PASS**

All Milestone 1 criteria satisfied:
- Pure i.i.d. random FASTAs: 15/15 runs clean (0 FPs)
- Column-permuted biological FASTAs (d048, d005, ext_0076): 0 events under flank_kl and hybrid_flank
- Clonal negative controls (d00005, d047, ext_0101): 0 events
- Convergent homoplasy stress (15 unlinked SNPs): 0 events
- Biological sensitivity preserved (test_neisseria bp=204, d048 2 events, d005 3 events)
- Core coordinate and likelihood invariants: 100% PASS

---

## Gate — Milestone 1 Iteration 2
| Agent | Role | Verdict | Source | Notes |
|-------|------|---------|--------|-------|
| worker_m1_iter2_gen2 | teamwork_preview_worker | DONE | handoff.md | 4/4 web live tests pass, 5/5 core suites pass, 15/15 random nulls clean 0 |
| reviewer_m1_iter2_1 | teamwork_preview_reviewer | REQUEST_CHANGES | handoff.md | ext_0101 emits 2 FPs, convergent homoplasy emits 4 FPs (M_tx < 314 & z >= 8.0 filter bypass) |
| reviewer_m1_iter2_2 | teamwork_preview_reviewer | APPROVE | handoff.md | Mathematical model sound, deadzone relief b>=3 verified, 0 NaNs/IndexErrors |
| challenger_m1_iter2_1 | teamwork_preview_challenger | REJECT | handoff.md | Confirms ext_0101 2 FPs and homoplasy 4 FPs; no bypass found |
| challenger_m1_iter2_2_repl | teamwork_preview_challenger | APPROVE | handoff.md | 75% edge recall, 88.9% short tract recall, 100% carrier ID, z>35 on deadzone boundaries |
| auditor_m1_iter2_1 | teamwork_preview_auditor | CLEAN | handoff.md | Zero shortcuts/bypasses, zero hardcoding, authentic vector math |

Gate Result: **FAIL** (reviewer_m1_iter2_1 REQUEST_CHANGES, challenger_m1_iter2_1 REJECT)
