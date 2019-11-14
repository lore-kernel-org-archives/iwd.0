Content-Type: multipart/mixed; boundary="===============6931147065472731396=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Thu, 14 Nov 2019 17:59:41 +0100
Message-ID: <CAOq732LOs7Ru+zxhH=WCj5QDWy6SBWX9LTvhHWx2SH2zgFY9zQ@mail.gmail.com>
In-Reply-To: <99990fc4-80d3-020c-4fe3-cf28f97067b7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6931147065472731396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, 14 Nov 2019 at 05:42, Denis Kenzior <denkenz@gmail.com> wrote:
> On 10/10/19 3:51 PM, Andrew Zaborowski wrote:
> > Proposed minimum P2P interfaces for establishing basic connections.  The
> > device discovery results in creation of P2PPeer objects.
> >
> > In the Wi-Fi Display API we are passing raw IE data because there's a
> > relatively big set of different values that may be encoded in them.  We
> > could reduce them to 2-3 bools and integers but this might limit the
> > client implementations feature set.
>
> So I'm not really a huge fan of this.  We'd still need to be able to
> understand what is inside the IE in order to verify it properly.  I'd
> err on the side of providing some attributes instead of full on binary
> IEs.
>
> Also, some of the subelements involved should really be filled in by iwd
> itself and not the external application.  Otherwise you'll end up with
> some sort of Frankenstein where the app provides some info but we'd need
> to rewrite or modify it anyway.

I didn't plan to interpret the contents of the IE in any way.  The
idea would be to have little service-specific code, and in case of WFD
there's no need to do anything more than passing the ies.

So I see only two options, either full on binary IE passed in both
directions between iwd and the service implementation, or full on
individual values from the WFD subelements.  There's a lot of them
though, for example for a probe response you have at least:

 * 12 capability bits in a bitmap
 * RTSP tcp port
 * throughput
 * optional coupled sink status
 * optional coupled sink MAC
 * R2 support (true/false)

+ 10 or more optional values...

I just had a look at the how gnome-screencast is passing those to NM /
wpa_supplicant and they basically hardcode the IE in one place in the
code and never touch the contents...  On receival they only check if
the WFD IEs were present and don't really look at the contents either.
This is very new code though and I haven't looked at openwfd or
miraclecast in detail.

>
> > ---
> >   doc/p2p-api.txt                | 82 ++++++++++++++++++++++++++++++++++
> >   doc/p2p-peer-api.txt           | 66 +++++++++++++++++++++++++++
> >   doc/p2p-wfd-agent-api.txt      | 34 ++++++++++++++
> >   doc/signal-level-agent-api.txt |  4 ++
> >   4 files changed, 186 insertions(+)
> >   create mode 100644 doc/p2p-api.txt
> >   create mode 100644 doc/p2p-peer-api.txt
> >   create mode 100644 doc/p2p-wfd-agent-api.txt
> >
> > diff --git a/doc/p2p-api.txt b/doc/p2p-api.txt
> > new file mode 100644
> > index 00000000..84f862e5
> > --- /dev/null
> > +++ b/doc/p2p-api.txt
> > @@ -0,0 +1,82 @@
> > +P2P hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service              net.connman.iwd
> > +Interface    net.connman.iwd.P2P [Experimental]
> > +Object path  /{phy0,phy1,...}
>
> So we changed the paths for 1.0 and this might need to be updated.

Right.

>
> > +
> > +Methods              array(on) GetPeers()
> > +
> > +                     Returns a list (possibly empty) of detected P2P p=
eers.
> > +                     Each record returned contains a tuple of the foll=
owing
> > +                     values.
> > +
> > +                     object Object
> > +
> > +                             net.connman.iwd.P2PPeer object representi=
ng
>
> Name this iwd.Peer?

Sounds very generic, are we sure we won't have another spec that uses
"peers" too?

