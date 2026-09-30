# Security

RayOpen is an early-stage project. Fixes target the latest code on `main`. There is no signed release or automatic update mechanism. Use a trusted source and review changes before rebuilding.

## Report a vulnerability

Do not post exploit details, secrets, or personal data in public issues or pull requests. Use GitHub **Security → Report a vulnerability** for private reports when available. Otherwise, open an issue asking only for a private reporting channel, without describing the vulnerability.

Privately provide the version or commit, reproduction steps, impact, and a suggested fix if possible. No response-time guarantee is offered.

## Scope and precautions

- RayOpen sends text to the configured loopback LM Studio or Ollama server. You control the server, model, logs, and their licenses.
- Keep servers accessible only from your Mac. RayOpen does not support their authentication.
- Preferences are local. Other apps may read the macOS clipboard; closing translation with ⌘ Space may copy a complete result.
- Models can invent content or follow instructions embedded in source text. The translation prompt is not a security boundary. Review results.
- Contributions must disclose changes to network access, permissions, storage, or dependencies. Pull requests and review reduce risk but do not guarantee the absence of vulnerabilities.

Ordinary translation quality issues may be reported publicly with nonsensitive examples. Report LM Studio, Ollama, or macOS vulnerabilities to their respective maintainers too.
