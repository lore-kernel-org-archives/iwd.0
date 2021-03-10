Content-Type: multipart/mixed; boundary="===============0274534539659947095=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/6] netdev: use NL80211_STA_INFO_SIGNAL rather than
 average
Date: Wed, 10 Mar 2021 13:16:11 -0800
Message-ID: <4f64f3881804e4c0281ccd3e57e4656dee823507.camel@gmail.com>
In-Reply-To: <ecea1d5c-606f-c6d1-d253-521581dfe030@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0274534539659947095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-10 at 15:12 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 3/10/21 2:27 PM, James Prestwood wrote:
> > Since GET_STATION (and in turn GetDiagnostics) gets the most
> > current station info this attribute serves as a better indication
> > of the current signal strength. In addition full mac cards don't
> > appear to always have the average attribute.
> > ---
> >   src/netdev.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> =

> This seems fine, so I went ahead an applied it.  I do wonder if we
> should parse =

> SIGNAL_AVG and report it separately (if available).

Sure I can do that as well. It is probably a better indicator anyways
for what most people would care about.

> =

> Regards,
> -Denis

--===============0274534539659947095==--

