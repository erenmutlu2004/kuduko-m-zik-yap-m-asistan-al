# GUI için gerekli kütüphaneler
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Ana form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Kuduko Müzik Yapım Asistan Al Kurulum Dosyası"
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.StartPosition = "CenterScreen"

# Bilgilendirme etiketi
$label = New-Object System.Windows.Forms.Label
$label.Text = "Kuduko Müzik Yapım Asistan Al Kurulum Dosyası"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20,20)
$form.Controls.Add($label)

# Dosya indirme butonu
$btnDownload = New-Object System.Windows.Forms.Button
$btnDownload.Text = "Dosyayı İndir"
$btnDownload.Size = New-Object System.Drawing.Size(200,40)
$btnDownload.Location = New-Object System.Drawing.Point(20,60)
$form.Controls.Add($btnDownload)

# Komut çalıştırma butonu
$btnRunScript = New-Object System.Windows.Forms.Button
$btnRunScript.Text = "Komut Dosyasını Çalıştır"
$btnRunScript.Size = New-Object System.Drawing.Size(200,40)
$btnRunScript.Location = New-Object System.Drawing.Point(20,120)
$form.Controls.Add($btnRunScript)

# Durum etiketi
$status = New-Object System.Windows.Forms.Label
$status.Text = ""
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(20,180)
$form.Controls.Add($status)

# İndirme işlemi
$scriptPath = "$env:TEMP\Kuduko Müzik Yapım Asistan Al.ps1"
$btnDownload.Add_Click({
    try {
        $url = "https://raw.githubusercontent.com/erenmutlu2004/KudukoM-zikYap-mAsistanAl/main/Kuduko%20M%C3%BCzik%20Yap%C4%B1m%20Asistan%20Al.ps1"
        Invoke-WebRequest -Uri $url -OutFile $scriptPath
        $status.Text = "Dosya başarıyla indirildi: $scriptPath"
    } catch {
        $status.Text = "İndirme hatası: $_"
    }
})

# Çalıştırma işlemi
$btnRunScript.Add_Click({
    try {
        if (Test-Path $scriptPath) {
            Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`"" -WindowStyle Normal
            $status.Text = "Komut dosyası çalıştırıldı."
        } else {
            $status.Text = "Dosya bulunamadı. Önce indir."
        }
    } catch {
        $status.Text = "Çalıştırma hatası: $_"
    }
})

# GUI’yi başlat
$form.Topmost = $true
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
