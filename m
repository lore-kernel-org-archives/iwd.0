Content-Type: multipart/mixed; boundary="===============8697732257573814276=="
MIME-Version: 1.0
From: Toke =?unknown-8bit?q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: Re: Connected network only shown after iwd restart
Date: Sat, 08 Feb 2020 00:22:39 +0100
Message-ID: <87y2teasow.fsf@toke.dk>
In-Reply-To: <61F8B0DD-7574-4EE8-AA46-F3DE1510BF9A@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8697732257573814276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Kourt, Tim A" <tim.a.kourt@intel.com> writes:

> Hi Toke,
>
> =EF=BB=BF-----Original Message-----
> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> Date: Tuesday, February 4, 2020 at 7:36 AM
> To: "iwd(a)lists.01.org" <iwd@lists.01.org>
> Subject: Connected network only shown after iwd restart
>     =

>     $ iwctl station wlan0 show
>                                      Station: wlan0                      =
          =

>     ---------------------------------------------------------------------=
-----------
>       Settable  Property            Value                                =
          =

>     ---------------------------------------------------------------------=
-----------
>                 Scanning            no
>                 State               connected
>     =

>     =

>     =

>     Is this a bug, or am I doing something wrong when using iwctl?
>
> Indeed, this was a bug and it should now be fixed upstream.
>
> Thanks for the report.

Yup, can confirm that this now works as expected in current git head.
Thank you for the quick fix! :)

-Toke
--===============8697732257573814276==--

