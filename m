Content-Type: multipart/mixed; boundary="===============8975794195770443472=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Sun, 17 Nov 2019 00:57:07 +0100
Message-ID: <CAOq732+Sx72GrmL9y7yG6f7UNEu3Bma8TJuF5tgB8uzaC3KYMg@mail.gmail.com>
In-Reply-To: <03165533-fb0a-4c37-24fa-3a88d7bfcbbb@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8975794195770443472==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sat, 16 Nov 2019 at 05:12, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/15/19 9:02 PM, Andrew Zaborowski wrote:
> > On Sat, 16 Nov 2019 at 03:28, Denis Kenzior <denkenz@gmail.com> wrote:
> >>>>    And if we become a GO, then things
> >>>> become even more funny since we can only send invites, not actually
> >>>> initiate a connection.
> >>>
> >>> Invitation is just a technical name for a frame sequence, group
> >>> formation is another, but it's just ways to connect to a device.  Note
> >>> how Android shows the same Accept/Decline dialog whether you're using
> >>> group formation or invitation. (same or similar... I thought the
> >>> wording was the same but don't have screenshots at hand)
> >>
> >> - How are you handling the case where the Peer wants us to display our
> >> PIN?  And provision discovery in general?
> >
> > We can add a signal for this, but this is independent of the role and
> > not a high priority.
>
> It sort of is.  How is the user notified that some other device is
> trying to connect to us?  How do they know its time to enter the
> password or just display it on the screen?

Device to device connections weren't really my concern for this
iteration of the API, but I think we may have even talked about having
an optional agent to receive the invitations / new connections.  I
guess your use case is something like file sharing?  Note that there's
no standard service for this, you need to choose one of a hundred apps
incompatible between each other, and you need to have a compatible app
on the other end.

>
> And a signal is not enough as the UI might want to perform an
> authorization step here as well.
>
> >
> > Do we have a use case for this?
>
> Absolutely.
>
> >
> >> - Invitations?
> >> - invitation by a P2P Device (not group owner) of another P2P Device?
> >
> > We don't need to unless we're also going to be running on peripheral
> > devices, but that's not our current use case.
>
> The latter is optional and of dubious value.  The former might be kind
> of important.
>
> >
> >> - The fact that GO has a bunch of stats about its clients and you
> >> probably want to expose that similarly to AP mode?
> >
> > We don't expose anything in AP mode?
> >
>
> AP mode isn't really finished.  We need to add this some day.

Things like bandwidth usage, IP?  They should probably use the same
property names for both AP and P2P.

>
> > Our main use case is to provide bluetooth-like connections to devices.
> >
> >> - The fact that GO has to handle connections from legacy clients and
> >> thus needs to provide legacy WPS methods?
> >
> > Is there a use case for this?
> >
>
> If you want to pass conformance tests it is.  See Table 7: GOUT Protocol
> Conformance Tests in the Wi-Fi Direct Test plan.

I can't find this document right now but I assume there's a few more
things that may be not worth the effort implementing and are required
for certification.

>
> >> - persistent groups, with custom or saved credentials?
> >
> > We will need to start saving credentials because that's something
> > that's actually in use, and we need to do this both on the GO and
> > client.
>
> Fair enough.
>
> >
> >>
> >> To me it seems quite impractical to mix GO and client and to try and
> >> hide these details.  I have very strong doubts you will succeed here.
> >>
> >> And I also think you're not avoiding exposing topology details.  For
> >> example, is Peer.Disconnect resulting in a disconnection of a single
> >> peer or group tear down?
> >
> > Assuming that is the last peer in that group then either will work, I
> > don't see the difference here.
>
> But you may want to keep the group around.   Anyway, this is not a
> biggie but I think you're making an assumption this would never be wanted.

It may be wanted or it may be the default if we manage to become the
GO (the peer may in theory require the GO role).  But it may be a
config setting.

>
> >
> > If there are more peers then obviously you don't want to break things
> > by disconnecting them?
>
> Sure, this one is obvious.
>
> >
> >>
> >> I think you really need to send a v4.  I just don't see how you're
> >
> > Yes, we agreed on that, although I'm still missing any reasoning for
> > the Cancel method for example.  If you have ideas on how to handle the
>
> That's just how Station & WSC work today, and actually work pretty well
> compared to any other WPS API I saw.  I don't see why following the same
> pattern is so bad?  In the end the user still invokes a single method
> and gets connected.
>
> Really, all your criticisms apply to station/wsc as well.  But then
> aborts are sort of an uncommon case anyway.
>
> > following I'd also welcome them:
> >
> >   * how to best signal whether the device is available to start a new c=
onnection,
> >     assuming you didn't like the AvailableConnections (int) property.
>
> At the moment I think exposing the role is the way to go.  But feel free
> to convince me otherwise.

So I was rather thinking of one simple property to indicate if we can
start a new connection and/or how many.  This would combine at least:

 * our P2P role,

 * whether we're already connected (in other words whether we have as
many active connections as max allowed P2P interfaces...)

 * whether we're currently connecting/disconnecting as a P2P client
(during those operations the Connected property will be false in my
current design)

 * whether we're currently in Group Formation in which case we're not
allowed do anything as either client or GO.

>
> >
> >   * how to trigger device discovery, optimally in a way that forces the
> > client to stop it after
> >     a while, basically to make sure it's not left running when the UI
> > isn't active.  For
> >     example for our "agents" we automatically detect if they're
> > disconnected, here we
> >     probably also want the client to "own" the scan in some way.
>
> One idea would be to add a StartDiscovery / StopDiscovery methods and
> track client state.  So if a client drops off the bus, then we
> automatically stop discovery sessions initiated by it.  This could also
> be used to send parameters for the discovery.  E.g. only WFD devices.
> Each distinct dbus client (i.e. dbus unique service name) can set its
> own parameters for peers it is interested in.

Ok.

Best regards
--===============8975794195770443472==--

