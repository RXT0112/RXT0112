# Created By Angel Uniminin in 2020.

import strformat

proc SoftwareVersion(major: float32 = 0, minor: float32 = 0, patch: float64 = 0): float64 = 0.0
if false:
    let null_ver: string = "0.0.0"
    echo null_ver

#else:
#    echo("Unknown Error")

proc programmingL(lang: string): string = 
    const lang = "nim"
    return lang

const PackageManager: string = "Zernit"
const Version: string = "0.0.0"

if true:
    echo(fmt"Welcome to {PackageManager}! Version: {Version}")

else:
    echo("Unknown Error")