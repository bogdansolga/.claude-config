---
name: interview-prep
description: Generate succinct interview guide from folder contents (CV, competency model, position)
---

You are an expert technical interviewer. Generate a succinct, easy-to-scan interview guide.

## Step 1: Auto-Detect Files

Scan the current working directory for:
- `*.pdf` → Candidate CV
- `*.xlsx` → Competency model (parse "Core Interview" sheet for competencies)
- `*.md` or `Position*` → Position requirements

If any file type is missing, report which ones and use AskUserQuestion to request paths.

## Step 2: Extract Context

**From CV:**
- Name, current role, years of experience
- Key technical skills and technologies
- Relevant projects and achievements
- Areas to probe (claims that need validation)

**From Position doc:**
- Role title and level
- Required skills and responsibilities
- Determine if GVL/Adoption Leader role (include scenario) or other role (skip scenario)

**From Competency Excel ("Core Interview" sheet):**
Extract competency categories to ensure coverage:
- Core Technology: Primary Language, Secondary Language, Web Framework
- LLMs: Prompt Engineering, LLMs & Frameworks, RAG
- Data: Data Persistence (SQL & NoSQL), Embeddings & Vector Databases
- Configuration Management: Version Control/CI/CD, Clouds
- Software Design & Architecture: AI Architecture, MCP Servers, OOD, AI Security
- Code Quality & Best Practices: Automated Testing, Monitoring & Observability, GenAI Productivity
- Processes

## Step 3: Generate Interview Guide

**Output format:** Two-column tables (Question | Look for)

**Structure:**

```markdown
# Interview: [Candidate Name]
**Position:** [Role] | **Date:** [Today] | **Duration:** 90 min

## Candidate Summary
- [Key experience in 1 line]
- [Strengths to validate]
- [Gaps/claims to probe]

---

## 1. Core Technology

### 1.1 Primary Language ([detected from CV/position])
| Question | Look for |
|----------|----------|
| [Tailored question] | [Key signals] |

### 1.2 Secondary Language
| Question | Look for |
|----------|----------|

### 1.3 Web Framework ([detected])
| Question | Look for |
|----------|----------|

---

## 2. AI & ML

### 2.1 Architecture (RAG, Embeddings, Vector DBs)
| Question | Look for |
|----------|----------|
| What chunking strategies do you know? When would you use each? | Fixed-size, semantic, recursive, sentence-based; overlap trade-offs |
| Walk through your RAG architecture for [their project]. | Retrieval method, reranking, hybrid search |
| How do you select embedding models? What trade-offs? | Dimension size, domain-specific vs general, cost |
| [Tailored to CV] | |

### 2.2 Security
| Question | Look for |
|----------|----------|
| How do you prevent prompt injection? | Input validation, output sanitization, guardrails |
| How do you handle PII/sensitive data with LLMs? | Data masking, on-prem options, audit trails |

### 2.3 LLMs & Frameworks
| Question | Look for |
|----------|----------|
| When do you use LangChain vs direct API calls? | Trade-offs: abstraction vs control, debugging |
| How do you evaluate LLM outputs in production? | Metrics, human feedback loops, automated checks |
| [Tailored to their framework experience] | |

### 2.4 Prompt Engineering
| Question | Look for |
|----------|----------|
| What prompting techniques do you use and when? | Zero/One/Few-shot, CoT, ReAct, Tree-of-Thought |
| How do you manage context window limitations? | Summarization, sliding window, token budgeting |
| How do you structure prompts for complex outputs? | Schema enforcement, iterative refinement |

---

## 3. Data

### 3.1 Data Persistence (SQL & NoSQL)
| Question | Look for |
|----------|----------|
| [Tailored to their DB experience] | |

### 3.2 Embeddings & Vector Databases
| Question | Look for |
|----------|----------|
| [Tailored to their vector DB experience] | |

---

## 4. Configuration Management

### 4.1 Version Control / CI/CD
| Question | Look for |
|----------|----------|

### 4.2 Clouds
| Question | Look for |
|----------|----------|
| [Tailored to their cloud experience] | |

---

## 5. Software Design & Architecture

### 5.1 AI Architecture
| Question | Look for |
|----------|----------|

### 5.2 MCP Servers
| Question | Look for |
|----------|----------|

### 5.3 OOD
| Question | Look for |
|----------|----------|

### 5.4 AI Security
| Question | Look for |
|----------|----------|

---

## 6. Code Quality & Best Practices

### 6.1 Automated Testing
| Question | Look for |
|----------|----------|
| How do you test LLM-powered features? | Non-determinism handling, evaluation harnesses |

### 6.2 Monitoring & Observability
| Question | Look for |
|----------|----------|
| What's your observability stack for LLM apps? | Token usage, latency, cost tracking |

### 6.3 GenAI Productivity
| Question | Look for |
|----------|----------|

---

## 7. Processes
| Question | Look for |
|----------|----------|

---

## Appendix: Scenario (if GVL/Adoption Leader role)
[Include only if position indicates GVL/Adoption Leader/Enablement role]

**Setup:** [Brief scenario - 1 paragraph]

| Probe Point | Look for |
|-------------|----------|
| Discovery approach | Stakeholder mapping, champion identification |
| Prioritization | Criteria for pilot selection |
| Resistance handling | Pragmatic, not dismissive |
| Handoff planning | Sustainability, documentation |
```

## Step 4: Tailor Questions

For each category:
1. Check CV for relevant experience → reference specific projects/claims
2. Check position requirements → weight toward required skills
3. Generate 1-2 questions per subcategory (keep it scannable)
4. Include specific "Look for" signals based on seniority level

## Step 5: Output

Save as: `Interview-[CandidateName]-[YYYY-MM-DD].md` in the current working directory.

Keep total length under 150 lines for easy scanning during interview.
