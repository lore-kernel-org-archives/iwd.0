Content-Type: multipart/mixed; boundary="===============3487988509506483220=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 20:27:00 -0600
Message-ID: <c2a1d379-3c59-eb6b-2f8d-c4bb026f3f02@gmail.com>
In-Reply-To: <CAOq732JK2fQjz1k3oAuoRDPBXZLR1zxSQbqKFiyCKS_1e0-uWg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3487988509506483220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>   And if we become a GO, then things
>> become even more funny since we can only send invites, not actually
>> initiate a connection.
> =

> Invitation is just a technical name for a frame sequence, group
> formation is another, but it's just ways to connect to a device.  Note
> how Android shows the same Accept/Decline dialog whether you're using
> group formation or invitation. (same or similar... I thought the
> wording was the same but don't have screenshots at hand)

- How are you handling the case where the Peer wants us to display our =

PIN?  And provision discovery in general?
- Invitations?
- invitation by a P2P Device (not group owner) of another P2P Device?
- The fact that GO has a bunch of stats about its clients and you =

probably want to expose that similarly to AP mode?
- The fact that GO has to handle connections from legacy clients and =

thus needs to provide legacy WPS methods?
- persistent groups, with custom or saved credentials?

To me it seems quite impractical to mix GO and client and to try and =

hide these details.  I have very strong doubts you will succeed here.

And I also think you're not avoiding exposing topology details.  For =

example, is Peer.Disconnect resulting in a disconnection of a single =

peer or group tear down?

I think you really need to send a v4.  I just don't see how you're =

handling many of the P2P concepts, much less P2P-GO specific ones in =

this one.

Regards,
-Denis
--===============3487988509506483220==--

