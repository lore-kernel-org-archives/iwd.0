Content-Type: multipart/mixed; boundary="===============6843149626645503735=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Thu, 14 Nov 2019 20:37:49 +0100
Message-ID: <CAOq732LyHrLpTyR-qU6Hons4eNK-xnxv2S_LeYJ91AqXytPh6A@mail.gmail.com>
In-Reply-To: <87661ec5-d56b-2463-e6b6-11dd8c2db072@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6843149626645503735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2019 at 19:20, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/14/19 10:59 AM, Andrew Zaborowski wrote:
> > I didn't plan to interpret the contents of the IE in any way.  The
> > idea would be to have little service-specific code, and in case of WFD
> > there's no need to do anything more than passing the ies.
>
> So two issues:
> - Passing in unchecked binary info from an unprivileged process is just
> not going to happen though.  We have to look inside anyway to sanitize it.

Fair enough, although I think the level of sanitization would only
need to be the same as when we send out an SSID provided by an
unprivileged process... we only check it's utf-8, not too long and
such.

> - Some of the sub elements are dynamic (connected bssid for example).
> So you will end up having to interpret it anyway.

AFAIK we don't strictly need to do anything and things will work just
like with wpa_supplicant... but we could.

>
> >
> > So I see only two options, either full on binary IE passed in both
> > directions between iwd and the service implementation, or full on
> > individual values from the WFD subelements.  There's a lot of them
> > though, for example for a probe response you have at least:
> >
> >   * 12 capability bits in a bitmap
> >   * RTSP tcp port
> >   * throughput
> >   * optional coupled sink status
> >   * optional coupled sink MAC
> >   * R2 support (true/false)
> >
> > + 10 or more optional values...
>
> So lets start with the bare minimum and see.  In the end this API is
> experimental, so we can still change things.

Ok, let's do it.  I don't like that because we're again creating
barriers for client software to start supporting iwd, and adding more
work for iwd to do while doing this.

>
> >
> > I just had a look at the how gnome-screencast is passing those to NM /
> > wpa_supplicant and they basically hardcode the IE in one place in the
> > code and never touch the contents...  On receival they only check if
> > the WFD IEs were present and don't really look at the contents either.
> > This is very new code though and I haven't looked at openwfd or
> > miraclecast in detail.
>
> Even more reason not to bother with passing IEs around.
>
> <snip>
>
> >>
> >>> +
> >>> +Methods              array(on) GetPeers()
> >>> +
> >>> +                     Returns a list (possibly empty) of detected P2P=
 peers.
> >>> +                     Each record returned contains a tuple of the fo=
llowing
> >>> +                     values.
> >>> +
> >>> +                     object Object
> >>> +
> >>> +                             net.connman.iwd.P2PPeer object represen=
ting
> >>
> >> Name this iwd.Peer?
> >
> > Sounds very generic, are we sure we won't have another spec that uses
> > "peers" too?
>
> I'm not aware of any.  But P2PPeer does not CamelCase well regardless.
> I'm happy to hear other ideas.
>
> <snip>
>
> >>> +             void RegisterSignalLevelAgent(object path,
> >>> +                                              array(int16) levels)
> >>> +
> >>> +                     Register the agent object to receive signal str=
ength
> >>> +                     level change notifications on the
> >>> +                     net.connman.iwd.SignalLevelAgent interface, see
> >>> +                     signal-level-agent-api.txt.  The "levels"
> >>
> >> We moved this into the station api.  So maybe just refer to that here.=
..
> >>
> >> Though really, I wonder if you even want to bother with this for the
> >> first iteration?  I'd maybe leave this out?
> >
> > Yeah, I wasn't going to implement it at this time.  But since you'll
> > have RSSI in every mode of wireless connections, AP, adhoc, ...
> > wouldn't it make sense to have a common interface and share code in
> > iwd and in the clients?
>
> You don't though.  For AP you have multiple clients, which rssi are you
> going to show?

That would be per client obviously, when/if information about the
clients is added.

> Same goes for p2p-go really.

With P2P we are initiating the connections, so we have to expose
information about each peer anyway.

