Content-Type: multipart/mixed; boundary="===============3072173930254464874=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Move netconfig_reset() to common path
Date: Wed, 29 Sep 2021 18:09:12 -0500
Message-ID: <c545c951-dcf0-4e55-b426-65dc915dfb43@gmail.com>
In-Reply-To: CAOq732KhfeRcqU1_ss+gSQBgPY_w42s-Ac3dkOp8A2_J75EQFA@mail.gmail.com

--===============3072173930254464874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> Now, maybe some elements of what the connect failed path does might be n=
eeded in
>> this failure case.  But to determine that we would need to know why the
>> disconnect happens? How often? Is it every time? Sometimes? Once in a bl=
ue moon,
>> etc.
> =

> Unfortunately this applies to most failure modes in a connection (at
> 802.11 level or at IP level -- for the user they're the same thing)

I agree, but details matter.  So what is it you're proposing exactly?

> and I think the binary blacklisted/not blacklisted model we use
> doesn't really work.  IIRC my initial patches used a different model
> where the blacklist was a kind of penalty list where BSSes and/or
> networks that fail more often are pushed further in the priority list.

I remember, but we have since moved on from that model of autoconnect.  We =

autoconnect networks now, not individual BSSes.  Eventually we will move to=
 a =

network priority model in the future where the user will specify the priori=
ty of =

a given network for autoconnect.  Blacklisting within the network is a diff=
erent =

topic.  Also note that we have two levels of blacklisting, so it isn't quit=
e as =

simple as you describe.

> In the end when we've tried all the BSSes in range we have nothing to
> lose by retrying some of the ones we've already tried, we just don't
> want to put them before other BSSes.  This can be done in a way that

We do that already.

> over time the list converges to sorted by how often a network/bss
> fails.
> =

> This also allows you to learn from some very clear cues that we're not
> handling, like a user manually switching to another network.

Regards,
-Denis

--===============3072173930254464874==--

