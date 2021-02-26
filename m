Content-Type: multipart/mixed; boundary="===============8350348375740770026=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/7] ap: Refactor IP address selection
Date: Fri, 26 Feb 2021 14:44:05 -0600
Message-ID: <6dc9f182-cd92-f2fb-324a-7be3396464c0@gmail.com>
In-Reply-To: <CAOq732LKtMjQB3n01w4Qu14M16QB_zP99XQ4PiDqhQJ26Yokhw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8350348375740770026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> So would this handle duplicates or intersecting entries?
> =

> No, duplicate subnets would have double the chance of being selected.
> I can probably use the logic in ap_append_range to also remove the
> duplicates if we care about it.

Well, this is user-input, so you do need to be paranoid here.  At least war=
n & =

ignore overlapping entries.  Or if you can normalize the entries, that woul=
d be =

fine as well.

>>
>> Also, have you tested what happens to the old address/netmask?  What sho=
uld happen?
> =

> We should be overwriting it (we use NLM_F_CREATE | NLM_F_REPLACE) but
> that doesn't seem to be happening, I confirmed this in test-runner
> now.  This patch is not changing that part of the code though, I'll
> try to debug this separately.

Existing logic fails / doesn't do dhcp if we have an address set though, bu=
t =

fair enough.

>> Does it make sense to cache this value here instead of parsing it out ea=
ch time?
> =

> I can do that, these settings can't currently change since we don't
> watch the config file for changes and we don't have any other
> interfaces to set them, but I thought it may be better to not assume
> that.
> =

> In NM it was pointed out to me that for safety the policy is to not
> cache settings unless you subscribe to change notifications,
> regardless of whether the specific setting can change or not.

Makes sense, but this is also about separating the global settings from the =

profile ones.  Profile settings are already handled as you describe.  I als=
o =

doubt that we can ever implement main.conf reloading in a sensible manner, =
so =

until that happens I'd rather be consistent with the rest of the codebase.

Regards,
-Denis
--===============8350348375740770026==--

