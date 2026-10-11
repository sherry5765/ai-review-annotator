# AI Review Annotator

A small Python desktop app that uses Claude to label customer reviews with a sentiment, a category and a one-sentence summary, then exports the results to CSV.

## Features

- Load a CSV of reviews or paste them in (one per line)
- Claude returns **sentiment** (positive / neutral / negative), **category** (shipping, product quality, pricing, account/service, other) and a **one-sentence summary** for every row
- Results appear in a sortable-looking table with color-coded rows
- Runs API calls in a background thread, with a progress bar, so the window never freezes
- Strict JSON replies, validated before use; bad JSON, API errors and empty rows are handled per row and never crash the app
- Export the annotated results to a new CSV (opens cleanly in Excel)
- API key is read from an environment variable and never stored in code

## Setup (Windows)

1. Install [Python 3.9+](https://www.python.org/downloads/) (Tkinter is included; keep "tcl/tk" ticked in the installer).
2. Open PowerShell in the project folder and create a virtual environment:

   ```powershell
   python -m venv .venv
   .venv\Scripts\Activate.ps1
   ```

3. Install the dependency:

   ```powershell
   pip install -r requirements.txt
   ```

## Set your API key

Get a key from the [Anthropic Console](https://console.anthropic.com/), then set it as an environment variable.

For the current PowerShell session only:

```powershell
$env:ANTHROPIC_API_KEY = "your-key-here"
```

Or permanently (close and reopen the terminal afterwards):

```powershell
setx ANTHROPIC_API_KEY "your-key-here"
```

The app reads `ANTHROPIC_API_KEY` from the environment. It does not load `.env` files; `.env` is only in `.gitignore` as a safety net so a key never gets committed.

## Run

```powershell
python app.py
```

Click **Load CSV** and pick `sample_reviews.csv` (or **Paste Reviews**), then **Analyze**, then **Export CSV**.

### CSV format

One review per row. If a column is named `review`, `text`, `message`, `comment`, `feedback` or `body`, that column is used; otherwise the first column is used. Blank rows are skipped.

## What I learned

_Edit this section before publishing. Ideas:_

- How to call the Anthropic API from Python and ask for strict JSON
- Why model output must be validated before it is trusted
- Keeping a Tkinter window responsive with a worker thread and a queue
- Handling failures per row so one bad response doesn't stop the batch