>
> > +                             the peer device.
> > +
> > +                     int16 SignalStrength
> > +
> > +                             Peer's maximum signal strength expressed
> > +                             in 100 * dBm.  The value is the range of 0
> > +                             (strongest signal) to -10000 (weakest sig=
nal)
> > +
> > +             void RegisterSignalLevelAgent(object path,
> > +                                              array(int16) levels)
> > +
> > +                     Register the agent object to receive signal stren=
gth
> > +                     level change notifications on the
> > +                     net.connman.iwd.SignalLevelAgent interface, see
> > +                     signal-level-agent-api.txt.  The "levels"
>
> We moved this into the station api.  So maybe just refer to that here...
>
> Though really, I wonder if you even want to bother with this for the
> first iteration?  I'd maybe leave this out?

Yeah, I wasn't going to implement it at this time.  But since you'll
have RSSI in every mode of wireless connections, AP, adhoc, ...
wouldn't it make sense to have a common interface and share code in
iwd and in the clients?

>
> > +                     parameters decides the thresholds in dBm that will
> > +                     generate a call to the agent's Changed
> > +                     method whenever current RSSI crosses any of the
> > +                     values.  The values must be passed in descending
> > +                     order.  The number and distance between requested
> > +                     threshold values is a compromise between resoluti=
on
> > +                     and the frequency of system wakeups and
> > +                     context-switches that are going to be occuring to
> > +                     update the client's signal meter.  Only one agent
> > +                     can be registered at any time.
> > +
> > +                     Possible Errors: [service].Error.InvalidArguments
> > +                                      [service].Error.Failed
> > +                                      [service].Error.AlreadyExists
> > +                                      [service].Error.NotSupported
> > +
> > +             void RegisterWFDService(object path, array(byte) payload)
>
> I would maybe make this a bit more generic in case other P2P services
> are supported in the future, like file sharing, etc.

I was thinking of having a separate agent interface and separate
register method for each service, the parameters are going to be
different... but we could also have a common register method and
another method on the service's agent to query the actual values of
the parameters (at the cost of additional round trips)

>
> But, I'm not sure this belongs here?  P2P is a per-phy interface; do you
> really want the clients to register WiFi Display per phy?  Or just once
> and have it apply to all devices in the system, current or ones yet to
> be plugged in?  Perhaps we need a ServiceManager or add this to
> AgentManager API?

Yep, perhaps a ServiceManager (P2PServiceManager?) is a better place...

>
> I suppose it might be in theory possible to support both a Sink and a
> Source role on different phys, but then shouldn't you be distinguishing
> between the roles somehow?

It is possible but luckily it's all up to the wfd implementation.
We'd only see this information if we wanted to build the WFD IEs
ourselves like you suggest but we wouldn't be doing anything more than
encoding / decoding it from the IEs.

>
> > +
> > +                     Register the Wi-Fi Display service running on loc=
al
> > +                     host with this P2P device so that device discovery
> > +                     and connection setup phases include necessary WFD
>
> okay...
>
> > +                     information for the peers and receive peer's WFD
> > +                     service information.  An object may be provided to
> > +                     receive relevant WFD information about peers and
> > +                     connections through method calls on the object's
> > +                     net.connman.iwd.P2PWFDAgent interface.  See
> > +                     p2p-wfd-agent-api.txt.  Only one agent can be
> > +                     registered at any time.  The byte array provided
> > +                     will be included in WFD Information Elements
> > +                     present in relevant frames sent to peers.
>
> So besides the IE information (which I don't really want transported in
> binary), what real use is the WFD agent?

So it would be receiving events on a new WFD connection and during
discovery it would be receiving the capabilities etc. of the
discovered peers.

