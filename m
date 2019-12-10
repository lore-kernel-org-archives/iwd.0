Content-Type: multipart/mixed; boundary="===============4928688957300624410=="
MIME-Version: 1.0
From: Simon Brand <simon.brand@postadigitale.de>
Subject: EAP-Method=PEAP and tls_reset_handshake/authentication timeout
 results in core-dumped
Date: Tue, 10 Dec 2019 05:51:24 +0100
Message-ID: <20191210045124.1cbd142d@hostpad>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4928688957300624410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I use a config with EAP-Method=3DPEAP and
EAP-PEAP-Phase2-Method=3DMSCHAPV2, which results in (random?) core-dump.
[0]
This happens after authentication timeout or tls_reset_handshake. [1]
My system is an uptodate arch linux machine with iwd 1.2-1, Linux
5.4.2-arch1-1, glibc 2.30-3. If you need more information I am happy to
provide it. There is no problem with PreSharedKey Wifis.
Thank you for your time and this great tool.

[0] http://sprunge.us/5Ez0pP
[1] http://sprunge.us/c13AYe

--===============4928688957300624410==--

