Content-Type: multipart/mixed; boundary="===============1872523787116912844=="
MIME-Version: 1.0
From: =?utf-8?q?Joakim_Lotseng=C3=A5rd_=3Cjoakim=2El_at_orbital-systems=2Ecom?=
 =?utf-8?q?=3E?=
To: iwd at lists.01.org
Subject: lib to iwd
Date: Thu, 24 Feb 2022 10:08:14 +0100
Message-ID: <CAELJiszyiCShr2DRmZ=9=PUHxcN15HtMFcQ1vTnytXd+_2PsNQ@mail.gmail.com>

--===============1872523787116912844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

TL;DR:
Is there any lib for iwd/iwctl (like libnm for NetworkManager) written
in C that will scan + GetOrderNetworks + configure a SSID+passphrase.
Goal is to configure an IoT device using a side-channel, typically
bluetooth. If not, would iwd-project accept that we contributed such a
work? How would you want that in such a case?

Longer:
I am new to iwd but I have long experience developing IoT products
using embedded Linux with WiFi. My background and understanding of
WiFi, routing and IP in general is rather high.

Today we have a rather ordinary IoT Linux-based product. It has one
ethernet port and a WiFi-card. It's based on a DiGi module. We are
using Bluetooth (BLE) and an app (for both Android and iPhone) to
configure the SSID the first time. We are using wpa_supplicant +
NetworkManager today. We have our own written daemon that talks
bluetooth with our app, and configures the SSID+any pass via libnm for
NetworkManager.

Our problem:
WiFi works badly and we had to hack a 'wifi watchdog' to kick
wpa_supplicant (via rfkill or even restart NetworkManager). The nmlib
usage we have suffers from bad threading and general mischief. It got
worse with the rewrite of the backend in libnm in 1.22. We want to
remove both NetworkManager and wpa_supplicant and only use iwd.
Problem is that there seems to be no corresponding "libnm" towards
iwd. One has to implement the DBUS API, rather than just use a lib. We
only need:
- Scan
- GetOrderedNetworks -> Present to user over bluetooth in an app.
- Configure user selected SSID and passphrase (only supporting
WPA2-PSK and possibly Open is fine).
With iwd this is simple compared to many other solutions, but still
not just straight forward. DBUS is "complicated". I think this is a
very common operation many IoT devices want to do. You configure the
single SSID over a side-channel (bluetooth typically). You want a
single SSID configured. A lib that helps with this very exact
operation would benefit many projects.

We can't use Python. Target does not have Python. It must be in C (or
C++) to match the other half of the daemon we have to configure WiFi
over Bluetooth.

I know DPP, but:
We really want to use our current app and solution which is a protocol
over bluetooth we developed ourselves. Also, iPhone does not support
DPP. In general the DPP support out there seems poor and not really
ready for the big masses. Please correct me if I am wrong.

We only want a minor "libiwd" or "libiwctl" just like libnm that can
configure an IoT device's SSID via a side channel. How can we do this
the easiest and most standard way?

(QR-code: If you go to our web-site you might figure out that we do
have a display on our device. A QR-code way if DPP might be possible.
However, we rather do it the bluetooth way due to legacy and for
security reasons. The device is installed in Hotels where guests have
access. With bluetooth we can add a check of "overship".)

Contribution:
If there is no such lib the company I work for (Orbital Systems) might
be willing to contribute such a work. Under any applicable license
(LGPL?). Basically take code from iwctl and make a lib. A small lib
focused on only getting that (single?) SSID configured. I would guess
the lib can be expanded to cover the full DBUS API of iwd, but that is
not our goal currently. I think there are many
projects/devices/products out there that want to configure the SSID
via a side-channel by code and not via iwctl. How would iwd community
recommend this be done?

(I also asked on the IRC channel, but there wasn't much traffic there
so I moved it to the mailing-list.)
--
Thanks, keeping being Awesome
Joakim Lotseng=C3=A5rd - Orbital Systems AB - www.orbital-systems.com
--===============1872523787116912844==--

