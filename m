Content-Type: multipart/mixed; boundary="===============0448441674495190603=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 05:02:41 +0100
Message-ID: <CAOq732+BabRdrYctt6R-0KmWNQQBLK51ZMZd62eCWHXSDs=hQw@mail.gmail.com>
In-Reply-To: <4c084756-efee-be95-c4c2-7d3cae407fe8@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0448441674495190603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Nov 2019 at 04:27, Denis Kenzior <denkenz@gmail.com> wrote:
> >> For now I'd ignore this and assume we can only do one role at a time.
> >
> > Right.  But I'm thinking if there is a whole better way of doing the
> > service registration, i.e. per connection instead of globally.  Say
> > your use case is you're connecting first to a TV and then to a
> > keyboard, or simultaneously (as a GO).  There's no point advertising
> > the WFD capabilities to the keyboard device or to anyone other than
>
> I actually wouldn't expect this to be a good idea.  Once you start
> advertising a set of IEs as a P2P GO, I'm not sure changing these is
> really something that is expected, particularly when you already have a
> peer connection established.  Changing the contents to signal some state
> is probably OK (this is done in WSC for example).  But taking out IEs
> entirely is a bit of a gray area.

Right, but passing the WFD IE in the Association Request kind of
signals that you want to establish a WFD connection and you don't want
it for your second connection.  You can keep signalling it in your
beacons, although once the user has closed the screencasting app, I
wouldn't worry about just removing those IEs from the beacons even
though you may still be connected to the hypothetical P2P keyboard.

>
> See for example:
>
> WFD Session Availability bits:
> 0b00: Not available for WFD Session
>
> Or Section 5.2.1:
> "If a WFD Device acts as a P2P Group Owner, the WFD Device shall insert
> one or more WFD IEs after the other information elements in the Beacon
> frames it transmits. "
>
> I assume that at least the WFD spec wants you to twiddle the contents of
> the IEs and not remove IEs entirely.
>
> > the TV, once your WFD session is running and functional.  Maybe the
> > ServiceManager is the wrong way to go and the Connect / PushButton
> > method should receive the relevant information.
>
> And don't you need the advertising data before you even get to the point
> where you can invoke operations on the Peer interface?

In theory you need to advertise it in your scan.  Like I mentioned in
another email, I think the scans should also be explicitly triggered
by the apps because they're expensive, so those would also need to
know the service parameters.

Maybe that's too complicated for now and we better try a global
P2PServiceManager thing first.

>
> >> Then just indicate what role we have and let the application make that
> >> choice.  So if we're in P2P_GO mode, it can try to establish another
> >> connection.  And if we're in P2P_CLIENT mode, tough luck.
> >
> > I think it would be nicer to just prefer GO automatically (maybe
> > without forcing it), for example by having the GO Intent default to 14
> > out of 15 and be configurable in main.conf.
> >
>
> Yes, sure.  What I'm saying though is that once we're connected, we
> should indicate the topology somehow.

I think we should just indicate that we can still attempt more
connections, optimally without exposing the P2P roles.

>
> >> Why? The hardware is the arbiter of this in the end.
> >
> > Some dedicated access points have trouble serving 10 connections
> > simultaneously on one radio channel so for our off the shelf hardware
> > and minimal ap.c code it's going to be very difficult.
>
> And?  Any limit you pick will end up being wrong for someone.
>
> >>
> >> Ah, imprecise wording here.  By single connection I mean a single
> >> P2P_GO/P2P_CLIENT interface active at a time.  So if we're in P2P_GO
> >> mode, we can do multiple 'connections'.  But since we're not doing
> >> P2P_GO yet, then effectively we would only support a single active peer
> >> today.
> >
> > So I assume you're Ok having the Disconnect method on the Peer
> > interface, not on P2PDevice? So that our DBus clients are prepared to
> > support multiple connections instead of 1?
>
> I think these two things are somewhat orthogonal.  We can still have
> Disconnect on the Device and not the peer.  All that would do is
> preclude us from disconnecting individual links in P2P GO mode.  But
> sure, I suppose it can remain on the Peer object.
>
> >
> > Or I wonder if we should repurpose WSC.Cancel to also disconnect a
> > fully established connection.  There's no need for separate Cancel and
> > Disconnect methods, but Disconnect sounds more correct.
> >
>
> Cancel only applies to the discovery and configuration procedure.  The
> WSC is a separate handshake.  So having a separate disconnect method is
> still needed once you get into the actual connection process.

In any case on of the two is redundant ;)  Disconnect already aborts a
connection attempt (device discovery, group owner negotiation /
provision discovery, provisioning or the PSK connection).

Of these only the provisioning uses WSC so conceptually the WSC
interface is not a great match.

Best regards
--===============0448441674495190603==--

