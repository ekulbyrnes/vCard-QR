#!/bin/bash

# Function to generate QR code for a contact
generate_contact_qr() {
    local first_name="$1"
    local last_name="$2"
    local phone="$3"
    local email="$4"
    local filename="$5"

    # Combine first name and last name for the full name
    local full_name="$first_name $last_name"

    # Create a temporary vCard file
    local vcard_content="BEGIN:VCARD
VERSION:3.0
FN:$full_name
N:$last_name;$first_name;;;
TEL:$phone
EMAIL:$email
END:VCARD"

    # Generate QR code from the vCard content
    echo "$vcard_content" | qrencode --type=SVG -o "$filename" -s 10 -l H

    # Check if the file was created successfully
    if [[ -f "$filename" ]]; then
        echo "QR vCard generated successfully and saved to $filename"
    else
        echo "Error: QR vCard failed to be created."
    fi
}



# Read user input for contact details
read -p "Enter first name: " first_name
read -p "Enter last name: " last_name
read -p "Enter phone number: " phone_number
read -p "Enter email address: " email_address
read -p "Enter output filename (e.g., contact.svg): " output_filename

# Generate the QR code for the contact
generate_contact_qr "$first_name" "$last_name" "$phone_number" "$email_address" "$output_filename"

echo "QR code generated and saved to $output_filename"
