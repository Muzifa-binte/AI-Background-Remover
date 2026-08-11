# Contributing to AI Background Remover

> This guide applies to all four repositories in the project.
> Read this before making any commit or pull request.

---

## Repository Overview (Read First)

This project has **4 Git repositories**:

| Repo | What it is |
|------|-----------|
| `AI-Background-Remover` | Parent repo — ties everything together via submodules |
| `AI-Background-Remover-frontend` | React UI (submodule at `frontend/`) |
| `AI-Background-Remover-backend` | FastAPI server (submodule at `backend/`) |
| `AI-Background-Remover-AI` | AI pipeline (submodule at `AI-Background-Remover-AI/`) |

**You always work inside a submodule repo**, not the parent.
The parent repo only gets touched when updating a submodule pointer (Commander does this).

---

## Which Repo Do I Work In?

| If you are on... | Work inside... |
|-----------------|---------------|
| Web Team (UI) | `AI-Background-Remover-frontend` |
| Web Team (API) | `AI-Background-Remover-backend` |
| AI Team | `AI-Background-Remover-AI` |
| ML Team | `AI-Background-Remover-AI` (inside `research/` subfolder) |

---

## Branch Naming

Always create a new branch. Never commit directly to `main`.

```
<type>/<short-description>
```

| Type | Use for |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code change with no feature/fix |
| `style` | CSS/UI-only change, no logic |
| `docs` | Documentation only |
| `chore` | Config, dependencies, tooling |
| `test` | Adding or fixing tests |
| `research` | ML Team experiments (AI repo only) |

**Examples:**
```
feat/auth-login-page
fix/upload-validation-error
refactor/inference-model-caching
style/dark-mode-navbar
docs/api-reference-update
research/birefnet-benchmark
```

---

## Commit Message Format

```
<type>(<scope>): <short description>
```

- Keep it under 72 characters.
- Use present tense: "add" not "added", "fix" not "fixed".
- Scope is optional but helpful.

**Examples:**
```
feat(upload): add drag-and-drop file validation
fix(history): serialise datetime to ISO string
refactor(inference): cache model session on startup
docs(api): add DELETE /image/{id} response examples
chore(deps): pin torch to 2.3.1
research(birefnet): add IoU benchmark vs rembg baseline
```

---

## Pull Request Rules

1. **One feature per PR.** Keep PRs small and focused.
2. **Target `main`** of your submodule repo.
3. **PR title** follows the same format as commit messages.
4. **PR description** must include:
   - What changed and why
   - How to test it
   - Screenshots for UI changes
   - Any environment variable changes
5. **No force pushes** to `main`.
6. **At minimum one review** before merging (Commander reviews all PRs during the solo phase).

---

## Git Workflow Step by Step

### Starting a new task

```bash
# Make sure you are inside the right submodule folder
cd frontend          # or backend / AI-Background-Remover-AI

# Pull latest main
git checkout main
git pull origin main

# Create your feature branch
git checkout -b feat/your-feature-name
```

### While working

```bash
# Stage specific files (not git add .)
git add src/components/YourComponent.tsx

# Commit with a clear message
git commit -m "feat(component): add YourComponent with accessibility"

# Push your branch
git push -u origin feat/your-feature-name
```

### Opening a PR

1. Go to the submodule repo on GitHub.
2. GitHub will show a banner: "Compare & pull request" — click it.
3. Fill in the description.
4. Assign Commander as reviewer.
5. Submit.

### After the PR is merged

```bash
# Clean up locally
git checkout main
git pull origin main
git branch -d feat/your-feature-name
```

---

## Updating the Parent Repo (Commander Only)

After a submodule's `main` gets new commits merged, update the parent pointer:

```bash
# Inside the parent repo root
cd frontend
git pull origin main
cd ..

git add frontend
git commit -m "chore: update frontend submodule to latest main"
git push
```

Repeat for `backend` or `AI-Background-Remover-AI` as needed.

---

## Submodule Clone Reminder

If someone clones the parent repo and the submodule folders are empty:

```bash
git submodule update --init --recursive
```

---

## Environment Variables

- Never commit `.env` files.
- `.env` is in `.gitignore` in each submodule.
- Each submodule has its own `.env.example` — update it when you add a new variable:

| Submodule | Config file |
|-----------|------------|
| `frontend/` | `frontend/.env.example` |
| `backend/` | `backend/.env.example` |
| `AI-Background-Remover-AI/` | `AI-Background-Remover-AI/.env.example` |

---

## File Size Rules

- **Never commit model weight files** (`.onnx`, `.pth`, `.pt`) to Git.
- Add them to `.gitignore` and store them separately (Google Drive, Hugging Face Hub, or S3).
- Images in `uploads/` and `output/` are also gitignored.

---

## Code Style

### Python (Backend + AI)
- Follow PEP 8.
- Type-hint all function signatures.
- Docstrings on every public function.
- `async` for all FastAPI route functions and services.

### TypeScript / React (Frontend)
- Strict TypeScript — no `any` unless unavoidable.
- One component per file.
- Props interface defined above the component.
- `aria-label` on all interactive elements.
- No hardcoded hex values — use Tailwind tokens only.

---

## Questions

Open a GitHub Discussion in the parent repo, or reach the Commander directly.
