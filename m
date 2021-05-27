Content-Type: multipart/mixed; boundary="===============1480504543325997095=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to NAT when using iwd ap mode?
Date: Thu, 27 May 2021 10:34:18 -0500
Message-ID: <9ffb37f4-a363-f2a6-f671-97f3b024be09@gmail.com>
In-Reply-To: <CAG17S_MiVCSBoVB9y3gLaey1H1xyLr2Dwu0WK5BFntPL_aavKQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1480504543325997095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

> =

> Denis,
> =

> Thanks, google did not help me find that page. It works for me. The

Of course not, I added it yesterday ;)

> only thing I would ask is: why do we have to set the 'APRanges=3D' in
> /etc/iwd/main.conf? Can this be set in ssid.ap? This is the only
> setting that I have found that needs to be set in main.conf for ap
> mode to work.

There's some flux in iwd in this area as we're still fleshing out AP profil=
es =

and how they're used.  We're moving to making this setting optional in the =

future.  For now, you can set it to something reasonable; the settings in t=
he AP =

profile take precedence.

Regards,
-Denis
--===============1480504543325997095==--

