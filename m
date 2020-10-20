Content-Type: multipart/mixed; boundary="===============7017946405205627801=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 12/13] ap: add support for DHCPv4 server
Date: Tue, 20 Oct 2020 23:41:37 +0200
Message-ID: <CAOq732KCxCjXvhw7pbjC-7wZ6yv+3nzXS3B1n3ibb+ro1RncTA@mail.gmail.com>
In-Reply-To: <82799cec-7d2a-a1fb-cbbb-f58a1a509b2c@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7017946405205627801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Oct 2020 at 23:03, Denis Kenzior <denkenz@gmail.com> wrote:
> >>>> I think we may need Andrew's opinion on whether these should be part
> >>>> of
> >>>> ap_config.  P2P might not really care about setting up these
> >>>> variables and would
> >>>> prefer for ap.c to just figure things out.
> >>>
> >>> Sure, but they aren't required anyways so p2p doesn't have to include
> >>> them and defaults will be used (once netmask is fixed). The ap_config
> >>> structure was just a convenient storage object for these but we could
> >>> define something else too.
> >>
> >> Yes, true.  But not much sense in actually storing them long-term if t=
hat's the
> >> case.  Generate them / load from settings, give them to dhcp-server an=
d forget.
> >
> > It does seem logical to put those settings in struct ap_config.  P2P
> > wouldn't normally need to use them, it should be fine with the
> > defaults although I'm thinking in the future there may be exceptions
> > where we need to work around client's bugs (hopefully not).
> >
> > Note that the P2P Group Owner will need to decide on an IP for itself
> > and the client before the 4-Way Handshake starts to implement the
> > optional IP assignment during the handshake.
>
> Hmm, wouldn't it make sense for AP to figure out the setup and for P2P to=
 just
> use that?  Especially if we start supporting persistent groups eventually.

Yeah, normally P2P doesn't need to fix specific IP vaues, it can let
AP use its defaults.

Even with persistent groups afaik mainly the PSK is persisted, IPs can
differ between each session.

>
> You do bring up a good point that we'd need a 'reserve' API of sorts on t=
he DHCP
> server side.  That way IP details for the handshaking client can be
> pre-populated if IP configuration through the handshake is supported.

Usually we'll just have one client.  Even with multiple clients we can
use disjoint ranges of IPs for DHCP and for the 4-Way handshake IP
setup... but we could instead 'reserve' an IP for the client and offer
it through both methods.

Many standalone APs let you manually assign IPs to MACs, including IPs
in the DHCP range, so it may be useful to have this option.

Best regards
--===============7017946405205627801==--

