Content-Type: multipart/mixed; boundary="===============6585740954736062012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Sun, 22 Aug 2021 13:36:51 -0500
Message-ID: <22f7a9d9-c52e-44c7-2541-f8f4b451a610@gmail.com>
In-Reply-To: <CAJtNWJjw3SMQ2PX1u9X9=_gzejBYkejf64=eQCr0v1oKLNajWg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6585740954736062012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> Diff shows some new "SAE Hunting and Pecking" algorithm used and a "AP di=
d not =

> include group number in response!" info, though not sure if related.

It is.  Looks like the Nest advertises SAE H2E support and we try to use th=
at =

but something goes wrong.  Can you capture a log with iwmon?

https://iwd.wiki.kernel.org/debugging

Regards,
-Denis
--===============6585740954736062012==--

