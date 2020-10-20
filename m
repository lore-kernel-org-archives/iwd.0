Content-Type: multipart/mixed; boundary="===============7483269230481952589=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 12/13] ap: add support for DHCPv4 server
Date: Tue, 20 Oct 2020 22:48:10 +0200
Message-ID: <CAOq732KJpw9Vz9t-4PFUSHiupdXPK56yjgBrVf_+ZFAfDrpXDA@mail.gmail.com>
In-Reply-To: <b111caae-01da-a122-0ba0-afb024baa384@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7483269230481952589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 20 Oct 2020 at 20:51, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi James,
>
> On 10/20/20 1:41 PM, James Prestwood wrote:
> > On Tue, 2020-10-20 at 13:28 -0500, Denis Kenzior wrote:
> >> Hi James,
> >>
> >> On 10/20/20 1:02 PM, James Prestwood wrote:
> >>> The DHCP server can be enabled by including an [IPv4] group
> >>> in the AP provisioning file and including at least a subnet
> >>> mask.
> >>
> >> Any chance we can add this code to the current implementation without
> >> changing
> >> the API just yet?  I think it is safe to assume that if the address
> >> is set prior
> >> to AP starting on a given interface, then we should not start our own
> >> DHCP, and
> >> if the address isn't set, then start DHCP server.  If the address is
> >> provided by
> >> provisioning, then start our own DHCP as well, overriding whatever we
> >> picked.
> >
> > Sure, so keep the 'psk' DBus argument and remove [Security].Passphrase?
> > It seems weird to have both since we would be ignoring one.
>
> I don't know yet.  I don't think removing the simple 'Start' method which=
 just
> provides an SSID and PSK is a good idea.  It is useful for quick and dirty
> setups.  Provisioning files might be for more advanced users and might ne=
ed
> their own dedicated Start method.  So something like KnownNetwork(s) but =
for
> AccessPointConfiguration(s).

I replied to a different patch in this series without seeing this
thread, but basically I agree with what Denis said, I prefer if we
keep the DBus arguments unchanged.

>
> >
> > But do we really want to make the decision to use DHCP based on if the
> > address is set? It really seems like the user would want to decide that
> > explicitly with a config file. OTOH if all no DHCP options are required
> > (using defaults) we would need some way of knowing to start DHCP or
> > not. I just don't see a correlation between the address being set and
> > the user wanting/not wanting a DHCP server.
>
> Well, the user has to first switch the device into AP mode or create the
> required interface first somehow.  So before they actually hit .Start, th=
ey have
> a chance to configure the IP or not.  If the IP is configured, then we as=
sume
> the interface is managed by someone else.  If it isn't, we take ownership.
>
> I suppose we can add an explicit setting in main.conf somewhere, or in the
> profile itself.  But I'd keep things simple for now.

Maybe we can re-use [General].EnableNetworkConfiguration for the basic
on/off switch and possibly allow individual access point config files
to override this?

In the case of Network Manager users, if they're interfacing with IWD
through NM they will currently not want DHCP as either client or
server, and if they use iwctl they might want DHCP everywhere.

Also for the record, NM only sets the local IP after the AP is started.

>
> >>
> >> I think we may need Andrew's opinion on whether these should be part
> >> of
> >> ap_config.  P2P might not really care about setting up these
> >> variables and would
> >> prefer for ap.c to just figure things out.
> >
> > Sure, but they aren't required anyways so p2p doesn't have to include
> > them and defaults will be used (once netmask is fixed). The ap_config
> > structure was just a convenient storage object for these but we could
> > define something else too.
>
> Yes, true.  But not much sense in actually storing them long-term if that=
's the
> case.  Generate them / load from settings, give them to dhcp-server and f=
orget.

It does seem logical to put those settings in struct ap_config.  P2P
wouldn't normally need to use them, it should be fine with the
defaults although I'm thinking in the future there may be exceptions
where we need to work around client's bugs (hopefully not).

Note that the P2P Group Owner will need to decide on an IP for itself
and the client before the 4-Way Handshake starts to implement the
optional IP assignment during the handshake.

Best regards
--===============7483269230481952589==--

