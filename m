Content-Type: multipart/mixed; boundary="===============1081774504745843016=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/7] ap: Refactor IP address selection
Date: Fri, 26 Feb 2021 15:31:25 -0600
Message-ID: <277c64ec-936f-ad70-61f4-43b14c40365d@gmail.com>
In-Reply-To: <CAOq732KTCr49vNTF+yDrRF5gt17VNDjZS37DUn8mZuC5gs6-bQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1081774504745843016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>>>
>>>> Also, have you tested what happens to the old address/netmask?  What s=
hould happen?
>>>
>>> We should be overwriting it (we use NLM_F_CREATE | NLM_F_REPLACE) but
>>> that doesn't seem to be happening, I confirmed this in test-runner
>>> now.  This patch is not changing that part of the code though, I'll
>>> try to debug this separately.
>>
>> Existing logic fails / doesn't do dhcp if we have an address set though,=
 but
>> fair enough.
> =

> I believe existing logic takes the address from the interface and uses
> that for DHCP (this is documented to have lower priority than
> [IPv4].Address in the profile but higher than [General].APRanges) so
> I'm just keeping that logic.

Ah yes, you're correct.  My bad.

> =

> I've been looking at this for a moment now and it seems if we're
> setting the addresses using RTNL we have to query all existing
> addresses and remove them one by one, there's no "flush" or "replace"

In theory there is the NLM_F_REPLACE flag.  Haven't played with it.

> message type, only "new" and "del".  However we could use the
> SIOCSIFADDR ioctl same as we're using SIOCGIFADDR for querying the IP
> now.
> =


The ioctl is a little limiting.  I suppose for our purposes it would work, =
but =

I'd rather use l_rtnl*.

Regards,
-Denis
--===============1081774504745843016==--

