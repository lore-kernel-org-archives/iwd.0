Content-Type: multipart/mixed; boundary="===============6614762380679284867=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH] build: fix ell/shared build failure
Date: Sun, 02 May 2021 13:38:28 +0000
Message-ID: <bf26b6cb-b7c9-d665-a487-51b6544e6d4e@bang-olufsen.dk>
In-Reply-To: <120183FD-B683-465C-83FF-073BE6A149BE@holtmann.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6614762380679284867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 5/2/21 12:51 PM, Marcel Holtmann wrote:
> Hi Alvin,
> =

>> This is just a polite ping to the list in case this patch went unnoticed.
>>
>> Perhaps I should have given some extra background on this. We are
>> building iwd with Yocto/OE, and while bumping our recipe to iwd 1.13 -
>> which uses the tarball on kernel.org - I noticed that the build was
>> failing because of a missing ell/ directory.
>>
>> With the standard Yocto tooling, --disable-dependency-tracking is passed
>> by default to autotools builds[1]. Omitting this flag seems to solve the
>> problem.
>>
>> Marcel Holtmann already proposed this particular change on the list a
>> few weeks ago as a fix for a similar issue when building with
>> --enable-external-ell on Buildroot, but another solution was arrived at
>> in that thread. At any rate, it also addresses the build failure I
>> described above, so it seems to be a justifiable change. This is also
>> common practice for other ell/* targets in iwd's Makefile.am anyway.
>>
>> I am no autotools expert so I cannot really explain why
>> --disable-dependency-tracking and other flags cause the build to fail in
>> this way, but hopefully the above is a good enough justification for the
>> patch.
> =

> I think that I already pushed similar patch recently when updating BlueZ =
and oFono repositories.

Thanks. Yes you're right, I missed it. Looks like commit =

d87b580c207fc3e5da25b596f4cef21f4dc9a690 does the trick.

Kind regards,
Alvin
--===============6614762380679284867==--

