Content-Type: multipart/mixed; boundary="===============7047539877132107256=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Tue, 17 May 2022 14:23:18 -0500
Message-ID: <f688e6b8-8bf5-4b6e-1092-ff1283ea4c80@gmail.com>
In-Reply-To: CACsRnHUpN+fXLekfFKzX4LmJKE_H5thYW9LK-5eXzXtw5Fy0VA@mail.gmail.com

--===============7047539877132107256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

>> This changes the semantics slightly.  In our wiki, etc we show IWD_DHCP_=
DEBUG
>> with value "1" to enable debugging, so I think we should be nice and kee=
p that
>> behavior if possible.  How about:
>>
>> if IWD_DHCP_DEBUG is not set, use L_LOG_WARNING.
>>
>> If IWD_DHCP_DEBUG is set and has a non-NULL value, use L_LOG_DEBUG
>>
>> If the value above is from the set L_LOG_ERR .. L_LOG_DEBUG (3 .. 7), th=
en use that.
> =

> I made this change but it seems quite difficult to explain in a
> reasonable way to the user why the values are 3, 4, 6, and 7.
> How about using strings instead? `info`, `warn`, `error`, `debug`?
> That still allows us to keep the old behavior if it's a `1`.

Sure, that sounds even better.

> =

> I'm also questioning if I should keep the L_LOG_WARN as the default or
> make it L_LOG_INFO which is more in line with what I intended when I
> started (i.e. not setting the env should result in similar output to
> other DHCP clients). Do you prefer WARN?

If you intended this to be info, then do that.  iwd prints l_info, l_error =
and =

l_warn messages by default and only l_debug is enabled via '-d'.

Regards,
-Denis
--===============7047539877132107256==--

