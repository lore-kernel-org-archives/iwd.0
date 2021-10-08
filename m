Content-Type: multipart/mixed; boundary="===============6407373961812021323=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd access point mode
Date: Fri, 08 Oct 2021 13:25:57 -0500
Message-ID: <af68e3d3-d4cf-8e3e-fd1e-3a72a202f769@gmail.com>
In-Reply-To: CAOf5uwmuz-S8_XO9HD-h_2rr5YOi6M50Fg4nh9yXYkCh2mEVTA@mail.gmail.com

--===============6407373961812021323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

> Anyway I have tested but it seems that it does not work for me.
> Virtual node are there
> but iwd pick one of them and they are not destroyed as you said
> =


Okay, should be fixed now upstream with commit: a0017405064c ("manager: =

Initialize all default interfaces")

I'm not sure what you mean by 'they are not destroyed' though?

Regards,
-Denis
--===============6407373961812021323==--

