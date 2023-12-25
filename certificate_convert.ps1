# Prompt the user to choose their desired action.
$choice = Read-Host "What are you trying to do? Choose one of the following(1-4):

1. Convert a PEM certificate to PFX.
2. Convert a PFX certificate to PEM.
3. Generate a CSR (requires private key).
4. Generate a PEM certificate (requires CSR).
"
# PEM_to_PFX converts the specified PEM certificate to a PFX certificate. Requires an unencrypted private key to be present along with the PEM certificate.
function PEM_to_PFX {
    $selected_cert = Read-Host "Enter the name of the PEM certificate to convert to PFX. Include the .pem certificate."
    $selected_key = Read-Host "Enter the name of the private key associated with the PEM certificate. Include the .key extension."
    $converted_name = Read-Host "Enter the name of the desired PFX file to convert from PEM. Include the .pfx extension."
    openssl pkcs12 -inkey $selected_key -in $selected_cert -export -out $converted_name
}
# PFX_to_PEM converts the specified PFX certificate to a PEM certificate. 
function PFX_to_PEM {
    $selected_cert = Read-Host "Enter the name of the PFX certificate to convert to PEM. Include the .pfx extension."
    $converted_name = Read-Host "Enter the name of the desired PEM file to convert from PFX. Include the .pem extension."
    openssl pkcs12 -in $selected_cert -out $converted_name -nodes
}

# Generate_CSR creates a private key file, then uses that private key file to generate a CSR.
function Generate_CSR {
    $selected_key = Read-Host "Enter the name of the private key to correspond with the CSR. Include the .pem extension."
    $selected_csr = Read-Host "Enter the name of the CSR. Include the .csr extension."
    openssl genpkey -algorithm RSA -out $selected_key
    openssl req -new -key private_key.pem -out $selected_csr
}

# Generate_PEM takes an existing private key and existing CSR and creates a certificate in PEM format.
function Generate_PEM {
    $selected_key = Read-Host "Enter the name of the private key to correspond with the CSR. Include the .pem extension."
    $selected_csr = Read-Host "Enter the name of the CSR. Include the .csr extension."
    openssl x509 -req -in $selected_csr -signkey $selected_key -out signed_certificate.pem
}

if ($choice -eq 1) {
PEM_to_PFX
}

if ($choice -eq 2) {
PFX_to_PEM
}

if ($choice -eq 3) {
Generate_CSR
}

if ($choice -eq 4) {
Generate_PEM
    }

else {
    Read-Host "Your selection didn't match any options."
    break
}