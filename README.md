# Intune Patch Compliance - PowerShell Script

## 📋 Overview

This PowerShell script helps you retrieve **patch compliance reports** from **Microsoft Intune**
Unlike native Intune reports that often focus on just the latest patch (`n`), this script gives you compliance insights up to **n-10 patch levels** (i.e., previous 10 patch cycles).

Ideal for IT admins who need detailed visibility into update compliance across multiple Intune-managed devices.

---

## 🚀 Features

- 🔍 Get compliance data for latest (`n`) to `n-10` monthly patches
- 📊 Identify devices that are:
  - Compliant with the latest patch
  - Missing one or more updates
  - Stuck or pending reboots
- 📁 Export results to CSV or log file (optional)
- 🛠 Supports automation and scheduling

---

## 💻 How to Use

1. **Clone this repo**
   ```bash
   git clone https://github.com/yourusername/intune_patch_compliance_PS.git
   cd intune_patch_compliance_PS
   ```
