Content-Type: multipart/mixed; boundary="===============5917414464060729625=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Wed, 18 May 2022 09:06:17 -0500
Message-ID: <fb1c5993-f6d3-a1cc-fdfc-4193dd4a768c@gmail.com>
In-Reply-To: CACsRnHX=UMyWm2EiC8CXDsopbg=k3s+pKjXWZ7TjEX-Qpqw_OQ@mail.gmail.com

--===============5917414464060729625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 5/18/22 07:36, Michael Johnson wrote:
> Hi Denis,
> =

> On Tue, 17 May 2022 at 20:23, Denis Kenzior <denkenz(a)gmail.com> wrote:
>> If you intended this to be info, then do that.  iwd prints l_info, l_err=
or and
>> l_warn messages by default and only l_debug is enabled via '-d'.
> =

> This makes me think DHCP should just follow the same pattern for
> simplicity. I have sent a new patch which always enable DHCP info
> level logging and if the user sets IWD_DHCP_DEBUG then bump it up to
> debug.
> This patch is much simpler and doesn't change the behavior of the env
> var but it comes with the downside of not being able to quieten it
> (although that is similar to iwd).
> =

> I have the v3 version of this patch ready with the string comparisons
> if you prefer the first approach.

Send it out and I'll ponder which one I like more.  I think longer term, it =

might be desirable to be able to quiet down some of this output, even for i=
wd =

itself.

Regards,
-Denis
--===============5917414464060729625==--

