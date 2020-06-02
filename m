Content-Type: multipart/mixed; boundary="===============2243115676282833615=="
MIME-Version: 1.0
From: dapolinario@gmail.com
Subject: Start iwd only after dbus
Date: Tue, 02 Jun 2020 03:35:12 +0000
Message-ID: <20200602033512.2851.79090@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2243115676282833615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When iwd is not synchronized to start after dbus, NetworkManager often does=
 not identify that the service is already running and does not manage the w=
ireless interface.

I suggest adding the line "After=3Ddbus.service" in "iwd.service" in the [U=
nit] section, so NetworkManager always identifies that iwd is working.
--===============2243115676282833615==--

