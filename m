Content-Type: multipart/mixed; boundary="===============3176836087288489337=="
MIME-Version: 1.0
From: abagnale20@protonmail.com
Subject: Issue connecting to PEAP (eduroam)
Date: Fri, 31 Jan 2020 11:11:51 +0000
Message-ID: <20200131111151.2820.65195@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3176836087288489337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

first of all thank you very much for your efforts to develop iwd! I really =
enjoy its speed, simplicity and minimal resources.
I have been using it for months on several networks without problem, yet I =
can't get my uni's eduroam to work.

My config:
--------------
[Security]
EAP-Method=3DPEAP
EAP-Identity=3Deduroam(a)stud.uni-stuttgart.de
EAP-PEAP-CACert=3D/etc/iwd/ca.pem
EAP-PEAP-Phase2-Method=3DMSCHAPV2
EAP-PEAP-Phase2-Identity=3D<username>

The relevant log from /usr/lib/iwd/iwd -d:
-----------------------------------------------------
src/station.c:station_handshake_event() Handshaking
src/netdev.c:netdev_control_port_frame_cb() 0
src/netdev.c:netdev_unicast_notify() Unicast notification 129
src/netdev.c:netdev_control_port_frame_event() =

4-Way handshake failed for ifindex: 2, reason: 15

What is reason 15?

The ca.pem file resides in /etc/iwd/. I copied the certificates section fro=
m the eduroamCAT python installer script into ca.pem, if that info is of an=
y help.

Any ideas?
--===============3176836087288489337==--

