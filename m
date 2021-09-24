Content-Type: multipart/mixed; boundary="===============4325688287165616119=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Fri, 24 Sep 2021 13:36:59 -0500
Message-ID: <ef7434c7-5ada-0e44-e9a4-f9f13d5f8b62@gmail.com>
In-Reply-To: 163250782332.7.11536917905459787462.14147429@slmail.me

--===============4325688287165616119==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jason,

> Well, I've discovered how to trigger the problem in my scenario. It's all=
 related with setting AddressRandomization to 'network'. The other two poss=
ible values 'disabled' (default) and 'once' both work fine.

Well, I'm even more stumped then.  Looking at the commits in 1.18, I do not =

believe we changed anything even remotely related to this.  Even more =

interesting is that this only happens on boot and not in subsequent attempt=
s =

which makes this hard to duplicate.

I'll poke around some more, but I think a git bisect is the only way to nar=
row =

this down.

Regards,
-Denis
--===============4325688287165616119==--