>
> > +
> > +                     Possible Errors: [service].Error.InvalidArguments
> > +                                      [service].Error.AlreadyExists
> > +                                      [service].Error.NotSupported
> > +
> > +Properties   boolean Enabled [readwrite]
> > +
> > +                     Whether local P2P device is started, i.e. is scan=
ning
> > +                     for peers, is discoverable by peers and/or connec=
ted
> > +                     to peer(s).
> > +
> > +             string Name [readwrite]
> > +
> > +                     Sets local P2P device name as it is going to be
> > +                     presented on other devices that we will connect to
> > +                     or ones that discover us in scanning.
> > +
> > +             uint16 MaxConnections [readonly]
> > +
> > +                     Maximum number of concurrent P2P peers that local
> > +                     hardware is capable of connecting to.  Often 1.
>
> I think we've talked about this before.  Given what we now know, I would
> drop this for now.  I think the likelihood of this becoming > 1 is
> astronomically small and we shouldn't even worry about this.

So I don't really have enough information to say that, the 2 P2P
capable adapters that I worked with only support one client or one GO
interface but those are only 2 adapters.

I have actually changed this since this proposal to be named
AvailableConnections and switch between 1 and 0 as the device becomes
busy.  So it has an additional use of indicating whether a connection
is in progress... the Connected property on the Peer only becomes 1
when the connection is operative.

> This means
> we can also move some attributes / methods from the Peer interface onto
> this one.

So this is a slightly different topic and I wouldn't do it.
Apparently some device will make sure they become the GO during GO
Negotiation (or as soon as P2P is enabled) and then use the invitation
procedure instead of the group formation procedure, so then they can
be connected to multiple peripherals and this seems to be an actual
use case.

MaxConnections still doesn't sound right because in theory there's no
maximum, but we still need some way to indicate if we're busy.

>
> > diff --git a/doc/p2p-peer-api.txt b/doc/p2p-peer-api.txt
> > new file mode 100644
> > index 00000000..898f4fb9
> > --- /dev/null
> > +++ b/doc/p2p-peer-api.txt
> > @@ -0,0 +1,66 @@
> > +P2PPeer hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service              net.connman.iwd
> > +Interface    net.connman.iwd.P2PPeer [Experimental]
> .iwd.Peer?
>
> > +Object path  /{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}
>
> Object path needs to be updated post 1.0
>
> > +
> > +Methods              ConnectPushButton()
> > +
> > +                     Connect to the P2P peer in the Push Button mode
> > +                     using the device pointed to by the .Device proper=
ty.
> > +                     Returns when connection is complete.
>
> Why are you method names different from SimpleConfiguration?  in fact,
> why not just add .SimpleConfiguration interface to the same object path
> and just have clients use that?

Could do this, yes, although it would have been nice to have "Connect"
in the method names.  And I'm not sure how to resolve this in the code
since the implementation of the methods will be very different from
the one in wsc.c, preferably I wouldn't duplicate setup_wsc_interface.

>
> > +
> > +                     Possible errors: net.connman.iwd.Aborted
> > +                                      net.connman.iwd.Busy
> > +                                      net.connman.iwd.Failed
> > +                                      net.connman.iwd.NotSupported
> > +                                      net.connman.iwd.Timeout
> > +                                      net.connman.iwd.InProgress
> > +
> > +             ConnectPIN(string pin)
> > +
> > +                     Connect to the P2P peer in PIN mode.  Returns when
> > +                     connection is complete.
> > +
> > +                     See net.connman.iwd.WiFiSimpleConfiguration.Start=
PIN()
> > +                     for how the pin argument is used.
> > +
> > +                     Possible errors: net.connman.iwd.Aborted
> > +                                      net.connman.iwd.Busy
> > +                                      net.connman.iwd.Failed
> > +                                      net.connman.iwd.NotSupported
> > +                                      net.connman.iwd.Timeout
> > +                                      net.connman.iwd.InProgress
> > +
> > +             Disconnect() [optional]
>
> A method can't be optional?

Well since the optional concept is kind of made up it just means
returning an error when the method or property doesn't apply.

