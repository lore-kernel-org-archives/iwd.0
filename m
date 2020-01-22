Content-Type: multipart/mixed; boundary="===============1566069138334653255=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] monitor: Add message length check to nlmon_receice
Date: Wed, 22 Jan 2020 11:53:47 -0600
Message-ID: <448ecb92-848c-a2b2-8aad-ebe4a1b1772e@gmail.com>
In-Reply-To: <20200122172621.kol6ix6dqyswefe2@beryllium.lan>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1566069138334653255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

>> NLMSG_OK and NLMSG_NEXT are macros in linux/netlink.h.  The problem is t=
hat
>> NLMSG_OK and NLMSG_NEXT expect to operate on an int according to 'man
>> netlink', but they don't actually cast the argument to an int.
>>
>> So what happens is that nlmsg_len underflows, wraps around to some large
>> number and the crash happens.
> =

> It's not the current message which triggers the crash, it's the next
> loop iteration which triggers the crash.

Right.  So after the last valid message, NLMSG_NEXT gets called which =

causes the underflow.  But since the type is unsigned, nlmsg_len just =

becomes a large number.  Then NLMSG_OK is invoked and thinks nlmsg_len =

is still all okay.

>>
>> Then I don't see how a crash would happen, wouldn't nlmsg_len just becom=
e 0
>> then?
> =

> The check would just abort the loop as soon a the lenght check
> triggers. I've tested the new version and nlmsg_len still got
> underflow but the macro aborts the loop now.

Right, that's the intent of NLMSG_OK and why it uses ints.

I still think the last message isn't *actually* aligned, but without =

crash data I can't prove it :)  It may be that most messages are indeed =

aligned, but the ones you're seeing this on are somehow special. =

Otherwise I don't see how we haven't detected this crash for so long.

> =

> Do you want me to send a new patch or are you going to fix it
> yourself? I don't mind :)

I went ahead and pushed 8b489d5df283 ("monitor: Fix crash") with your =

name on the Reported-By.

Regards,
-Denis
--===============1566069138334653255==--

