Content-Type: multipart/mixed; boundary="===============7834621261164219687=="
MIME-Version: 1.0
From: Kristian Klausen <kristian@klausen.dk>
Subject: Issue with IWD 1.3 and connecting with PEAP
Date: Wed, 18 Dec 2019 09:50:06 +0100
Message-ID: <1514c8fc-0b71-d1c6-f31d-987f4748d2a0@klausen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7834621261164219687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

I just upgraded to IWD 1.3 and I can't connect to my school network anymore.
The "handshake" fails with:
iwd[581]: PEAP: Generated compound MAC and server compound MAC don't match.
iwd[581]: 4-Way handshake failed for ifindex: 5, reason: 15

I'm not sure if the school network is incorrectly configured, if that is =

the case, it would be nice if I could disable "Crypto-Binding".

I use IWD with NetworkManager 1.20.8 and a IWD config similar to this:
[Security]
EAP-Method=3DPEAP
EAP-Identity=3D<username>
EAP-Password=3D<password>
EAP-PEAP-Phase2-Method=3DMSCHAPV2
EAP-PEAP-Phase2-Identity=3D<username>
EAP-PEAP-Phase2-Password=3D<password>
[Settings]
Autoconnect=3Dtrue


Best regards
Kristian Klausen


--===============7834621261164219687==--

