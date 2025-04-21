# Gerekli .NET kütüphanelerini yükle
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Ana form oluştur
$form = New-Object System.Windows.Forms.Form
$form.Text = "Kuduko Müzik Yapım Asistan Al Kurulum Dosyası"
$form.Size = New-Object System.Drawing.Size(600, 300)
$form.StartPosition = "CenterScreen"

# Bilgilendirme etiketi
$label = New-Object System.Windows.Forms.Label
$label.Text = "Kuduko Müzik Yapım Asistan Al Kurulum Dosyası"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)
$form.Controls.Add($label)

# Betiği indir butonu
$downloadButton = New-Object System.Windows.Forms.Button
$downloadButton.Text = "Dosyayı İndir"
$downloadButton.Size = New-Object System.Drawing.Size(150, 40)
$downloadButton.Location = New-Object System.Drawing.Point(20, 60)
$form.Controls.Add($downloadButton)

# Betiği çalıştır butonu
$runButton = New-Object System.Windows.Forms.Button
$runButton.Text = "Komut Çalıştır"
$runButton.Size = New-Object System.Drawing.Size(150, 40)
$runButton.Location = New-Object System.Drawing.Point(200, 60)
$form.Controls.Add($runButton)

# Durum etiketi
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = ""
$statusLabel.AutoSize = $true
$statusLabel.Location = New-Object System.Drawing.Point(20, 120)
$form.Controls.Add($statusLabel)

# Betik dosya yolu
$scriptPath = "$env:TEMP\\Kuduko Müzik Yapım Asistan Al.ps1"

# Betiği indir işlemi
$downloadButton.Add_Click({
    try {
        $url = "https://raw.githubusercontent.com/erenmutlu2004/KudukoM-zikYap-mAsistanAl/main/Kuduko%20M%C3%BCzik%20Yap%C4%B1m%20Asistan%20Al.ps1"
        Invoke-WebRequest -Uri $url -OutFile $scriptPath
        $statusLabel.Text = "Betiği indirme işlemi başarılı: $scriptPath"
    } catch {
        $statusLabel.Text = "İndirme sırasında hata oluştu: $_"
    }
})

# Betiği çalıştır işlemi
$runButton.Add_Click({
    try {
        if (Test-Path $scriptPath) {
            Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`"" -WindowStyle Normal
            $statusLabel.Text = "Dosyayı çalıştırma işlemi başlatıldı."
        } else {
            $statusLabel.Text = "Dosyayı çalıştırmak için önce indirmeniz gerekiyor."
        }
    } catch {
        $statusLabel.Text = "Çalıştırma sırasında hata oluştu: $_"
    }
})

# Formu göster
$form.Topmost = $true
$form.Add_Shown({ $form.Activate() })
[void]$form.ShowDialog()
