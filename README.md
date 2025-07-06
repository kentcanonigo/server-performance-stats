# server-performance-stats

A simple Bash script to display real-time server performance statistics. Built as a practice project for [roadmap.sh](https://roadmap.sh/projects/server-stats).

## 📋 Features

The `server-stats.sh` script provides the following information when run on any standard Linux system:

* **CPU Usage**
  Displays total CPU usage across all cores.

* **Memory Usage**
  Shows used vs. free memory, including percentage usage.

* **Disk Usage**
  Displays used vs. free disk space across mounted volumes, including percentage usage.

* **Top 5 Processes by CPU Usage**
  Lists the 5 most CPU-intensive processes currently running.

* **Top 5 Processes by Memory Usage**
  Lists the 5 most memory-intensive processes currently running.

## 🚀 Stretch Goals (Optional Enhancements)

These are extra stats you can include to expand the script:

* OS version and kernel
* System uptime
* Load average
* Currently logged-in users
* Recent failed login attempts
* Network interface statistics
* Process count and zombie processes

## 🛠 Usage

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/server-performance-stats.git
   cd server-performance-stats
   ```

2. Make the script executable:

   ```bash
   chmod +x server-stats.sh
   ```

3. Run the script:

   ```bash
   ./server-stats.sh
   ```

> **Note:** The script uses standard Unix tools (`top`, `df`, `free`, `ps`, etc.) and should work on most Linux distributions out of the box.

## 📎 Project Link

This project is part of the [roadmap.sh projects collection](https://roadmap.sh/projects/server-stats).

## 🧾 License

This project is licensed under the MIT License.
