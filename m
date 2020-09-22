Content-Type: multipart/mixed; boundary="===============0476185137974061979=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/5] resolve: Exit methods if resolve is NULL
Date: Tue, 22 Sep 2020 06:18:33 +0200
Message-ID: <CAOq732Lnr0pLjLFX5b53ZfFRaMWK9WnDSd9eaOv9Mc5Y0a-www@mail.gmail.com>
In-Reply-To: <0d7bba65-3fa4-c721-b8b1-90a3d5ecb577@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0476185137974061979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Tue, 22 Sep 2020 at 05:32, Denis Kenzior <denkenz@gmail.com> wrote:
> On 9/21/20 2:04 PM, Andrew Zaborowski wrote:
> > If no resolve method gets configured, the resolve_new() call in
> > netconfig returns NULL.  To avoid adding checks netconfig every time
> > netconfig->resolve is used, add these checks directly in the resolve_*
> > methods.  Fixes the following crash:
>
> Hmm, how exactly is this triggered?  I'm fairly certain I made it so that
> resolve module fails to start if the resolve method is mis-configured.  S=
ee
> resolv.c:568 or so.

Good point, it's because I don't have
General.EnableNetworkConfiguration or
General.enable_network_configuration so resolve_init() exits early.
I'm still using netconfig from P2P, I guess we shouldn't require
General.EnableNetworkConfiguration to be set for P2P.  P2P doesn't
(usually) have DNS so this should still work but maybe the checks
should be in netconfig.c after all, not sure.

>
> >
> > src/netconfig.c:netconfig_destroy()
> > Aborting (signal 11) [/path/iwd]
> > ++++++++ backtrace ++++++++
> >   #0  0x7f3ee427f210 in /lib/x86_64-linux-gnu/libc.so.6
> >   #1  0x43bcf4 in resolve_revert() at src/resolve.c:85
>
> I wonder why you crash here and not in .add_dns or .add_domain_name

Because the dhcp lease doesn't have DNS information.

Best regards
--===============0476185137974061979==--

