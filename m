Content-Type: multipart/mixed; boundary="===============5107138444825147813=="
MIME-Version: 1.0
From: iwd@goodbit.net
Subject: DBus Systemd Unit Dependency
Date: Thu, 12 Mar 2020 01:48:23 +0000
Message-ID: <20200312014823.2753.66329@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5107138444825147813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

My Arch linux laptop hangs 90 seconds during shutdown due to NFS client unm=
ount timeouts.

Networking on this machine is WiFi only, controlled via iwd and systemd-net=
workd.
This is a day-one issue with iwd for me, and does not occur using wpa_suppl=
icant.

Digging into the logs, I see dbus being spontaneously killed prior to iwd g=
racefully disconnecting.
This of course causes iwd to prematurely terminate, causing my NFS unmount =
hangs


Mar 11 16:40:54 x360 iwd[465]: D-Bus disconnected, quitting...
Mar 11 16:40:54 x360 iwd[465]: Removing scan context for wdev 2
Mar 11 16:40:54 x360 systemd[1]: Stopping D-Bus System Message Bus...
Mar 11 16:40:54 x360 kernel: wlan0: deauthenticating from c6:**:1f:**:65:**=
 by local choice (Reason: 3=3DDEAUTH_LEAVING)
Mar 11 16:40:54 x360 systemd[1]: dbus.service: Succeeded.
Mar 11 16:40:54 x360 systemd[1]: Stopped D-Bus System Message Bus.
Mar 11 16:40:54 x360 audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D42949672=
95 ses=3D4294967295 msg=3D'unit=3Ddbus comm=3D"systemd" e>
Mar 11 16:40:54 x360 systemd[1]: Unmounting /mnt/fast...
Mar 11 16:40:54 x360 systemd-networkd[421]: wlan0: Link DOWN
...
Mar 11 16:42:24 x360 systemd[1]: mnt-fast.mount: Unmounting timed out. Term=
inating.
Mar 11 16:42:24 x360 systemd[1]: mnt-fast.mount: Mount process exited, code=
=3Dkilled, status=3D15/TERM
Mar 11 16:42:24 x360 systemd[1]: mnt-fast.mount: Failed with result 'timeou=
t'.


The supplied iwd.service file does not specifically state dbus as a depende=
ncy.
(It happens to work because dbus always started very early)
I have corrected my shutdown hang issue using the following override:


$ cat /etc/systemd/system/iwd.service.d/override.conf
[Unit]
BindsTo=3Ddbus.service
After=3Ddbus.service
--===============5107138444825147813==--

