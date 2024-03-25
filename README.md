<h1 align="center">KoboToolbox API Fetcher</h1>

<p align="center">
  <img src="https://img.shields.io/github/license/mio-X/KoboToolbox_API_Fetcher" alt="License">
  <img src="https://img.shields.io/github/languages/code-size/mio-X/KoboToolbox_API_Fetcher" alt="Code Size">
  <img src="https://img.shields.io/github/repo-size/mio-X/KoboToolbox_API_Fetcher" alt="Repo Size">
</p>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/mio-X/KoboToolbox_API_Fetcher" alt="Last Commit">
</p>

This app is designed to fetch api links from KoBoToolbox easily and to use api links for further purposes such as importing to Excel,PowerBI and so on.
- https://myooo.shinyapps.io/kobotoolbox_api_v2/

## :computer: Usage
1. Select the KoboToolbox server URL.
2. Enter the Kobo Form ID.
3. Click "Submit" to fetch the export links.
4. Exported links will be displayed in a table.
5. Use the "Download" button to download the table data as a CSV file.

## :wrench: Setup
1. **Clone the Repository**: `git clone https://github.com/mio-X/KoboToolbox_API_Fetcher.git`
2. **Install R Packages**: Open R and run `install.packages(c("shiny", "httr", "jsonlite", "DT", "dplyr"))`.
3. **Run the App**: Open `app.R` in RStudio and execute `shiny::runApp()`.

## :mag: Obtaining Form ID
- Locate the form ID in the URL after `/forms/` when viewing the form details in KoboToolbox.
- Global KoboToolbox Server: for example, in `https://kf.kobotoolbox.org/#/forms/aSScAmYCTjfyo8mVYCf4Pt/summary`, the form ID is `aSScAmYCTjfyo8mVYCf4Pt`.
- Eu KoboToolbox Server: for example, in `https://eu.kobotoolbox.org/#/forms/aSScAmYCTjfyo8mVYCf4Pt/summary`, the form ID is `aSScAmYCTjfyo8mVYCf4Pt`.

## :warning: Important Notes
- Ensure that the 'Anyone can view submissions made to this form' option is enabled in the 'Sharing' tab of your KoboToolbox server before using this app.
- No data is collected or stored in the app. Users are responsible for data accuracy verification.
- This app is licensed under a [MIT](LICENSE).

## :busts_in_silhouette: Developer
- [Myo Oo](https://github.com/mio-X)