> Anyway, I'd put this on the P2P interface
> instead.
>
> > +
> > +                     If connected, disconnect from this peer.
> > +
> > +                     Possible errors: net.connman.iwd.Failed
> > +
> > +Properties   string Name [readonly]
> > +
> > +                     P2P Peer's display name
> > +
> > +             string DeviceCategory [readonly]
> > +
> > +                     The category part of the peer's declared
> > +                     Primary Device Type.
> > +
> > +             string DeviceSubcategory [readonly, optional]
> > +
> > +                     The Sub Category part of the peer's declared
> > +                     Primary Device Type.
> > +
> > +             object Device [readonly]
> > +
> > +                     The object with a net.connman.iwd.P2P interface
> > +                     that discovered this peer.
>
> Okay
>
> > +
> > +             boolean Connected [readonly]
> > +
> > +                     Whether there's currently an active connection
> > +                     to this peer.  The property is read-only and
> > +                     changes as a result of the Connect and
> > +                     Disconnect methods calls.
>
> This wording might need to be updated....

You mean because we'd only have one connection?

>
> > diff --git a/doc/p2p-wfd-agent-api.txt b/doc/p2p-wfd-agent-api.txt
> > new file mode 100644
> > index 00000000..be0ee01b
> > --- /dev/null
> > +++ b/doc/p2p-wfd-agent-api.txt
> > @@ -0,0 +1,34 @@
> > +P2PWFDAgent hierarchy
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Service              unique name
> > +Interface    net.connman.iwd.P2PWFDAgent
> > +Object path  freely definable
> > +
> > +Methods              void Release(object device)
> > +
> > +                     This method gets called when IWD unregisters the
> > +                     WFD service on a specific P2P device. An agent can
> > +                     use it to do cleanup tasks. There is no need to
> > +                     unregister the agent, because when this method
> > +                     gets called it has already been unregistered.
> > +
> > +             void WFDPeersChanged(object device,
> > +                                     array(object, array(byte)) peers)
> > +
> > +                     Called when the set of discovered WFD-capable
> > +                     peers has changed during device discovery.
> > +
> > +                     The device object has the net.connman.iwd.P2P
> > +                     interface while the objects in the peers array
> > +                     have net.connman.iwd.P2PPeer interfaces.  The byte
> > +                     array included contains the reassembled payload of
> > +                     the WFD Information Elements presented by the pee=
r.
>
> Okay, so you want to notify the agent instead of adding a WFD specific
> interface to the Peer object.  I still wonder if we can avoid
> transporting raw IEs here... Also, how are you making sure that the
> peers are actually ones that the agent cares about?  There's no sense in
> sending Source role peer info if we're also a Source...
>
> Can we be a source and a sink at the same time?

Yeah, but I don't really see benefit in hiding the WFD sources if
we're the source, or WFD sinks if we're a sink.  It'll be simpler for
everyone if the WFD service takes care of this.

>
> > +
> > +             void NewConnection(object peer, array(byte) payload)
> > +
> > +                     Called when a new P2P connection has been establi=
shed
> > +                     to a WFD-capable peer.  The peer object has the
> > +                     net.connman.iwd.P2PPerr interface.  The byte array
>
> typo
>
> > +                     contains the reassembled payload of the WFD
> > +                     Information Elements presented by the peer.
>
> So I'm not entirely sure how this is useful?  The fact that we made a
> connection to a peer is already available via the Peer.Connected
> property.  Is the payload somehow different from what was sent via
> WFDPeersChanged?

Hmm, no, it should be the same in practice, so yeah, we can maybe drop this.

The spec actually has a different subset of subelements allowed in
each frame (Associate vs. Beacon or Probe Response) but in
wpa_supplicant for example, you set one WFD IE for all possible
frames.

The bit that might change is "Available for WFD Session" now that I
think of it... but I assume when a device is not available it simply
won't be discovering or entering group formation.  But it could be a
candidate for modifying inside iwd rather than taking a value from the
DBus client.

By the way, one thing that needs to change in this proposal is how
peer discovery (scanning) is triggered and how the current state is
signalled.  Discovery is more expensive than we previously thought and
can't be automatically enabled whenever the P2P interface is enabled.

Best regards
--===============6931147065472731396==--

