# GUI için .NET kütüphanelerini yükle
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Ana Form oluştur
$form = New-Object System.Windows.Forms.Form
$form.Text = "Kuduko Müzik Yapım Asistan Al Kurulum Dosyası"
$form.Size = New-Object System.Drawing.Size(500,200)
$form.StartPosition = "CenterScreen"

# Açıklama
$label = New-Object System.Windows.Forms.Label
$label.Text = "Kuduko Müzik Yapım Asistan Al Kurulum Dosyası"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($label)

# Betiği indir butonu
$downloadButton = New-Object System.Windows.Forms.Button
$downloadButton.Text = "Dosya İndir"
$downloadButton.Size = New-Object System.Drawing.Size(120, 40)
$downloadButton.Location = New-Object System.Drawing.Point(20, 60)
$form.Controls.Add($downloadButton)

# Betiği çalıştır butonu
$runButton = New-Object System.Windows.Forms.Button
$runButton.Text = "Komut Çalıştır"
$runButton.Size = New-Object System.Drawing.Size(120, 40)
$runButton.Location = New-Object System.Drawing.Point(160, 60)
$runButton.Enabled = $false
$form.Controls.Add($runButton)

# Durum etiketi
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = ""
$statusLabel.AutoSize = $true
$statusLabel.Location = New-Object System.Drawing.Point(20, 120)
$form.Controls.Add($statusLabel)

# Geçici dizine kaydedilecek dosya adı
$scriptPath = "$env:TEMP\Kuduko Müzik Yapım Asistan Al.ps1"

# İndirme işlemi
$downloadButton.Add_Click({
    try {
        $url = "https://raw.githubusercontent.com/kudukomuzikyapim-Official/KudukoM-zikYap-mAsistanAl/main/Kuduko%20M%C3%BCzik%20Yap%C4%B1m%20Asistan%20Al.ps1"
        Invoke-WebRequest -Uri $url -OutFile $scriptPath
        $statusLabel.Text = "Dosya indirme başarılı!"
        $runButton.Enabled = $true
    } catch {
        $statusLabel.Text = "İndirme başarısız: $_"
    }
})

# Çalıştırma işlemi
$runButton.Add_Click({
    try {
        Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
        $statusLabel.Text = "Betiği çalıştırılıyor..."
    } catch {
        $statusLabel.Text = "Çalıştırma hatası: $_"
    }
})

# Formu başlat
[void]$form.ShowDialog()
