Content-Type: multipart/mixed; boundary="===============1558011588391631888=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: How to configure an IoT wifi setup
Date: Wed, 19 May 2021 14:36:24 -0500
Message-ID: <CAG17S_McO=OtGotbDn7ccDSbzu7vA_T4-ge593owud37bLBr+Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1558011588391631888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Group,

I am not sure if this is the right terminology but this is what I am
trying to do:
Power up a headless device. If it does not get an ethernet or wifi
connection, it launches AP mode of some sort and allows a device to
connect then configure the wifi connection by selecting an AP and
typing in a password.

This works with hostapd/dsnmasq, currently. I want to switch over to
connman and/or iwd to do this, but have not been successful in doing
this.

If I set up connman by:
"# connmanctl tether wifi on SSID password" I can connect and 'see' my
new SSID, but I cannot scan for any APs to set up. I do not know how
to set the SSID IP address, if this has been enabled in connman.

I have tried with iwctl as well:
set up /etc/iwd/main.conf
[General]
EnableNetworkConfiguration=3Dtrue
APRanges=3D192.168.1.0/24

# iwctl device wlan0 set-property Mode ap
# iwctl ap wlan0 start SSID password

With this I can connect, but once again, I cannot scan for any
available SSIDs to connect to. It is not important that I be able to
connect, but I do need to see the SSIDs so the user can set it up then
reboot (or restart connman/iwd) to connect to the new 'known' SSID.

Thanks,

Keith
--===============1558011588391631888==--

