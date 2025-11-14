#!/bin/bash

# Fallout-style system lines with more variety
fallout_lines=(
  "> INITIALIZING ROBCO INDUSTRIES(TM) TERMLINK PROTOCOL..."
  "> BOOTING SYSTEM..."
  "> LOADING VAULT-TEC(TM) DATA BANK..."
  "> ACCESSING MEMORY BANKS..."
  "> UNLOCKING ENCRYPTED FILES..."
  "> INITIALIZING USER INTERFACE..."
  "> LOADING ASSETS..."
  "> ESTABLISHING SECURE CONNECTION..."
  "> CHECKSUM: OK"
  "> SYSTEM CALIBRATION COMPLETE"
  "> CHECKING VAULT STATUS"
  "> RUNNING DIAGNOSTICS..."
  "> ALL SYSTEMS NOMINAL"
  "> EXECUTING BOOT SEQUENCE"
  "> WELCOME TO THE WASTELAND"
  "> SCANNING FOR RADIATION LEVELS..."
  "> SYNCING PIP-GIRL(TM) DATABASE..."
  "> VERIFYING SECURITY CLEARANCE..."
  "> LOADING UNIFIED OPERATING SYSTEM..."
  "> ESTABLISHING SATELLITE UPLINK..."
  "> DECRYPTING GOVERNMENT FILES..."
  "> INITIALIZING DEFENSE PROTOCOLS..."
  "> CHECKING POWER CORE STATUS..."
  "> ACCESSING OVERSEER TERMINAL..."
  "> LOADING EMERGENCY BROADCAST SYSTEM..."
  "> ANALYZING ATMOSPHERIC CONDITIONS..."
  "> CONNECTING TO VAULT MAINFRAME..."
  "> AUTHENTICATING USER CREDENTIALS..."
  "> LOADING S.P.E.C.I.A.L. PARAMETERS..."
  "> INITIALIZING V.A.T.S. TARGETING SYSTEM..."
  "> CHECKING WATER PURIFICATION STATUS..."
  "> SCANNING FOR HOSTILE SIGNALS..."
  "> LOADING ATOMIC BATTERY RESERVES..."
  "> ACCESSING PRE-WAR DATABASE..."
  "> SYNCHRONIZING INTERNAL CLOCK..."
  "> VERIFYING BIOMETRIC SIGNATURE..."
  "> LOADING EMERGENCY PROTOCOLS..."
  "> CHECKING STRUCTURAL INTEGRITY..."
  "> INITIALIZING COMBAT SUBROUTINES..."
  "> ACCESSING MEDICAL DIAGNOSTIC SYSTEM..."
  "> LOADING INVENTORY MANAGEMENT..."
  "> CHECKING FUSION CORE LEVELS..."
  "> ESTABLISHING RADIO FREQUENCY..."
  "> SCANNING FOR LIFE SIGNS..."
  "> LOADING SURVIVAL GUIDE v2.0..."
  "> ACCESSING PERSONNEL RECORDS..."
  "> INITIALIZING SECURITY LOCKDOWN..."
  "> CHECKING AIR FILTRATION SYSTEMS..."
  "> LOADING EMERGENCY EXIT ROUTES..."
  "> VERIFYING SYSTEM INTEGRITY..."
  "> ACCESSING ARMORY INVENTORY..."
  "> INITIALIZING THREAT DETECTION..."
  "> LOADING WASTELAND SURVIVAL DATA..."
  "> CHECKING AMMUNITION RESERVES..."
  "> SYNCHRONIZING WITH VAULT NETWORK..."
  "> ACCESSING EXPERIMENT LOGS..."
  "> LOADING DECONTAMINATION PROTOCOLS..."
  "> INITIALIZING RADAR SYSTEMS..."
  "> CHECKING CRYOGENIC STATUS..."
  "> ACCESSING SUPPLY MANIFESTS..."
  "> LOADING TRADE ROUTE DATA..."
  "> INITIALIZING FRIEND-OR-FOE TAGS..."
  "> CHECKING GEIGER COUNTER CALIBRATION..."
  "> LOADING SETTLEMENT DATA..."
  "> ACCESSING MILITARY ARCHIVES..."
  "> INITIALIZING REPAIR SUBROUTINES..."
  "> CHECKING FOOD STORAGE LEVELS..."
  "> LOADING CARTOGRAPHY DATABASE..."
  "> VERIFYING QUANTUM HARMONICS..."
  "> ACCESSING ROBOTICS BAY..."
  "> LOADING HOLOTAPE LIBRARY..."
  "> INITIALIZING PLASMA CONTAINMENT..."
  "> CHECKING TURRET CONTROL SYSTEMS..."
  "> ACCESSING RESEARCH TERMINALS..."
  "> LOADING CHEMICAL SYNTHESIS DATA..."
  "> INITIALIZING STEALTH FIELD GENERATOR..."
  "> CHECKING REACTOR TEMPERATURE..."
  "> SYNCHRONIZING NEURAL INTERFACE..."
  "> LOADING MISSION PARAMETERS..."
  "> ACCESSING BROTHERHOOD DATALINK..."
  "> INITIALIZING POWER ARMOR SYSTEMS..."
  "> CHECKING STIMPAK INVENTORY..."
  "> LOADING QUEST OBJECTIVES..."
  "> VERIFYING DWELLER STATUS..."
  "> ACCESSING ENCLAVE FREQUENCIES..."
  "> INITIALIZING LASER GRID DEFENSE..."
  "> CHECKING RAD-AWAY SUPPLIES..."
  "> LOADING FACTION REPUTATION DATA..."
)

