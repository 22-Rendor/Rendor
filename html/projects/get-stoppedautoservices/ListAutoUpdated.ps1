$regBase = 'HKLM:\SYSTEM\CurrentControlSet\Services'

Get-CimInstance Win32_Service -Filter "StartMode='Auto' AND State='Stopped'" |
    ForEach-Object {
        $delayed = Get-ItemProperty -Path "$regBase\$($_.Name)" -Name DelayedAutoStart -ErrorAction SilentlyContinue

        [PSCustomObject]@{
            Name        = $_.Name
            DisplayName = $_.DisplayName
            StartupType = if ($delayed -eq 1) { 'Automatic (Delayed Start)' } else { 'Automatic' }
            State       = $_.State
        }
    } |
    Sort-Object Name

    Get-CimInstance Win32_Service -Filter "StartMode='Auto' AND State='Stopped'" |
    ForEach-Object {
        $delayed = Get-ItemProperty -Path "$regBase\$($_.Name)"

        [PSCustomObject]@{
            Name        = $_.Name
            DisplayName = $_.DisplayName
            StartupType = if ($delayed -eq 1) { 'Automatic (Delayed Start)' } else { 'Automatic' }
            State       = $_.State
        }
    }