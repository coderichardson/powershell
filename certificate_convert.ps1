$choice = Read-Host "What are you trying to do? Choose one of the following(1-4): `\n
`\n
1. Convert a PEM certificate to PFX.
2. Convert a PFX certificate to PEM.
"
if $choice = 1 {
PEM_to_PFX{
    $selected_cert = Read-Host "Enter the name of the PEM certificate to convert to PFX."
    $selected_key = Read-Host "Enter the name of the private key associated with the PEM certificate."
    $converted_name = Read-Host "Enter the name of the desired PFX certificate to output as."
    openssl pkcs12 -inkey $selected_key -in $selected_cert -export -out $converted_name
}
}

if $choice = 2 {
PXF_to_PEM{
    $selected_cert = 
    $selected_key = 
    $converted_name = 
    openssl pkcs12 -in $selected_cert -out $converted_name -nodes
}
}