Content-Type: multipart/mixed; boundary="===============1230794918743186985=="
MIME-Version: 1.0
From: Bruce Johnson <waterfordtrack@gmail.com>
Subject: systemd startup notification for iwd?
Date: Thu, 10 Dec 2020 20:13:15 +0000
Message-ID: <20201210201315.2885.69092@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1230794918743186985==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I'm trying to figure out how to resolve what appears to be a race condition=
 between iwd and my application that uses it through the API. Despite my at=
tempts so far to tell systemd to start iwd before my application, the best =
I've gotten thus far is "Starting..." messages with the same timestamp for =
the two services. Has there been any consideration of adding a call to syst=
emd's sd_notify function when iwd is ready to accept requests?
--===============1230794918743186985==--

