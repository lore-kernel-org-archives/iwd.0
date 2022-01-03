Content-Type: multipart/mixed; boundary="===============0494653930758622731=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Doesn't create global config file or its directory (/etc/iwd/)
Date: Mon, 03 Jan 2022 14:34:32 -0600
Message-ID: <376533bb-ed0b-fdc4-203d-5c62cab26132@gmail.com>
In-Reply-To: 35676143.AJtQQQMBzY@bagend

--===============0494653930758622731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diederik,

> The Debian maintainer informed me that there isn't such a config file in =
the
> upstream source code and I think it would be helpful if the directory wit=
h the
> correct permissions and the config file, which could f.e. only contain a
> commented reference to the iwd.config man page, would be created OOTB.

I added a sample doc/main.conf in commit:
04fccea63bd4 ("doc: Add sample main.conf file").  We used to have something =

similar, but it was removed by commit:
e915156be1c6 ("doc: Remove obsolete main.conf example file")

The sample covers main.conf options that should be most relevant towards th=
e use =

case you describe.  If I missed some, we can add them as needed.  Let us kn=
ow if =

this is what the Debian package maintainer had in mind.

Regards,
-Denis
--===============0494653930758622731==--

