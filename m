Content-Type: multipart/mixed; boundary="===============5223102859838926740=="
MIME-Version: 1.0
From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: iwd crashing when run in different network namespace
Date: Wed, 04 Dec 2019 14:26:37 +0000
Message-ID: <87a789ph52.fsf@toke.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5223102859838926740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

I have been periodically trying out iwd, but haven't managed to get it
to work yet. After the 1.0 release I thought I'd give it another try,
and finally got around to it now, with my distribution-provided package
(Arch Linux, iwd 1.1-2).

Now, my setup is a bit unusual: I move my physical network adapter to a
separate network namespace, and run the WiFi configuration daemon (thus
far wpa_supplicant) in there. Thus, I want to do the same with iwd,
which doesn't seem to be working.

I added an override file to move the systemd service:

$ cat /etc/systemd/system/iwd.service.d/override.conf
[Unit]
JoinsNamespaceOf=3Dnetns(a)physical.service

[Service]
PrivateNetwork=3Dyes


$ sudo ip netns exec physical iw  phy | head -n 1
Wiphy phy1

However, when I try to start iwd, all I get is an error message and a
crash:

Dec 03 16:02:45 my-laptop systemd[1]: Starting Wireless service...
Dec 03 16:02:45 my-laptop iwd[159840]: Wireless daemon version 1.1
Dec 03 16:02:45 my-laptop iwd[159840]: Loaded configuration from /etc/iwd/m=
ain.conf
Dec 03 16:02:45 my-laptop systemd[1]: Started Wireless service.
Dec 03 16:02:45 my-laptop audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42=
94967295 ses=3D4294967295 ms
g=3D'unit=3Diwd comm=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=
=3D? addr=3D? terminal=3D? res=3Dsuccess'
Dec 03 16:02:45 my-laptop iwd[159840]: Can't read /sys/class/ieee80211/phy1=
/device/driver: No such file or directory
Dec 03 16:02:45 my-laptop audit[159840]: ANOM_ABEND auid=3D4294967295 uid=
=3D0 gid=3D0 ses=3D4294967295 pid=3D159840 comm=3D"iwd" exe=3D"/usr/lib/iwd=
/iwd" sig=3D11 res=3D1
Dec 03 16:02:45 my-laptop systemd[1]: Started Process Core Dump (PID 159841=
/UID 0).
Dec 03 16:02:45 my-laptop audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D42=
94967295 ses=3D4294967295 msg=3D'unit=3Dsystemd-coredump(a)25-159841-0 comm=
=3D"systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? termina=
l=3D? res=3Dsuccess'
Dec 03 16:02:45 my-laptop systemd[1]: iwd.service: Main process exited, cod=
e=3Ddumped, status=3D11/SEGV
Dec 03 16:02:45 my-laptop systemd[1]: iwd.service: Failed with result 'core=
-dump'.
Dec 03 16:02:45 my-laptop audit[1]: SERVICE_STOP pid=3D1 uid=3D0 auid=3D429=
4967295 ses=3D4294967295 msg=3D'unit=3Diwd comm=3D"systemd" exe=3D"/usr/lib=
/systemd/systemd" hostname=3D? addr=3D? terminal=3D? res=3Dfailed'
Dec 03 16:02:45 my-laptop systemd-coredump[159842]: Process 159840 (iwd) of=
 user 0 dumped core.
                                                   =

                                                   Stack trace of thread 15=
9840:
                                                   #0  0x00006a95dc9ee6f5 _=
_strlen_avx2 (libc.so.6)
                                                   #1  0x00006a95dc961c34 f=
nmatch@@GLIBC_2.2.5 (libc.so.6)
                                                   #2  0x0000074127bc397b n=
/a (iwd)
                                                   #3  0x0000074127bf2f30 n=
/a (iwd)
                                                   #4  0x0000074127bef804 n=
/a (iwd)
                                                   #5  0x0000074127bee9ed n=
/a (iwd)
                                                   #6  0x0000074127beeabe n=
/a (iwd)
                                                   #7  0x0000074127beece0 n=
/a (iwd)
                                                   #8  0x0000074127b946c2 n=
/a (iwd)
                                                   #9  0x00006a95dc8b4153 _=
_libc_start_main (libc.so.6)
                                                   #10 0x0000074127b94e4e n=
/a (iwd)
Dec 03 16:02:45 my-laptop systemd[1]: systemd-coredump(a)25-159841-0.servic=
e: Succeeded.

The file referenced in the error message does exist:

$ sudo ip netns exec physical ls /sys/class/ieee80211/phy1/device/driver -l
lrwxrwxrwx 1 root root 0 Dec  3 16:21 /sys/class/ieee80211/phy1/device/driv=
er -> ../../../../bus/pci/drivers/iwlwifi

Any chance someone could take a look at this?

Thanks!

-Toke
--===============5223102859838926740==--