# Returns 5 unique random indices from fallout_lines
random_indices() {
    local count=${#fallout_lines[@]}
    shuf -i 0-$(($count-1)) | head -n 5
}

# Returns a fake hex line, similar to the Fallout terminal
random_hex() {
    chars="0123456789ABCDEF"
    for i in {1..12}; do
        for j in {1..11}; do
            printf "%s" "${chars:RANDOM%16:1}"
        done
        printf " "
    done
}

# Function to generate a single hex block (no newline)
random_hex_line() {
    random_hex
}

# Save cursor position
save_cursor() {
    printf "\033[s"
}

# Restore cursor position
restore_cursor() {
    printf "\033[u"
}

# Move cursor up n lines
cursor_up() {
    printf "\033[${1}A"
}

# Clear from cursor to end of line
clear_to_eol() {
    printf "\033[K"
}

clear
printf "\033[92m" # Fallout green

# Print up to 5 unique boot messages
for idx in $(random_indices); do
    echo "${fallout_lines[$idx]}"
    sleep 0.4
done

echo
echo

# Print initial hex block (8 lines that will be updated)
for j in {1..8}; do
    printf "\r"  # Ensure we start at beginning of line
    random_hex_line
    echo
done

# Progress bar configuration
progress_length=50
progress_char="█"
empty_char="░"

# Print initial empty progress bar
echo
printf "LOADING: ["
for ((i=0; i<$progress_length; i++)); do
    printf "%s" "$empty_char"
done
printf "] 0%%"

# Save cursor position after progress bar
save_cursor

# Animate progress bar with updating hex codes
for ((progress=0; progress<=$progress_length; progress++)); do
    # Update hex lines (go up 10 lines from saved position)
    restore_cursor
    cursor_up 10

    # Regenerate all 8 hex lines
    for j in {1..8}; do
        printf "\r"  # Move cursor to beginning of line
        clear_to_eol
        random_hex_line
        echo
    done

    # Go back to progress bar line
    restore_cursor

    # Update progress bar
    printf "\rLOADING: ["

    # Draw filled portion
    for ((i=0; i<progress; i++)); do
        printf "%s" "$progress_char"
    done

    # Draw empty portion
    for ((i=progress; i<progress_length; i++)); do
        printf "%s" "$empty_char"
    done

    # Calculate and display percentage
    percentage=$((progress * 100 / progress_length))
    printf "] %3d%%" "$percentage"

    # Variable sleep for more realistic loading feel
    if [ $progress -lt 10 ] || [ $progress -gt 40 ]; then
        sleep 0.08
    elif [ $progress -lt 20 ] || [ $progress -gt 35 ]; then
        sleep 0.04
    else
        sleep 0.02
    fi
done

echo
echo
echo "> SYSTEM READY. PLEASE ENTER COMMAND."
printf "\033[0m"
