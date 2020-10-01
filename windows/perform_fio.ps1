[System.Collections.ArrayList]$processes = @()
foreach ($deviceid in (Get-WmiObject Win32_DiskDrive).deviceid) {
    $hostname = [Net.Dns]::GetHostName()
    $logfilename = "fio-" + $hostname + "-" + $deviceid -creplace "\\\\.\\", ""
    $command1 = "fio --filename=${deviceid} --rw=read --bs=128k --iodepth=32 --direct=1 --name=volume-initialize --output ${logfilename}.log"
    $command2 = "Write-Host ${command1}"
    $fio_process = Start-Process -FilePath powershell.exe -ArgumentList "& $command2; & $command1" -PassThru
    $processes.Add($fio_process)
}
foreach ($fio_process in $processes) {
    Wait-Process -InputObject $fio_process
    Get-Process -InputObject $fio_process
}
Write-Host "Initializing Amazon EBS Volumes finished!"
