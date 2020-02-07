Content-Type: multipart/mixed; boundary="===============6137761606674655366=="
MIME-Version: 1.0
From: Kourt, Tim A <tim.a.kourt@intel.com>
Subject: Re: Connected network only shown after iwd restart
Date: Fri, 07 Feb 2020 21:26:37 +0000
Message-ID: <61F8B0DD-7574-4EE8-AA46-F3DE1510BF9A@intel.com>
In-Reply-To: <875zgmfjpg.fsf@toke.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6137761606674655366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Toke,

=EF=BB=BF-----Original Message-----
From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
Date: Tuesday, February 4, 2020 at 7:36 AM
To: "iwd(a)lists.01.org" <iwd@lists.01.org>
Subject: Connected network only shown after iwd restart
    =

    $ iwctl station wlan0 show
                                     Station: wlan0                        =
        =

    -----------------------------------------------------------------------=
---------
      Settable  Property            Value                                  =
        =

    -----------------------------------------------------------------------=
---------
                Scanning            no
                State               connected
    =

    =

    =

    Is this a bug, or am I doing something wrong when using iwctl?

Indeed, this was a bug and it should now be fixed upstream.

Thanks for the report.

Regards,
Tim



--===============6137761606674655366==--

