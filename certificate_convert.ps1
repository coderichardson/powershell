$choice = Read-Host "What are you trying to do? Choose one of the following(1-4):

1. Convert a PEM certificate to PFX.
2. Convert a PFX certificate to PEM.
3. Generate a CSR.
"
function PEM_to_PFX {
    $selected_cert = Read-Host "Enter the name of the PEM certificate to convert to PFX. Include the .pem certificate."
    $selected_key = Read-Host "Enter the name of the private key associated with the PEM certificate. Include the .key extension."
    $converted_name = Read-Host "Enter the name of the desired PFX file to convert from PEM. Include the .pfx extension."
    openssl pkcs12 -inkey $selected_key -in $selected_cert -export -out $converted_name
}
function PFX_to_PEM {
    $selected_cert = Read-Host "Enter the name of the PFX certificate to convert to PEM. Include the .pfx extension."
    $converted_name = Read-Host "Enter the name of the desired PEM file to convert from PFX. Include the .pem extension."
    openssl pkcs12 -in $selected_cert -out $converted_name -nodes
}

function Generate_CSR {
    $selected_key = Read-Host "Enter the name of the private key to correspond with the CSR. Include the .pem extension."
    $selected_csr = Read-Host "Enter the name of the CSR. Include the .csr extension."
    openssl genpkey -algorithm RSA -out $selected_key
    openssl req -new -key private_key.pem -out $selected_csr
}

if ($choice -eq 1) {
PEM_to_PFX
}

elseif ($choice -eq 2) {
PFX_to_PEM
}

if ($choice -eq 3) {
Generate_CSR
}

else {
    Read-Host "Your selection didn't match any options."
    break
}