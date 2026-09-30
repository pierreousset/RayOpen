<div align="center">
  <img src="docs/logo.svg" width="112" height="112" alt="RayOpen logo: light through an open door" />
  <h1>RayOpen</h1>
  <p>Your macOS launcher. Your local translation. Your code.</p>
  <p><a href="LICENSE">MIT license</a> · <a href="CONTRIBUTING.md">Contributing</a> · <a href="SECURITY.md">Security</a></p>
</div>

RayOpen is an open-source native macOS launcher with local AI translation. Free to use, with no subscription or paid API required: find applications and translate directly from your keyboard.

**Everyone can use, modify, redistribute, and improve RayOpen** under the [MIT license](LICENSE). Models retain their own licenses; LM Studio and Ollama are separate applications.

- **⌘ Space** opens the compact launcher.
- **Search + Return** launches an app or opens translation.
- **Automatic translation** after a typing pause, with source text on the left and streamed results on the right.
- **Swap languages**, copy completed results, and see local server status.
- **LM Studio or Ollama**, with model selection and local preferences.

Built with SwiftUI/AppKit and no external dependencies. **macOS 14+ and Swift 6 tools** are required to build. The application currently uses French interface labels; this guide includes them where useful.

## Build and run

If Swift tools are missing, install them yourself with `xcode-select --install`.

```sh
./scripts/build-app.sh
open dist/RayOpen.app
```

The script creates an unsigned local bundle in `dist/`. It does not install or distribute the app or change system settings. For development, use `swift run`.

RayOpen appears as **◈** in the menu bar. **⌘ Space** shows or hides its panel. Escape hides the launcher; from translation, it returns to the launcher and cancels the request without copying. Quit through the menu bar.

Settings also offers Option + Space, Control + Option + Space, or disabling the shortcut. Registration errors are displayed separately from network errors. Another app may intercept a registered shortcut; use the menu bar if needed. RayOpen does not replace system shortcuts.

### If Spotlight uses ⌘ Space

