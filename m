Content-Type: multipart/mixed; boundary="===============8091831408062499893=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] netconfig: Add multiple levels to IWD_DHCP_DEBUG
Date: Wed, 18 May 2022 16:03:26 +0100
Message-ID: <CACsRnHWyCVqgz2Jh6Nr16SGVZVDvroeqCu+gXXVd+coo_AeK0w@mail.gmail.com>
In-Reply-To: fb1c5993-f6d3-a1cc-fdfc-4193dd4a768c@gmail.com

--===============8091831408062499893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 18 May 2022 at 15:06, Denis Kenzior <denkenz(a)gmail.com> wrote:

> Send it out and I'll ponder which one I like more.  I think longer term, =
it
> might be desirable to be able to quiet down some of this output, even for=
 iwd
> itself.

Ok, I've sent it out.

I also sent another ell patch for changes that would allow limiting
the iwd logging as well which I wrote when putting together a more
complex patch (before it got too complex). This would go better with
the second iwd patch as the verbosity can be reduced through a new
`l_log_set_max_level` function in ell/log and therefore IWD_DHCP_DEBUG
can remain simple.

I don't have a matching patch to limit logging verbosity in all of iwd
though it should be fairly straightforward to add.

Regards,
Michael
--===============8091831408062499893==--

