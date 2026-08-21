# Resume Style Notes

Rules the resume bullets are written against, so future variants stay
consistent instead of drifting back into job-description prose.

## The bullet formula

**[Strong action verb] + [what you built or owned] + [customer/business context]
+ [measurable outcome]**

Equivalently, Laszlo Bock's XYZ formula (ex-Google SVP of People Ops):
*"Accomplished **X** as measured by **Y** by doing **Z**."*

The single most common failure is writing the **Z** (the activity) and stopping.
A bullet that names only what you did is a job description. A bullet that names
what changed because you did it is an accomplishment.

## Lead with the outcome, not a category label

Phrases like "Own the full customer loop," "Responsible for," "Worked on," and
"Helped with" are **category labels**. They tell the reader which bucket the
work belongs to and nothing about what happened. Replace the label with the
result.

- ✗ "Own the full customer loop for an end-to-end vision/audio system."
- ✓ "Deployed a real-time vision/audio system into 5 operatories across 2
  customer offices, running every on-site install personally."

## What to quantify

For a forward-deployed / customer-facing role, the metrics that land are
**field metrics**, not code metrics:

- time to production / time to first value
- manual effort removed
- number of sites, rooms, devices, or data sources
- users or staff trained
- incidents caught, detection time, MTTR
- adoption

A number does two things at once: it proves the impact was real, and it signals
you cared enough to track it.

## No bold inside bullets

Bold is reserved for **structure**, not emphasis:

- **Bold:** section headings, job titles, degree lines, and the leading title of
  a project or leadership item.
- **Not bold:** anything inside the body of a bullet.

Emphasis-bolding a phrase mid-sentence ("**Eliminated the deployment's
dependence on customer Wi-Fi** after ...") is a way of compensating for a bullet
that doesn't lead with its own point. If the accomplishment needs bold to be
noticed, move it to the front of the sentence instead. Scattered bold also
degrades a scan: when six phrases per page are bold, none of them are.

## No em dashes in bullets

Don't use `---` (LaTeX) or `—` to bolt a clause onto a bullet. Restructure the
sentence instead: subordinate the clause with a participle ("reconfiguring each
Orange Pi..."), join it with a semicolon, or make it a preposition
("across sensors, inference, and infrastructure").

An em dash is usually a sign the bullet was assembled rather than written --- two
half-thoughts stapled together. Removing it forces the grammatical relationship
between the clauses to be explicit, which almost always reads tighter.

Em dashes remain fine in section labels and role titles, where they act as a
separator rather than as punctuation inside prose.

## Structural rules

- **"I," never "we."** Ambiguous credit reads as borrowed credit.
- **Don't pass prototypes off as production.** Say which is which; the contrast
  between "prototyped" and "shipped and operate" is itself a signal.
- **Don't bury customer exposure.** If you sat with the customer, that belongs in
  the first clause, not a trailing parenthetical.
- **One idea per bullet.** If a bullet contains two verbs joined by "and also,"
  it's two bullets.
- **Keep it to one page** unless you have 8+ years of directly relevant
  experience.
- **Plain layout.** Multi-column and text-in-graphics layouts break ATS parsing.

## Section order

For customer-facing engineering roles: **Contact → Summary → Skills → Experience
→ Projects → Education**. Skills sits above Experience so the required
keywords (here: Python, SQL, LLMs, observability) are visible in the first
few seconds of a scan, which matters when the posting lists hard requirements.

For a conventional SWE role, the base resume's order (Experience first) is
still the safer default.

## Sources

- [TechieCV — Forward-Deployed Engineer Resume: Complete 2026 Guide](https://www.techiecv.com/resume-guides/forward-deployed-engineer-resume) — the five-level bullet progression (task → techniques → tools → method → metric) and field-impact metrics.
- [Exponent — Forward Deployed Engineer Resume: Examples & Skills](https://www.tryexponent.com/blog/forward-deployed-engineer-resume) — bullet formula, before/after examples, section order, ATS mistakes.
- [Teal — How To Use the XYZ Method Resume](https://www.tealhq.com/post/xyz-resume) — the XYZ formula and its Google provenance.
- [Exponent — Forward Deployed Engineer Interview: The Definitive 2026 Guide](https://www.tryexponent.com/blog/forward-deployed-engineer-interview-the-definitive-2026-guide-fde) — what FDE hiring managers screen for (T-shaped profile, customer ownership).
