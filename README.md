<p align="center">
<img src="https://raw.githubusercontent.com/rocklyve/FacyReact/stable/Extensions/ReadmeHeader.png"
width=704>
</p>

<p align="center">
<a href="https://github.com/JamitLabs/Accio/releases">
<img src="https://img.shields.io/badge/Version-0.5.5-blue.svg"
alt="Version: 1.0.0">
</a>
<img src="https://img.shields.io/badge/Swift-5.0-FFAC45.svg"
alt="Swift: 5.0">
<img src="https://img.shields.io/badge/Platforms-macOS-FF69B4.svg"
alt="Platforms: iOS">
<a href="https://github.com/JamitLabs/Accio/blob/stable/LICENSE">
<img src="https://img.shields.io/badge/License-MIT-lightgrey.svg"
alt="License: MIT">
</a>
</p>

<p align="center">
<a href="#installation">Getting Started</a>
• <a href="#usage">Usage</a>
• <a href="#contributing">Contributing</a>
• <a href="#license">License</a>
<a href="#installation">Scripts</a>
</p>

# FacyReact

## Getting Started

Here's a few simple steps to configure this project after checking it out:

1. Run `brew bundle` in the command line and wait for tools to be installed (requires [Homebrew](https://brew.sh/))
2. Run `beak run link` to link the Beak scripts properly for execution, then restart your terminal
3. Run `project install` to make sure you have all required tools and dependencies installed

That's it, you should now be able to build the project successfully.

## Scripts

Once the project is set up as above, the following script commands should be available in the root of the project:

* `deps install`: Install all dependencies in the currently specified version.
* `deps update`: Updates all dependencies according to their version specifications.
* `tools install`: Installes missing tools & updates all existing to their latest versions.
* `ci lint`: Lints the project with all configured linters like it would on the CI.

Feel free to add more scripts in the `Scripts` folder. To edit them, run `beak edit -p Scripts/<file>.swift` which will start [Beak's edit mode](https://github.com/yonaskolb/Beak#edit-the-swift-file). Once you are done and saved your changes, make sure to run `beak run link` to ensure all scripts are still executables. (The edit mode of Beak will destroy the rights on save.)