> With adhoc you have an
> even weirder problem.
>
> >>> +             void RegisterWFDService(object path, array(byte) payloa=
d)
> >>
> >> I would maybe make this a bit more generic in case other P2P services
> >> are supported in the future, like file sharing, etc.
> >
> > I was thinking of having a separate agent interface and separate
> > register method for each service, the parameters are going to be
> > different... but we could also have a common register method and
> > another method on the service's agent to query the actual values of
> > the parameters (at the cost of additional round trips)
> >
>
> I'd just make this into a dictionary of parameters and have it depend on
> the service type.

Ok, sounds good.

>
> >>
> >> But, I'm not sure this belongs here?  P2P is a per-phy interface; do y=
ou
> >> really want the clients to register WiFi Display per phy?  Or just once
> >> and have it apply to all devices in the system, current or ones yet to
> >> be plugged in?  Perhaps we need a ServiceManager or add this to
> >> AgentManager API?
> >
> > Yep, perhaps a ServiceManager (P2PServiceManager?) is a better place...
> >
> >>
> >> I suppose it might be in theory possible to support both a Sink and a
> >> Source role on different phys, but then shouldn't you be distinguishing
> >> between the roles somehow?
> >
> > It is possible but luckily it's all up to the wfd implementation.
> > We'd only see this information if we wanted to build the WFD IEs
> > ourselves like you suggest but we wouldn't be doing anything more than
> > encoding / decoding it from the IEs.
>
> Then we can't do this as a global registration.  Because some
> sub-elements are dynamic it would be up to the application to update the
> IE properly.  I'm really not sure we can avoid building the WFD IE
> ourselves.

I think it should still be global actually, but maybe we need to
expand the API somehow.  I think it should be global because an
application like gnome-screencast is not going to know which device to
use.  But we may need to add a way for the service to say it's
connected now so that its not considered for any simultaneous
connections, until the first connection is closed.

So since our assumption is that we're always initiating our
connections (or in the future responing to an invitation, but the
response is again our initiative), we could also register services
per-connection and per-scan?  This would work for gnome-screencast,
since I believe it has its own dialog that shows you available devices
to connect to... not sure about other services.

>
> <snip.
>
> >>> +             uint16 MaxConnections [readonly]
> >>> +
> >>> +                     Maximum number of concurrent P2P peers that loc=
al
> >>> +                     hardware is capable of connecting to.  Often 1.
> >>
> >> I think we've talked about this before.  Given what we now know, I wou=
ld
> >> drop this for now.  I think the likelihood of this becoming > 1 is
> >> astronomically small and we shouldn't even worry about this.
> >
> > So I don't really have enough information to say that, the 2 P2P
> > capable adapters that I worked with only support one client or one GO
> > interface but those are only 2 adapters.
> >
> > I have actually changed this since this proposal to be named
> > AvailableConnections and switch between 1 and 0 as the device becomes
> > busy.  So it has an additional use of indicating whether a connection
> > is in progress... the Connected property on the Peer only becomes 1
> > when the connection is operative.
>
> Yeah, but that's the problem.  What do you actually mean by
> AvailableConnections?  Do you mean:
>
> 1.  connections on a given P2P_CLIENT or P2P_GO interface?  or
> 2.  number of P2P_CLIENT & P2P_GO interfaces?

So this should not bleed into the API.  As long as we allow the user
to make another connection, it should be signalled to the user
somehow.  Whether we're using a separate interface or just make
another connection from our GO interface.

>
> If 1, then this makes no sense anyway.  For P2P_CLIENT it is always 1.
> For P2P_GO it is essentially unlimited.

Right, but we need to inform the user somehow whether we can make
another connection with whatever role we have currently negotiated or
because we're idle.

(and for P2P_GO we may want to set an artificial limit, it's only
unlimited in theory)

>
> For 2, I doubt you will ever find any hardware capable of doing more
> than 1 anyway.  And it is a complication I wouldn't worry about now
> regardless.  So if the v1 API is limited to a single connection and we
> later find out it is actually possible to do more, then we worry about
> it then.

