Content-Type: multipart/mixed; boundary="===============4857458096288764762=="
MIME-Version: 1.0
From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: Connected network only shown after iwd restart
Date: Tue, 04 Feb 2020 16:36:27 +0100
Message-ID: <875zgmfjpg.fsf@toke.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4857458096288764762==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi

I'm having some trouble with getting iwctl to show which network is
currently connected. If I leave iwctl running while I start (or restart)
iwd, everything is fine:

[iwd]# station wlan0 show
                                 Station: wlan0                            =
    =

---------------------------------------------------------------------------=
-----
  Settable  Property            Value                                      =
    =

---------------------------------------------------------------------------=
-----
            Scanning            no
            State               connected
            Connected network   myssid


But if I start iwctl after iwd (or, I suspect, after the network is
connected?), e.g. from the command line, I just get this:

$ iwctl station wlan0 show
                                 Station: wlan0                            =
    =

---------------------------------------------------------------------------=
-----
  Settable  Property            Value                                      =
    =

---------------------------------------------------------------------------=
-----
            Scanning            no
            State               connected



Is this a bug, or am I doing something wrong when using iwctl?

-Toke
--===============4857458096288764762==--

