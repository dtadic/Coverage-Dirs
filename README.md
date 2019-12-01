<p align="center">
<img src="./Media/logo.png" width="150px">
<h1 align="center">Coverage Dirs</h1>
</p>

View xcode coverage data by folder

Go from this:
<p align="center">
<img src="./Media/xc_coverage_screen.png">
</p>

To this:

<p align="center">
<img src="./Media/cov_dirs_screen.png">
</p>

## Usage

Run
``` bash
xcrun xccov view --report --json <.xcresult file> | pbcopy
```
to copy coverage json. Paste the output to Coverage Dirs (it will already be in clipboard because of `pbcopy`)


