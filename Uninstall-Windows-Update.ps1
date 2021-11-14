param (
    [Parameter(Mandatory)]
    [String[]]
    $KBNumber
)

foreach ($UpdateVersion in $KBNumber) {

    $SearchUpdates = dism /online /get-packages | findstr "Package_for" | findstr "$UpdateVersion"  

    if ($SearchUpdates) {

        $update = $SearchUpdates.split(":")[1].replace(" ", "")
        write-host ("Update result found: " + $update )
        dism /Online /Remove-Package /PackageName:$update /quiet /norestart

    } else {

        write-host ("Update " + $UpdateVersion + " not found.")

    }

}