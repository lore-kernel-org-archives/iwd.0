Content-Type: multipart/mixed; boundary="===============6582700261772203474=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/5] resolve: Exit methods if resolve is NULL
Date: Tue, 22 Sep 2020 16:28:49 +0200
Message-ID: <CAOq732LEKzjdC7gDhn13n9rVQ5m9KksjHwonafV1HAVeESmKWw@mail.gmail.com>
In-Reply-To: <ec201fd0-16cf-f111-215a-afbc50c08cf3@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6582700261772203474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 22 Sep 2020 at 16:19, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/21/20 11:18 PM, Andrew Zaborowski wrote:
> > I'm still using netconfig from P2P, I guess we shouldn't require
> > General.EnableNetworkConfiguration to be set for P2P.  P2P doesn't
> > (usually) have DNS so this should still work but maybe the checks
> > should be in netconfig.c after all, not sure.
>
> I don't think it makes sense to have this asymmetry.  Why is P2P special
> compared to normal station client?

We also don't have any configuration for P2P netconfig because the
spec mandates the use of DHCP.  There's also no legacy to worry about,
so I don't see the point of making DHCP optional for P2P.

Best regards
--===============6582700261772203474==--

