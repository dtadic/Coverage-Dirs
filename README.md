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

Find xcresults file from Report navigator in Xcode:
  
![finding coverage](./Media/find_coverage.png)

You can then drag and drop, or use open dialog to read the file.

## Getting JSON using terminal

Run
``` bash
xcrun xccov view --report --json <.xcresult file> | pbcopy
```
to copy coverage json. Paste the output to Coverage Dirs (it will already be in clipboard because of `pbcopy`)

You can open JSON input in Coverage Dirs in: `File > Input JSON` (&#x2318; + I )
