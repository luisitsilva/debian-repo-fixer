Debian APT Repository Fix (Auto-Detect Version)

A small, production-safe shell script that restores official Debian APT repositories after a fresh installation — especially useful when the system is configured to use only a cdrom: source and apt update fails.

The script automatically detects your Debian codename (e.g., bookworm, trixie) and configures the correct official repositories using the modern deb822 format.

🚀 Why This Exists

After installing Debian from DVD/ISO without selecting a network mirror, /etc/apt/sources.list often contains only:

deb cdrom:[Debian GNU/Linux ...]

This prevents apt update from working over the internet.

This script:

Detects the installed Debian release automatically

Removes or comments out cdrom: entries

Configures official Debian repositories

Enables:

main

contrib

non-free

non-free-firmware

updates

security

backports

Runs apt update

✅ What It Configures

The script creates:

/etc/apt/sources.list.d/debian.sources

Using the official mirrors:

https://deb.debian.org/debian

https://security.debian.org/debian-security

With suites:

<codename>

<codename>-updates

<codename>-security

<codename>-backports

The Debian codename is automatically detected from:

/etc/os-release
📦 Supported Debian Versions

Any supported Debian release, including:

Debian 12 (bookworm)

Debian 13 (trixie)

Future stable releases

No hardcoding is used.

🛠 Installation & Usage
1️⃣ Clone the repository
git clone https://github.com/yourusername/debian-apt-fix.git
cd debian-apt-fix
2️⃣ Make the script executable
chmod +x fix-debian-repos-auto.sh
3️⃣ Run it as root
sudo ./fix-debian-repos-auto.sh
🔍 What Happens Internally

Verifies the script is run as root

Detects the Debian codename

Comments out cdrom: entries in /etc/apt/sources.list

Removes old Debian source definitions (if present)

Creates a clean deb822 repository file

Runs apt update

🧱 Repository Structure
.
├── fix-debian-repos-auto.sh
└── README.md
🔐 Security Notes

Uses official Debian mirrors

Uses Debian archive keyring:

/usr/share/keyrings/debian-archive-keyring.gpg

No external keys are added

No third-party repositories are included

🧪 Tested On

Fresh Debian minimal installs

Debian installed from DVD ISO

Systems missing network mirror configuration

📄 License

MIT License

You are free to use, modify, and distribute this script.

🤝 Contributing

Pull requests are welcome.

If you have improvements such as:

Mirror auto-selection

Proxy support

Backup/restore functionality

Dry-run mode

Feel free to contribute.

⭐ If This Helped You

Consider starring the repository to help others find it.
