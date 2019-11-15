Content-Type: multipart/mixed; boundary="===============8958358518054329799=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Thu, 14 Nov 2019 21:25:15 -0600
Message-ID: <4c084756-efee-be95-c4c2-7d3cae407fe8@gmail.com>
In-Reply-To: <CAOq732K8318ev5AiK6XqCqtDAST741wKGRR5bW5pA3_LuJX5TQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8958358518054329799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> And the kernel has APIs for this?  AFAIK you don't even get this info
>> without polling.  So trying to use our agent for this is not going to wo=
rk.
> =

> I think there's a patchset that's being rebased occasionally.  But
> what I mean is that maybe that interface doc shouldn't be buried in
> station-api.txt.

Sure.  But until we know that this is possible this step is premature. =

Right now the signal agent logically belongs in station since that is =

the only thing using it.

>>
>> So I generally agree this should be global, just pointing out that
>> certain elements would need to be dynamic.  This also (probably?)
>> precludes us from advertising a Sink role and a Source role for example.
>>    And also makes things like doing simultaneous P2P_GO + P2P_CLIENT sort
>> of pointless.
> =

> When talking about the API it's only a question of whether the
> parameters dictionary should have to booleans, one for sink, one for
> source, or one "role" variable.  We're not acting on that information
> anyway, it's only so we can encode it in the IE.
> =


By the way, to answer my earlier question.  It is possible to be both a =

Sink and a Source at the same time:
"0b11: dual-role possible, i.e., either a WFD Source or a Primary Sink"

>> For now I'd ignore this and assume we can only do one role at a time.
> =

> Right.  But I'm thinking if there is a whole better way of doing the
> service registration, i.e. per connection instead of globally.  Say
> your use case is you're connecting first to a TV and then to a
> keyboard, or simultaneously (as a GO).  There's no point advertising
> the WFD capabilities to the keyboard device or to anyone other than

I actually wouldn't expect this to be a good idea.  Once you start =

advertising a set of IEs as a P2P GO, I'm not sure changing these is =

really something that is expected, particularly when you already have a =

peer connection established.  Changing the contents to signal some state =

is probably OK (this is done in WSC for example).  But taking out IEs =

entirely is a bit of a gray area.

See for example:

WFD Session Availability bits:
0b00: Not available for WFD Session

Or Section 5.2.1:
"If a WFD Device acts as a P2P Group Owner, the WFD Device shall insert =

one or more WFD IEs after the other information elements in the Beacon =

frames it transmits. "

I assume that at least the WFD spec wants you to twiddle the contents of =

the IEs and not remove IEs entirely.

> the TV, once your WFD session is running and functional.  Maybe the
> ServiceManager is the wrong way to go and the Connect / PushButton
> method should receive the relevant information.

And don't you need the advertising data before you even get to the point =

where you can invoke operations on the Peer interface?

>> Then just indicate what role we have and let the application make that
>> choice.  So if we're in P2P_GO mode, it can try to establish another
>> connection.  And if we're in P2P_CLIENT mode, tough luck.
> =

> I think it would be nicer to just prefer GO automatically (maybe
> without forcing it), for example by having the GO Intent default to 14
> out of 15 and be configurable in main.conf.
> =


Yes, sure.  What I'm saying though is that once we're connected, we =

should indicate the topology somehow.

>> Why? The hardware is the arbiter of this in the end.
> =

> Some dedicated access points have trouble serving 10 connections
> simultaneously on one radio channel so for our off the shelf hardware
> and minimal ap.c code it's going to be very difficult.

And?  Any limit you pick will end up being wrong for someone.

>>
>> Ah, imprecise wording here.  By single connection I mean a single
>> P2P_GO/P2P_CLIENT interface active at a time.  So if we're in P2P_GO
>> mode, we can do multiple 'connections'.  But since we're not doing
>> P2P_GO yet, then effectively we would only support a single active peer
>> today.
> =

> So I assume you're Ok having the Disconnect method on the Peer
> interface, not on P2PDevice? So that our DBus clients are prepared to
> support multiple connections instead of 1?

I think these two things are somewhat orthogonal.  We can still have =

Disconnect on the Device and not the peer.  All that would do is =

preclude us from disconnecting individual links in P2P GO mode.  But =

sure, I suppose it can remain on the Peer object.

> =

> Or I wonder if we should repurpose WSC.Cancel to also disconnect a
> fully established connection.  There's no need for separate Cancel and
> Disconnect methods, but Disconnect sounds more correct.
> =


Cancel only applies to the discovery and configuration procedure.  The =

WSC is a separate handshake.  So having a separate disconnect method is =

still needed once you get into the actual connection process.

Regards,
-Denis
--===============8958358518054329799==--

