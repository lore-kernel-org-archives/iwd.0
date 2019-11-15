Content-Type: multipart/mixed; boundary="===============1023355354387719197=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 13:33:53 +0100
Message-ID: <CAOq732JF9n1fk-Z13Xq2UD_pXE-NrSrA2hqY20AZVrOmxeb9dg@mail.gmail.com>
In-Reply-To: <9f6ae587-b2c6-1113-e361-58f73f6f36a4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1023355354387719197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Nov 2019 at 06:10, Denis Kenzior <denkenz@gmail.com> wrote:
> So you want two separate registrations?  A global capability and a
> per-connection "I want to use this profile" type of thing.  It sounded
> like you only wanted the latter above.

I was rather thinking of borth Scan() and PushButton() taking the
information about services to advertise but it's a complication.

>
> So really, I don't see the point.  If iwd understands about WFD, then it
> simply wouldn't send any WFD IEs to a WFD-incapable device.
>
> One can argue that the capability you propose would still be wanted in
> some weird situations.
>
> For example, WFD allows 'Dual mode Sink & Source' only in the Beacon and
> Probe Response frames.  For Association, it needs to pick one role.
>
> Or maybe the Keyboard in your example is actually also WFD capable..
> But then the spec mysteriously says:
>
> "Depending on the availability of the WFD Device for a WFD Session, the
> value for WFD Session Availability bits (B5B4) of the WFD Device
> Information field of WFD Device Information subelement within the WFD IE
> may change" in Section 4.5.2.1 "Usage of a WFD IE to establish P2P
> connection".  So who knows what they actually mean by that?  Maybe we
> can always send WFD IEs and just twiddle those bits off?
>
> I really wouldn't worry about these bizarre cases right now until you
> have something that actually works.
>
> >>
> >> See for example:
> >>
> >> WFD Session Availability bits:
> >> 0b00: Not available for WFD Session
> >>
> >> Or Section 5.2.1:
> >> "If a WFD Device acts as a P2P Group Owner, the WFD Device shall insert
> >> one or more WFD IEs after the other information elements in the Beacon
> >> frames it transmits. "
> >>
> >> I assume that at least the WFD spec wants you to twiddle the contents =
of
> >> the IEs and not remove IEs entirely.
> >>
> >>> the TV, once your WFD session is running and functional.  Maybe the
> >>> ServiceManager is the wrong way to go and the Connect / PushButton
> >>> method should receive the relevant information.
> >>
> >> And don't you need the advertising data before you even get to the poi=
nt
> >> where you can invoke operations on the Peer interface?
> >
> > In theory you need to advertise it in your scan.  Like I mentioned in
> > another email, I think the scans should also be explicitly triggered
> > by the apps because they're expensive, so those would also need to
> > know the service parameters.
>
> Okay.  So you need to present those details then.
>
> >> Yes, sure.  What I'm saying though is that once we're connected, we
> >> should indicate the topology somehow.
> >
> > I think we should just indicate that we can still attempt more
> > connections, optimally without exposing the P2P roles.
>
> I don't know why you'd want to hide that, but I'm fine either way.

It sounds more like the typo of information you want on a diagnostics
interface because it is not supposed to affect your connection, like
your AP's BSSID.

>
> >> Cancel only applies to the discovery and configuration procedure.  The
> >> WSC is a separate handshake.  So having a separate disconnect method is
> >> still needed once you get into the actual connection process.
> >
> > In any case on of the two is redundant ;)  Disconnect already aborts a
> > connection attempt (device discovery, group owner negotiation /
> > provision discovery, provisioning or the PSK connection).
>
> I think about this differently.  You have 2 phases:
>    1. Simple Configuration (WiFi Direct flavor) which involves the group
> formation and wsc negotiation

Well, it simply isn't part of WSC, but ok.

>    2. Actual connection establishment
>
> I don't see why Disconnect can't just affect 2 without affecting 1.  The
> operations are on different interfaces after all.

We just don't need 2 methods and I already have Disconnect working
this way (consistent with Station.Disconnect) so it'd mean just
artificially crippling it, also adding a race where your Cancel call
may work or not.

(Tecnically provisioning and the connection are both on the P2P_CLIENT
interface)

>
> >
> > Of these only the provisioning uses WSC so conceptually the WSC
> > interface is not a great match.
>
> Honestly, I'm not convinced that reinventing the wheel and duplicating
> the SimpleConfiguration API on the P2P Peer is any better.
>
> Even in the classic station case WSC involves device discovery as well.
> So, in P2P, arguably everything up to the PSK connection establishment
> can be viewed as part of WSC.
>
> It sounds like you need to send a v4 before we can go further.

Right, I'm still not sure about how discovery should be triggered but
I can go on with the code with the answers and ideas I got from you
already.

Best regards
--===============1023355354387719197==--

