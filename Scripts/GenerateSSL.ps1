# Define paths for the keys and certificate
$privateKeyPath = "C:\Program Files\OpenSSL-Win64\private_key.pem"  # Path to save the private key
$publicKeyPath = "C:\Program Files\OpenSSL-Win64\public_key.pem"    # Path to save the public key
$certPath = "C:\Program Files\OpenSSL-Win64\certificate.pem"         # Path to save the certificate
$chainCertPath = "C:\Program Files\OpenSSL-Win64\chain_certificate.pem" # Path to save the chain certificate (self-signed root)

# Define the OpenSSL path (adjust if needed)
$opensslPath = "C:\Program Files\OpenSSL-Win64\bin\openssl.exe"  # Adjust path if needed

# Generate a private key
& $opensslPath genpkey -algorithm RSA -out $privateKeyPath -pkeyopt rsa_keygen_bits:2048

# Generate a self-signed certificate using the private key
& $opensslPath req -new -x509 -key $privateKeyPath -out $certPath -days 9999 -subj "/CN=your-domain.com"

# Generate a certificate chain (self-signed root certificate)
& $opensslPath req -new -x509 -key $privateKeyPath -out $chainCertPath -days 9999 -subj "/CN=Root CA"

# Extract the public key from the private key
& $opensslPath rsa -in $privateKeyPath -pubout -out $publicKeyPath

# Output the paths of the generated files
Write-Host "Private Key: $privateKeyPath"
Write-Host "Public Key: $publicKeyPath"
Write-Host "Self-Signed Certificate: $certPath"
Write-Host "Certificate Chain (Root CA): $chainCertPath"
