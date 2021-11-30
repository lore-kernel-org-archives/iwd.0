Content-Type: multipart/mixed; boundary="===============6873034748760823773=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce at gmail.com>
To: iwd at lists.01.org
Subject: iwd configure location and files
Date: Wed, 01 Dec 2021 07:45:22 +1100
Message-ID: <CAA=hcWSGuuPcXbt6M=SOBmC+wYmPxMseG8veBgK9PUP8Or-bpA@mail.gmail.com>

--===============6873034748760823773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was running connman with wpa_supplicant on an embedded IoT device
with 2 wireless network interfaces, a home WiFi network and a 4G LTE
network interface managed by ofono, it was working well. Given the
connman is moving to using iwd, I am now building iwd 1.19 on Yocto
Honister, while the iwd was running well, it could not connect to the
home WiFi network.

# systemctl status iwd -l
* iwd.service - Wireless service
     Loaded: loaded
(8;;file://solar/lib/systemd/system/iwd.service/lib/systemd/system/iwd.serv=
ice8;;;
enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-08-04 15:11:22 UTC; 1min 34s a=
go
   Main PID: 203 (iwd)
     CGroup: /system.slice/iwd.service
             `-203 /usr/libexec/iwd

Aug 04 15:11:23 solar iwd[203]:                         48.0 Mbps
Aug 04 15:11:23 solar iwd[203]:                         54.0 Mbps
Aug 04 15:11:23 solar iwd[203]:                 HT Capabilities:
Aug 04 15:11:23 solar iwd[203]:                         HT20
Aug 04 15:11:23 solar iwd[203]:                         Short GI for 20Mhz
Aug 04 15:11:23 solar iwd[203]:                 HT RX MCS indexes:
Aug 04 15:11:23 solar iwd[203]:                         0-7
Aug 04 15:11:23 solar iwd[203]:                         32
Aug 04 15:11:23 solar iwd[203]:         Ciphers: CCMP TKIP BIP
Aug 04 15:11:23 solar iwd[203]:         Supported iftypes: station ap
p2p-client p2p-go

I could see the WiFi network, but could not scan, nor could connect to
the network:

[iwd]#  station mlan0 scan

[iwd]# station wlan0 get-networks

                               Available networks
---------------------------------------------------------------------------=
-----
    Network name                    Security          Signal
---------------------------------------------------------------------------=
-----
    JupiterIoT                      psk               ****

# station wlan0 connect JupiterIoT
Type the network passphrase for JupiterIoT psk.
Passphrase: superpassphrase
Operation aborted

# iwctl station wlan0 show
                                 Station: wlan0
---------------------------------------------------------------------------=
-----
  Settable  Property            Value
---------------------------------------------------------------------------=
-----
            Scanning            no
            State               disconnected


I believe it is not configured properly. According to the the document
https://iwd.wiki.kernel.org/networkconfigurationsettings, the network
configure files are stored in /var/lib/iwd by default, but I can only
see an empty folder /var/lib/iwd/hotspot, there are several files in
/lib/systed/network:

# ls /lib/systemd/network

80-container-host0.network       80-wifi-ap.network.example
80-container-ve.network          80-wifi-station.network
80-container-vz.network          80-wifi-station.network.example
80-iwd.link                      80-wired.network
80-vm-vt.network                 99-default.link
80-wifi-adhoc.network

Did you mean I need to copy network files from /lib/systemd/network to
/var/lib/iwd? For example, to run iwd for a home WiFi network, should
I copy the 80-wifi-station.network to /var/lib/iwd?

Thank you and appreciate your kind advice.

Kind regards,

- jh
--===============6873034748760823773==--

