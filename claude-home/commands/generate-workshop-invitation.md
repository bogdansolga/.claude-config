# Generate Workshop Invitation Email

Generate a professional invitation email for an AI training workshop or introductory session.

## Context

This command creates invitation emails for "AI for Business Leaders" training programs. The emails are sent by an organizing company to their corporate client list (mixed audience: HR/L&D departments and C-level/senior management).

## Workshop Program Overview

The full program is a 2-day "AI for Business Leaders: Strategy & Integration Course" covering:

**Day 1: AI Fundamentals & Business Opportunities**
- AI overview and sub-domains (ML, DL, NLP, CV, GenAI)
- AI opportunity mapping workshop
- Developing actionable AI use-cases
- Evaluating AI tools
- Responsible AI principles

**Day 2: AI Integration Strategies & Implementation**
- Strategic prioritization of AI initiatives
- Data foundations for AI success
- Practical integration pathways
- Crafting AI business cases
- Roadmap development

**Core Workshop Methodology (3-step framework):**
1. **Identify opportunities** – map processes with AI integration potential
2. **Score and analyze** – objective evaluation using 5 criteria (Volume, Repetition, Data, Rules, Impact)
3. **Prioritize and roadmap** – select top 3 initiatives and outline next steps

## Email Requirements

**Target audience:** Business leaders, project managers, business analysts, and strategic decision-makers involved in technology adoption.

**Value proposition hooks (use 2-3):**
- Cut through AI hype – understand what actually works for your business
- Discover actionable AI opportunities without massive investment
- Equip leaders to make informed AI decisions
- The "5 Ws" approach: What is AI, Why now, Where to adopt, Who should be involved, When to act

**Key insight:** Business leaders want their people prepared with AI knowledge to participate in AI conversations and decisions confidently.

**Tone:** Formal/corporate Romanian (using "dumneavoastră"), professional but not dry.

## Output Format

Generate the email in **Romanian** (unless otherwise specified) with:

1. **Subject line** – concise, includes "AI" and session type
2. **Opening** – greeting + value proposition (2-3 sentences)
3. **Session content** – bullet points of what attendees will learn (use 5Ws framework)
4. **Methodology preview** – brief mention of the 3-step approach
5. **Practical details table** – with placeholders:
   - [DATA] – date
   - [ORA] – time
   - [LOCAȚIE] – location (or "Online" if virtual)
   - [DURATĂ] – duration
   - [TRAINER] – trainer name/bio
   - [COMPANIE ORGANIZATOARE] – organizing company
6. **Target audience** – who should attend
7. **Registration CTA** – [INSTRUCȚIUNI ÎNSCRIERE / LINK]
8. **Closing** – mention of full 2-day course as next step
9. **Summary banner** – one-line recap at the bottom

## Session Types

Adapt content based on session type:

| Type | Duration | Content Depth | Goal |
|------|----------|---------------|------|
| **Intro/Teaser** | 1-1.5 hours | High-level overview, methodology preview | Lead generation for full course |
| **Half-day workshop** | 3-4 hours | One full exercise from methodology | Standalone value + upsell |
| **Full course promo** | N/A | Detailed curriculum description | Direct enrollment |

## User Input

$ARGUMENTS

If no arguments provided, generate a **free introductory session (1-1.5 hours)** invitation as the default.

Optional parameters the user can specify:
- Session type (intro/half-day/full)
- Duration
- Free or paid
- Specific focus area
- Language override (default: Romanian)
- Any specific details to include