So from what I've seen, it is possible, but not until we support the
GO role.  However our main usecase right now (I believe...) is a PC,
phone, tablet, rather than a peripheral device, so I think this is
definitely going to be expected from iwd, so are you sure you want to
limit the API to a single connection?

AFAIK the android API for apps doesn't have this limit for example.

>
> >
> >> This means
> >> we can also move some attributes / methods from the Peer interface onto
> >> this one.
> >
> > So this is a slightly different topic and I wouldn't do it.
> > Apparently some device will make sure they become the GO during GO
> > Negotiation (or as soon as P2P is enabled) and then use the invitation
> > procedure instead of the group formation procedure, so then they can
> > be connected to multiple peripherals and this seems to be an actual
> > use case.
>
> Yeah, see above.  You're talking about 1 here.  And I'd argue that
> AvailableConnections or MaxConnections still doesn't make sense in this
> context.
>
> >
> > MaxConnections still doesn't sound right because in theory there's no
> > maximum, but we still need some way to indicate if we're busy.
>
> Exactly.  So you need to find another way.

Hmm, maybe a 'State' property but I'm not sure how to call the
different states to make this clear...

>
> >>> +
> >>> +Methods              ConnectPushButton()
> >>> +
> >>> +                     Connect to the P2P peer in the Push Button mode
> >>> +                     using the device pointed to by the .Device prop=
erty.
> >>> +                     Returns when connection is complete.
> >>
> >> Why are you method names different from SimpleConfiguration?  in fact,
> >> why not just add .SimpleConfiguration interface to the same object path
> >> and just have clients use that?
> >
> > Could do this, yes, although it would have been nice to have "Connect"
> > in the method names.  And I'm not sure how to resolve this in the code
> > since the implementation of the methods will be very different from
> > the one in wsc.c, preferably I wouldn't duplicate setup_wsc_interface.
>
> Pretty easy I would think?  I mean you do have the netdev associated
> with it, so you can simply check the interface type.

We only have a netdev after the GO Negotiation.

Esentially I'd need to have a new struct wsc, which would encapsulate eithe=
r:

 * a current struct wsc for a station interface, or
 * a P2P peer that corresponds to a scan result.

Then the wsc.c PushButton method, for instance, would need to either
do its current work or delegate it to a p2p.c function and exit.

>
> >>> +
> >>> +             Disconnect() [optional]
> >>
> >> A method can't be optional?
> >
> > Well since the optional concept is kind of made up it just means
> > returning an error when the method or property doesn't apply.
>
> Made up?  I don't think so.  Properties are explicitly allowed to be
> optional.  Methods are not.  Check the D-Bus spec ;)

You mean https://dbus.freedesktop.org/doc/dbus-specification.html ?  I
think we've talked about optional properties not being considered in
the specs before...

>  We never had any
> optional methods and never will :)
>
> >>> +             boolean Connected [readonly]
> >>> +
> >>> +                     Whether there's currently an active connection
> >>> +                     to this peer.  The property is read-only and
> >>> +                     changes as a result of the Connect and
> >>> +                     Disconnect methods calls.
> >>
> >> This wording might need to be updated....
> >
> > You mean because we'd only have one connection?
>
> Sorry, should have been more clear.  The Connect and maybe even
> Disconnect method calls will be named differently.  So the wording needs
> to be updated accordingly.
>
> >>
> >> Okay, so you want to notify the agent instead of adding a WFD specific
> >> interface to the Peer object.  I still wonder if we can avoid
> >> transporting raw IEs here... Also, how are you making sure that the
> >> peers are actually ones that the agent cares about?  There's no sense =
in
> >> sending Source role peer info if we're also a Source...
> >>
> >> Can we be a source and a sink at the same time?
> >
> > Yeah, but I don't really see benefit in hiding the WFD sources if
> > we're the source, or WFD sinks if we're a sink.  It'll be simpler for
> > everyone if the WFD service takes care of this.
>
> That goes against our core design principles and you know it :)

I think it depends on the point of view.  You might as well want the
caller to specify what service or device class or WSC method it's
interested in and only show them matching peers.  You could even do
things like this for normal infrastructure-mode networks.

Best regards
--===============6843149626645503735==--

