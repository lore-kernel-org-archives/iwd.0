Content-Type: multipart/mixed; boundary="===============6075022810007216544=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Sat, 16 Nov 2019 04:02:53 +0100
Message-ID: <CAOq732Jq2EyqvXxsHznHyhpgeOcefAH0gTwaFY2shoyp0ummbA@mail.gmail.com>
In-Reply-To: <c2a1d379-3c59-eb6b-2f8d-c4bb026f3f02@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6075022810007216544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 16 Nov 2019 at 03:28, Denis Kenzior <denkenz@gmail.com> wrote:
> >>   And if we become a GO, then things
> >> become even more funny since we can only send invites, not actually
> >> initiate a connection.
> >
> > Invitation is just a technical name for a frame sequence, group
> > formation is another, but it's just ways to connect to a device.  Note
> > how Android shows the same Accept/Decline dialog whether you're using
> > group formation or invitation. (same or similar... I thought the
> > wording was the same but don't have screenshots at hand)
>
> - How are you handling the case where the Peer wants us to display our
> PIN?  And provision discovery in general?

We can add a signal for this, but this is independent of the role and
not a high priority.

Do we have a use case for this?

> - Invitations?
> - invitation by a P2P Device (not group owner) of another P2P Device?

We don't need to unless we're also going to be running on peripheral
devices, but that's not our current use case.

> - The fact that GO has a bunch of stats about its clients and you
> probably want to expose that similarly to AP mode?

We don't expose anything in AP mode?

Our main use case is to provide bluetooth-like connections to devices.

> - The fact that GO has to handle connections from legacy clients and
> thus needs to provide legacy WPS methods?

Is there a use case for this?

> - persistent groups, with custom or saved credentials?

We will need to start saving credentials because that's something
that's actually in use, and we need to do this both on the GO and
client.

>
> To me it seems quite impractical to mix GO and client and to try and
> hide these details.  I have very strong doubts you will succeed here.
>
> And I also think you're not avoiding exposing topology details.  For
> example, is Peer.Disconnect resulting in a disconnection of a single
> peer or group tear down?

Assuming that is the last peer in that group then either will work, I
don't see the difference here.

If there are more peers then obviously you don't want to break things
by disconnecting them?

>
> I think you really need to send a v4.  I just don't see how you're

Yes, we agreed on that, although I'm still missing any reasoning for
the Cancel method for example.  If you have ideas on how to handle the
following I'd also welcome them:

 * how to best signal whether the device is available to start a new connec=
tion,
   assuming you didn't like the AvailableConnections (int) property.

 * how to trigger device discovery, optimally in a way that forces the
client to stop it after
   a while, basically to make sure it's not left running when the UI
isn't active.  For
   example for our "agents" we automatically detect if they're
disconnected, here we
   probably also want the client to "own" the scan in some way.

> handling many of the P2P concepts, much less P2P-GO specific ones in
> this one.

What are some P2P-GO specific concepts that would affect the DBus API?
 As long as we provide for having multiple active connections, and we
allow for new properties on the Peer interface in the future, we
should be fine.

Best regards
--===============6075022810007216544==--

