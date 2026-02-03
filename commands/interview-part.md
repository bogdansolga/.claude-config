---
name: interview-part
description: Generate questions for a single interview category
arguments:
  - name: part
    description: "Category: core, ai-ml, data, config, architecture, quality, processes"
    required: true
---

Generate a focused interview section for the specified category.

## Step 1: Auto-Detect Files

Scan current working directory for:
- `*.pdf` → Candidate CV
- `*.xlsx` → Competency model
- `*.md` or `Position*` → Position requirements

Use available files to tailor questions. Report if missing but proceed with generic questions.

## Step 2: Generate Section

Based on `$ARGUMENTS.part`, generate ONLY that section:

### `core` - Core Technology
```markdown
# Interview Part: Core Technology
**Candidate:** [Name] | **Date:** [Today]

## Primary Language ([detected])
| Question | Look for |
|----------|----------|
| [2-3 tailored questions] | [Signals] |

## Secondary Language
| Question | Look for |
|----------|----------|

## Web Framework ([detected])
| Question | Look for |
|----------|----------|
```

### `ai-ml` - AI & ML (Full Section)
```markdown
# Interview Part: AI & ML
**Candidate:** [Name] | **Date:** [Today]

## Architecture (RAG, Embeddings, Vector DBs)
| Question | Look for |
|----------|----------|
| What chunking strategies do you know? When would you use each? | Fixed-size, semantic, recursive, sentence-based; overlap trade-offs |
| Walk through your RAG architecture for [their project]. | Retrieval method, reranking, hybrid search |
| How do you select embedding models? | Dimension size, domain fit, cost |
| How do you architect hybrid search? | Vector + keyword, filtering strategies |

## Security
| Question | Look for |
|----------|----------|
| How do you prevent prompt injection? | Input validation, output sanitization, guardrails |
| How do you handle PII with LLMs? | Masking, on-prem, audit trails |
| What's your approach to AI red-teaming? | Adversarial testing, jailbreak prevention |

## LLMs & Frameworks
| Question | Look for |
|----------|----------|
| When LangChain vs direct API? | Trade-offs: abstraction, debugging, vendor lock-in |
| How do you evaluate LLM outputs? | Metrics, human loops, automated checks |
| Fine-tuning vs prompting vs RAG - how do you decide? | Cost, latency, accuracy trade-offs |
| [Tailored to their experience] | |

## Prompt Engineering
| Question | Look for |
|----------|----------|
| What prompting techniques do you use? | Zero/One/Few-shot, CoT, ReAct, ToT |
| How do you manage context window limits? | Summarization, sliding window, token budgeting |
| How do you get structured outputs? | Schema enforcement, output parsing |
| How do you iterate on prompts systematically? | Version control, A/B testing, evaluation sets |
```

### `data` - Data
```markdown
# Interview Part: Data
**Candidate:** [Name] | **Date:** [Today]

## Data Persistence (SQL & NoSQL)
| Question | Look for |
|----------|----------|
| [Tailored to their DB experience] | |

## Embeddings & Vector Databases
| Question | Look for |
|----------|----------|
| [Tailored to their vector DB experience] | |
```

### `config` - Configuration Management
```markdown
# Interview Part: Configuration Management
**Candidate:** [Name] | **Date:** [Today]

## Version Control / CI/CD
| Question | Look for |
|----------|----------|

## Clouds
| Question | Look for |
|----------|----------|
```

### `architecture` - Software Design & Architecture
```markdown
# Interview Part: Software Design & Architecture
**Candidate:** [Name] | **Date:** [Today]

## AI Architecture
| Question | Look for |
|----------|----------|

## MCP Servers
| Question | Look for |
|----------|----------|

## OOD
| Question | Look for |
|----------|----------|

## AI Security
| Question | Look for |
|----------|----------|
```

### `quality` - Code Quality & Best Practices
```markdown
# Interview Part: Code Quality & Best Practices
**Candidate:** [Name] | **Date:** [Today]

## Automated Testing
| Question | Look for |
|----------|----------|

## Monitoring & Observability
| Question | Look for |
|----------|----------|

## GenAI Productivity
| Question | Look for |
|----------|----------|
```

### `processes` - Processes
```markdown
# Interview Part: Processes
**Candidate:** [Name] | **Date:** [Today]

| Question | Look for |
|----------|----------|
```

## Step 3: Output

Save as: `Interview-Part-[Category]-[CandidateName]-[YYYY-MM-DD].md` in the current working directory.

Also display a summary in the conversation.
Keep it focused - this is for quick deep-dives during or between interviews.
