Content-Type: multipart/mixed; boundary="===============8714799424996277785=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 5/7] ap: Refactor IP address selection
Date: Fri, 26 Feb 2021 22:14:34 +0100
Message-ID: <CAOq732KTCr49vNTF+yDrRF5gt17VNDjZS37DUn8mZuC5gs6-bQ@mail.gmail.com>
In-Reply-To: <6dc9f182-cd92-f2fb-324a-7be3396464c0@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8714799424996277785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Feb 2021 at 22:03, Denis Kenzior <denkenz@gmail.com> wrote:
> >> So would this handle duplicates or intersecting entries?
> >
> > No, duplicate subnets would have double the chance of being selected.
> > I can probably use the logic in ap_append_range to also remove the
> > duplicates if we care about it.
>
> Well, this is user-input, so you do need to be paranoid here.  At least w=
arn &
> ignore overlapping entries.  Or if you can normalize the entries, that wo=
uld be
> fine as well.

It could be intentional but fair enough, I'll just not add the
overlapping ranges to the list so every address has the same
probability of being selected.

>
> >>
> >> Also, have you tested what happens to the old address/netmask?  What s=
hould happen?
> >
> > We should be overwriting it (we use NLM_F_CREATE | NLM_F_REPLACE) but
> > that doesn't seem to be happening, I confirmed this in test-runner
> > now.  This patch is not changing that part of the code though, I'll
> > try to debug this separately.
>
> Existing logic fails / doesn't do dhcp if we have an address set though, =
but
> fair enough.

I believe existing logic takes the address from the interface and uses
that for DHCP (this is documented to have lower priority than
[IPv4].Address in the profile but higher than [General].APRanges) so
I'm just keeping that logic.

I've been looking at this for a moment now and it seems if we're
setting the addresses using RTNL we have to query all existing
addresses and remove them one by one, there's no "flush" or "replace"
message type, only "new" and "del".  However we could use the
SIOCSIFADDR ioctl same as we're using SIOCGIFADDR for querying the IP
now.

>
> >> Does it make sense to cache this value here instead of parsing it out =
each time?
> >
> > I can do that, these settings can't currently change since we don't
> > watch the config file for changes and we don't have any other
> > interfaces to set them, but I thought it may be better to not assume
> > that.
> >
> > In NM it was pointed out to me that for safety the policy is to not
> > cache settings unless you subscribe to change notifications,
> > regardless of whether the specific setting can change or not.
>
> Makes sense, but this is also about separating the global settings from t=
he
> profile ones.  Profile settings are already handled as you describe.  I a=
lso
> doubt that we can ever implement main.conf reloading in a sensible manner=
, so
> until that happens I'd rather be consistent with the rest of the codebase.

Ok.

Best regards
--===============8714799424996277785==--

