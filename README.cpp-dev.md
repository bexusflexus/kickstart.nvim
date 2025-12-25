# 🚀 Kickstart.nvim — C++ Development Environment (Custom Extension)

> **Author:** Kevin Harris  
> **Based on:** kickstart.nvim  
> **Purpose:** A full-featured C++23/C++26 Neovim IDE powered by modern tooling: clangd, LLDB, Treesitter, Telescope FZF, Neo-tree, Aerial, Conform, and more.

This document describes the **C++-focused layer** I added on top of Kickstart.nvim.  
The goal: a *fast*, *minimal*, but *professional-grade* C++ IDE inside Neovim.

---

# 📑 Table of Contents

1. [Overview](#overview)  
2. [Features](#features)  
3. [Installation](#installation)  
4. [Directory Structure](#directory-structure)  
5. [Keybindings](#keybindings)  
6. [C++ Workflow](#c-workflow)  
7. [Troubleshooting](#troubleshooting)

---

# 🧩 Overview

This configuration turns Neovim into a complete C++ development platform with:

- Modern LSP (clangd 21)
- Intelligent completion and inline hints
- Debugging via LLDB + DAP UI
- File tree and symbol outline
- Instant fuzzy search for everything
- Auto-formatting with clang-format
- Diagnostics and error navigation
- Treesitter syntax & structural parsing

Designed for:

- C++23 & C++26 development  
- System programming  
- Engine code  
- High-performance applications  
- Multi-platform builds (Fedora, macOS, WSL, Pop!_OS)  

---

# 🔧 Features

## 💡 C++ Language Support
- **clangd_extensions.nvim**  
  Enhances clangd with:
  - Inline type hints  
  - AST insights  
  - Memory usage views  
  - Quick type info  

- **System clangd**  
  Uses your **Fedora clangd 21**, not Mason's version.

- **C++ Formatting via conform.nvim**  
  - Autoformats on save with clang-format  
  - Style: LLVM (default)  
  - Can customize globally or per-project  

---

## 🐞 Debugging (LLDB)
Built on:

- `nvim-dap`
- `nvim-dap-ui`

Features:
- Breakpoints  
- Variable and watch windows  
- Call stack viewer  
- Auto-open debugging layout on start  
- Uses `/usr/bin/lldb-vscode` on Fedora  

---

## 🗂 Navigation & Project Tools

### 🔍 Telescope + FZF Native
- File search  
- Live grep  
- Help search  
- Symbol search  
- Buffer search  
- Open-file-only grep  

FZF-native provides **instant** filtering.

### 📂 Neo-tree
- File explorer on the left  
- Replaces NERDTree/NetRW  
- Toggle: `<leader>e`

### 🧭 Aerial
- Code outline popup  
- Useful for large C++ classes and complex hierarchies

---

# 🛠 Installation

Clone your Kickstart fork:

```bash
git clone https://github.com/bexusflexus/kickstart.nvim ~/.config/nvim
