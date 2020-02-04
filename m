Content-Type: multipart/mixed; boundary="===============2754351319092498667=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wiphy: Relpace rawmemchr with memchr
Date: Tue, 04 Feb 2020 10:55:21 -0600
Message-ID: <4c7aabda-4d35-4a90-fce9-786e0d247126@gmail.com>
In-Reply-To: <124a2f29aacf742c57b51ac1c59cd4040542a0c5.camel@redrectangle.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2754351319092498667==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robert,

> Your patch works fine for me and looks like a better approach.

Great!  Thanks for testing.

> =

> This got me curious, so I looked at what glibc does:
> http://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dstring/rawmemchr.c;=
h=3Db62d285d7efa882b3928fae03318273d588f15bd;hb=3DHEAD
> =

> I expect the use of strlen when looking for null is slightly faster, but
> probably doesn't really matter here.

Yeah, strlen might be a bit faster indeed.  But I was feeling lazy and =

this isn't used for anything performance critical. :)

> =

> Thanks for taking a look and working on a fix!
> =


No worries.  I pushed out this fix upstream now.

Regards,
-Denis
--===============2754351319092498667==--

