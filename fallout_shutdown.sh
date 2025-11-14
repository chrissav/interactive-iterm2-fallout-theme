#!/bin/bash

# Fallout-style shutdown messages
shutdown_lines=(
  "> INITIATING SHUTDOWN SEQUENCE..."
  "> SAVING USER PREFERENCES..."
  "> CLOSING ACTIVE CONNECTIONS..."
  "> TERMINATING BACKGROUND PROCESSES..."
  "> FLUSHING MEMORY CACHE..."
  "> CLEARING TEMPORARY FILES..."
  "> SECURING DATA BANKS..."
  "> POWERING DOWN SUBSYSTEMS..."
  "> LOGGING OFF USER..."
  "> VAULT-TEC(TM) SYSTEMS OFFLINE"
  "> DISABLING V.A.T.S. INTERFACE..."
  "> SAVING QUEST PROGRESS..."
  "> DISCONNECTING FROM PIP-GIRL NETWORK..."
  "> CLOSING HOLOTAPE DRIVES..."
  "> POWERING DOWN FUSION CORES..."
  "> DISENGAGING POWER ARMOR SERVOS..."
  "> SECURING VAULT DOOR MECHANISMS..."
  "> DEACTIVATING TURRET SYSTEMS..."
  "> SAVING INVENTORY MANIFEST..."
  "> CLOSING RADIO FREQUENCIES..."
  "> BACKING UP S.P.E.C.I.A.L. DATA..."
  "> TERMINATING COMBAT SUBROUTINES..."
  "> DISABLING STEALTH FIELD..."
  "> SAVING MAP MARKERS..."
  "> LOGGING EXPERIENCE POINTS..."
  "> SECURING MEDICAL RECORDS..."
  "> POWERING DOWN RADAR SYSTEMS..."
  "> CLOSING TRADE TERMINALS..."
  "> SAVING FACTION STANDINGS..."
  "> DISABLING LASER GRID..."
  "> PARKING ROBOTIC UNITS..."
  "> SECURING AMMUNITION STORES..."
  "> CLOSING WORKSHOP INTERFACE..."
  "> SAVING SETTLEMENT DATA..."
  "> TERMINATING AI PROTOCOLS..."
  "> DISABLING TARGETING COMPUTER..."
  "> CLOSING RESEARCH TERMINALS..."
  "> SECURING EXPERIMENT DATA..."
  "> POWERING DOWN REACTOR CORE..."
  "> SAVING DWELLER STATISTICS..."
  "> CLOSING OVERSEER PROTOCOLS..."
  "> TERMINATING SECURITY FEEDS..."
  "> DISABLING MOTION SENSORS..."
  "> SAVING HOLODISK CACHE..."
  "> CLOSING BROTHERHOOD UPLINK..."
  "> SECURING ENCLAVE CHANNELS..."
  "> TERMINATING WASTELAND SCAN..."
  "> DISABLING GEIGER COUNTER..."
  "> SAVING PERK SELECTIONS..."
  "> CLOSING CRAFTING BENCH..."
  "> POWERING DOWN GENERATORS..."
  "> TERMINATING LIFE SUPPORT..."
  "> SAVING CHECKPOINT DATA..."
  "> CLOSING MEMORY BANKS..."
  "> SECURING CLASSIFIED FILES..."
  "> DISABLING DEFENSE MATRIX..."
  "> TERMINATING NEURAL LINK..."
  "> SAVING CONFIGURATION..."
  "> CLOSING MAINTENANCE LOGS..."
  "> POWERING DOWN TERMINALS..."
  "> SECURING VAULT ARCHIVES..."
  "> PLEASE STAND BY..."
)

# Returns 5 unique random indices from shutdown_lines
random_indices() {
    local count=${#shutdown_lines[@]}
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

# Print 5 random shutdown messages (faster than boot)
for idx in $(random_indices); do
    echo "${shutdown_lines[$idx]}"
    sleep 0.2
done

echo
echo

# Print initial hex block (4 lines for shutdown)
for j in {1..4}; do
    printf "\r"  # Ensure we start at beginning of line
    random_hex
    echo
done

# Progress bar configuration for shutdown
progress_length=30  # Shorter bar for faster animation
progress_char="█"
empty_char="░"

# Print initial full progress bar (starts at 100%)
echo
printf "SHUTTING DOWN: ["
for ((i=0; i<$progress_length; i++)); do
    printf "%s" "$progress_char"
done
printf "] 100%%"

# Save cursor position after progress bar
save_cursor

# Animate reverse progress bar (100% to 0%)
for ((progress=$progress_length; progress>=0; progress--)); do
    # Update hex lines less frequently (every 3 steps for speed)
    if [ $((progress % 3)) -eq 0 ]; then
        restore_cursor
        cursor_up 6  # 4 hex lines + 2 blank lines

        # Regenerate 4 hex lines
        for j in {1..4}; do
            printf "\r"  # Move cursor to beginning of line
            clear_to_eol
            random_hex
            echo
        done
    fi

    # Go back to progress bar line
    restore_cursor

    # Update progress bar (decreasing)
    printf "\rSHUTTING DOWN: ["

    # Draw filled portion (decreasing)
    for ((i=0; i<progress; i++)); do
        printf "%s" "$progress_char"
    done

    # Draw empty portion (increasing)
    for ((i=progress; i<progress_length; i++)); do
        printf "%s" "$empty_char"
    done

    # Calculate and display percentage (decreasing)
    percentage=$((progress * 100 / progress_length))
    printf "] %3d%%" "$percentage"

    # Faster animation with some variation
    if [ $progress -gt 25 ]; then
        sleep 0.03  # Very fast at the beginning
    elif [ $progress -gt 10 ]; then
        sleep 0.05  # Moderate in the middle
    else
        sleep 0.08  # Slightly slower near the end
    fi
done

echo
echo
echo "> TERMINAL LINK TERMINATED"
echo "> PLEASE STAND BY..."
sleep 0.5
printf "\033[0m"  # Reset color

# Clear screen after a brief pause
sleep 0.5
clear