In **System Settings → Keyboard → Keyboard Shortcuts → Spotlight**, disable **Show Spotlight search** or assign another shortcut. In RayOpen settings, choose **Retry**, or restart. Check other launchers for conflicts too. Successful registration confirms macOS accepted the shortcut, not that a keypress reached RayOpen. [Apple shortcut conflict help](https://support.apple.com/guide/mac-help/mchlp2864/mac).

The old Option + Space preference migrates once to Command + Space. Other selections are preserved; you can select Option + Space again afterward.

## Use the launcher

The dark, title-bar-free panel measures 780 × 520 points. Search, navigate with **↑ / ↓**, then press **Return** or click a row. Selection scrolls into view and search regains focus when the panel reopens.

Search **translation** or **translate**, then press Return to open translation with the source editor focused. Translation and settings are also accessible above the results. RayOpen indexes `/Applications`, `/System/Applications`, and `~/Applications` at startup. Restart after installing a new app.

## Set up LM Studio

1. Open LM Studio and load an existing chat model.
2. In **Developer**, choose **Start Server**. Check its address, usually `http://localhost:1234`. Keep the server listening locally. This MVP does not support authentication tokens.
3. In RayOpen settings, select **LM Studio**, enter the root URL **without `/v1`**, and choose **Detect models**. Select a loaded chat model.
4. Type or explicitly paste text in translation and choose a target language. Translation starts after a **500 ms typing pause**. New text or a language change immediately cancels the previous request. Results stream into the right column.

The server is checked whenever translation opens. An unreachable server, missing selection, or unloaded model blocks translation with an explanation and **Retry**. Start the server or load the model, then retry; translation resumes after verification. No server polling occurs on every keystroke.

LM Studio's `/api/v1/models` identifies loaded chat instances, falling back to `/api/v0/models` for older versions. `/v1/models` alone does not establish whether a model is loaded. [Official loaded-model API](https://lmstudio.ai/docs/developer/rest/list).

### Translation and clipboard

Two columns provide source and target language menus, explicit paste, a character count, and actual request duration. Set a custom target language in settings. The back button or Escape returns to the launcher; the gear opens settings. Results remain selectable during streaming, but **Copy** waits for completion.

**⌘ Space** closes translation and automatically copies a complete, nonempty result. During generation it cancels the request without changing the clipboard. Empty results also leave the clipboard unchanged. A small confirmation indicates copying succeeded. The next ⌘ Space reopens the launcher. The server may continue computing briefly after client cancellation.

### Swap languages

The **Source** menu offers Automatic or an explicit language, remembered between sessions. **⇄** swaps source and target. A completed translation becomes the new source, the old result clears, and translation starts again automatically. Without a completed result, the existing source remains. With Automatic selected, choose an explicit source language first: RayOpen cannot infer a detected language the model did not return.

### Models and translation quality

RayOpen downloads neither models nor runtimes. Install a model suitable for your Mac yourself. New configurations prefer `qwen2.5-1.5b-instruct`, the official Qwen Instruct variant; existing model preferences are preserved. Fine-tuned variants can differ from [official Qwen2.5-1.5B-Instruct](https://huggingface.co/Qwen/Qwen2.5-1.5B-Instruct). Interface or prompt changes do not fix an unsuitable model. Model selection and loading remain explicit.

The strict translation prompt uses temperature 0 and a generation limit proportional to the source (64–4096 tokens). Limits and interrupted streams are reported. Only completed results are automatically copied: technical completion does not establish linguistic accuracy.

For French, an example question helps small models preserve who is speaking and being addressed. This adjustment comes from local trials; mistakes with pronouns, tenses, and meaning remain possible. JSON encoding preserves source quotation marks and line breaks.

Speed depends on hardware, model, loading time, and text length. No latency is guaranteed. The displayed duration includes loading. Review translations before using them.

## Optional: Ollama

If installed, start Ollama or run `ollama serve`. Use an existing installed model (`ollama list`). In settings select **Ollama**, enter `http://localhost:11434`, and detect models. Ollama loads installed local models on request. RayOpen does not use Ollama Cloud; select a local model without a cloud suffix.

## Privacy and limitations

Text stays in RayOpen's memory and is sent only to the configured server on your Mac. That server may retain logs according to its settings. URLs are restricted to `localhost`, `127.0.0.1`, or `::1`. URL, model, language, and shortcut preferences are stored in UserDefaults; translation text is not.

Pasting is explicit. Copy and ⌘ Space from translation can write complete, nonempty results to the macOS clipboard, which other apps may read. Carbon shortcuts do not require Accessibility permission.

This MVP has no Raycast extensions, file search, OCR, automatic startup, signing, or automatic updates. Local models can mistranslate or invent content; review results.

## Open contributions, reviewed changes

Submit improvements through a fork and a **pull request targeting `main`**. The protected branch requires code-owner review, the **Build macOS** check, and resolved discussions. Direct pushes, force pushes, and deletion are blocked, including for administrators. New commits require renewed approval.

The owner cannot approve their own PR. Another authorized maintainer must be added as a code owner to review the owner's changes. Merging into `main` does not publish a production release; no automatic distribution is configured.

See [CONTRIBUTING.md](CONTRIBUTING.md) and [SECURITY.md](SECURITY.md). Review and checks reduce risk but cannot guarantee bug-free or vulnerability-free software.

## Official API references

- [LM Studio models](https://lmstudio.ai/docs/developer/openai-compat/models): `GET /v1/models`.
- [LM Studio chat](https://lmstudio.ai/docs/developer/openai-compat/chat-completions): `POST /v1/chat/completions`, streamed SSE.
- [Ollama models](https://docs.ollama.com/api/tags): `GET /api/tags`.
- [Ollama chat](https://docs.ollama.com/api/chat): `POST /api/chat`, newline-delimited streamed JSON.

Code license: [MIT](LICENSE).
