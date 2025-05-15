# 📋 Intune Patch Compliance Report Generator

This PowerShell script generates a report detailing the patching compliance of Intune-managed devices. It retrieves patch information from Microsoft’s website and compares it against device data from a CSV file to determine compliance status.

---

## 🎯 Purpose

The script automates the process of assessing Intune device patch compliance by:

- Importing device information from a CSV file.
- Downloading and parsing a list of Microsoft patches.
- Comparing device OS versions to the latest patches to determine compliance.
- Generating a comprehensive CSV report with compliance status, missing patches, and device details.

---

## ⚙️ Usage

### 1. User Input

Modify the following variables at the beginning of the script:

```powershell
$DeviceList           # Path to the CSV file containing Intune device data.
$WorkingFolder        # Directory to store intermediate and final report files.
$ReportingMonthInput  # Reporting month relative to the latest Patch Tuesday ("N", "N-1", etc.).
```

> **Note:** The CSV must contain columns such as `"Device ID"`, `"Serial number"`, `"Device name"`, `"OS version"`, etc.  
> Adjust `Select-Object` accordingly if your column headers differ.

---

### 2. Execution

Run the script using PowerShell. It will:

- Create the working folder if it doesn’t exist.
- Download patch information from Microsoft’s support site.
- Generate the following files in the working folder:
  - `MicrosoftPatchList.csv`
  - `MicrosoftLatestPatchList.csv`
  - `Final_Patching_Report.csv` ✅ _(Final compliance report)_

---

### 3. Output

- The final report (`Final_Patching_Report.csv`) includes:
  - Device details
  - OS versions
  - Patch status: `Compliant`, `Non-Compliant`, or `Manually Check`
  - Days since last patch
- A summary dashboard is displayed in the console.

---

## 🔑 Key Components

- **📥 Data Import**:  
  Uses `Import-Csv` and `Select-Object` to read device data.

- **🌐 Patch Data Acquisition**:  
  Scrapes patch data from Microsoft support pages.  
  ⚠️ _Fragile: Relies on web structure consistency._

- **🧮 Compliance Calculation**:  
  Compares each device’s OS version to the patch list.

- **📝 Report Generation**:  
  Exports final data using `Export-Csv`.

---

## 💡 Potential Improvements

- **🔐 Error Handling**:  
  Add graceful handling for:
  - Network failures
  - Invalid/missing data
  - CSV format errors

- **📡 API Usage**:  
  Replace web scraping with a more reliable Microsoft patching API (if available).

- **⚙️ Regex Optimization**:  
  Refactor regex logic for clarity and performance.

- **🧩 Modularization**:  
  Break script into smaller functions for:
  - Data import
  - Patch parsing
  - Compliance checks
  - Report creation

---

## 📂 Example Output: `Final_Patching_Report.csv`

The report includes the following columns:

- `DeviceName`
- `Serialnumber`
- `PrimaryUserUPN`
- `Ownership`
- `JoinType`
- `Manufacturer`
- `Model`
- `Managedby`
- `Totalstorage (GB)`
- `Freestorage (GB)`
- `Lastcheckin`
- `SkuFamily`
- `OSVersion`
- `OS`
- `InstalledKB`
- `PatchType`
- `InstalledKB_ReleaseDate`
- `PatchingStatus`
- `DevcieNotPatchSince_InDays`
- `Latest_RequiredPatch`
- `RequiredPatchRD`

---

## ⚠️ Security Note

This script uses:

```powershell
Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force -ErrorAction 'Stop'
```

This bypasses execution policy restrictions and **should only be used in secure, controlled environments**.

✅ _Recommendation_: Use a dedicated execution context or apply least privilege principles where possible.

---

## 📌 License

MIT License (or specify if different).
