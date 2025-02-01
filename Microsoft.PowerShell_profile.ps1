Clear-Host

Write-Host "                                                                
 _   _       _        ______     _     ______                     _ 
| | | |     | |       | ___ \   | |    | ___ \                   | |
| |_| | __ _| | ___   | |_/ /_ _| | __ | |_/ / __ _ _ __  _   _  | |
|  _  |/ _`  | |/ _ \  |  __/ _`  | |/ / | ___ \/ _`  | '_ \| | | | | |
| | | | (_| | | (_) | | | | (_| |   <  | |_/ / (_| | | | | |_| | |_|
|_| |_/\__,_|_|\___/  |_|  \__,_|_|\_\ |____/ \__,_|_| |_|\__,_| (_)                                                                                                                                                                                                                                    
" -ForegroundColor Cyan

#Separator before Owner
Write-Host "====================================================" -ForegroundColor White

# Display Owner
$owner = "Bondan Banuaji"
Write-Host "💻 Owner		: $owner" -ForegroundColor Yellow

# Display CPU logical cores (threads)
$cpuLogicalCores = (Get-WmiObject -Class Win32_Processor).NumberOfLogicalProcessors
Write-Host "🔧 CPU Cores		: $cpuLogicalCores" -ForegroundColor Blue

# Display Memory Usage
$memory = Get-WmiObject -Class Win32_OperatingSystem
$memoryTotal = [math]::round($memory.TotalVisibleMemorySize / 1MB, 2)
$memoryFree = [math]::round($memory.FreePhysicalMemory / 1MB, 2)
$memoryUsed = [math]::round($memoryTotal - $memoryFree, 2)

Write-Host "🧠 Memory Usage		: $memoryUsed MB / $memoryTotal MB" -ForegroundColor Green

# Display Disk Usage
$disk = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3"
foreach ($d in $disk) {
    $diskTotal = [math]::round($d.Size / 1GB, 2)
    $diskFree = [math]::round($d.FreeSpace / 1GB, 2)
    $diskUsed = [math]::round($diskTotal - $diskFree, 2)
    
    Write-Host "💾 Disk Usage ($($d.DeviceID))	: $diskUsed GB / $diskTotal GB" -ForegroundColor Cyan
}

# Display Uptime
$uptime = (Get-Date) - (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
$uptimeDays = [math]::Floor($uptime.TotalDays)
$uptimeHours = $uptime.Hours
$uptimeMinutes = $uptime.Minutes

Write-Host "⏰ Uptime		: $uptimeDays Days, $uptimeHours Hours, $uptimeMinutes Minutes" -ForegroundColor Magenta

# Separator before Server Latency
Write-Host "====================================================" -ForegroundColor White

# Display Server Latency
Write-Host "🌐 Checking server latency..." -ForegroundColor Yellow
$pingResults = Test-Connection -ComputerName google.com -Count 5 -ErrorAction SilentlyContinue

if ($pingResults) {
    # Mengambil response time dari setiap ping
    $latencies = $pingResults | ForEach-Object { $_.ResponseTime }
    
    # Menghitung rata-rata latensi
    $avgLatency = [math]::Round(($latencies | Measure-Object -Average).Average, 2)
    Write-Host "📶 Average Latency Detected: $avgLatency ms" -ForegroundColor Blue
} else {
    Write-Host "❌ Server not reachable." -ForegroundColor Red
}

# Separator before the message "Don't forget to drink coffee"
Write-Host "====================================================" -ForegroundColor White

# Display Message Ngopi
Write-Host "Jangan lupa ngopi :)" -ForegroundColor Green

oh-my-posh init pwsh --config 'C:\Users\HP\AppData\Local\Programs\oh-my-posh\themes\clean-detailed.omp.json' | Invoke-Expression
