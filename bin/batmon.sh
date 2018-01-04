#!/usr/bin/env bash
# DEPENDENCY lockfile command depends on procmail package!
# REF: https://agorf.gr/2016/06/29/low-battery-notification-in-i3wm/

THRESHOLD=10 # percent

lock_path='/tmp/batmon.lock'

/usr/bin/lockfile -r 0 $lock_path 2>/dev/null || exit

acpi_path=$(find /sys/class/power_supply/ -name 'BAT*' | head -1)
charge_now=$(cat "$acpi_path/energy_now")
charge_full=$(cat "$acpi_path/energy_full")
charge_status=$(cat "$acpi_path/status")
charge_percent=$(printf '%.0f' $(echo "$charge_now / $charge_full * 100" | bc -l))
message="Battery running critically low at $charge_percent%!"

#printf "Acpi path $acpi_path\n"
#printf "Charge now $charge_now\n"
#printf "Charge full $charge_full\n"
#printf "Charge status $charge_status\n"
#printf "Charge percent $charge_percent\n"

if [[ $charge_status == 'Discharging' ]] && [[ $charge_percent -le $THRESHOLD ]]; then
  DISPLAY=:0.0 /usr/bin/i3-nagbar -t warning -m "$message"
fi

rm -f $lock_path

