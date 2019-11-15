Content-Type: multipart/mixed; boundary="===============8505647758205398995=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 23:35:05 +0100
Message-ID: <CAOq732JK2fQjz1k3oAuoRDPBXZLR1zxSQbqKFiyCKS_1e0-uWg@mail.gmail.com>
In-Reply-To: <4fcb640d-2255-83a3-044c-b5ad92e9b6d4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8505647758205398995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, 15 Nov 2019 at 16:27, Denis Kenzior <denkenz@gmail.com> wrote:
> >> Station.Disconnect does not affect WSC state FYI.  It can't since
> >> Station doesn't even know about the ongoing WSC process until after
> >> station_connect_network is invoked.  So in that respect we'd be
> >> completely consistent.
> >
> > What I meant is that Disconnect() can cancel your station connection
> > attempt at any point, while with Peer.Disconnect() you're going to
> > have to be more careful for no reason.
>
> You will have to explain that then, because I don't get it?  How is
> Peer.Disconnect any different?  Your 'Peer' state doesn't change to
> connecting until after WSC runs.

That's needlessly complicating things for the users.  From the user's
point of view there's a device they want to connect to and use it.
They call a single method and get a connection established, and if
they need to interrupt the process then it's still single process.
You could split it in any number of ways, as before WSC there's a
bunch of other things happening, but from the user's point of view
those are details they don't want to see.  WSC is one of 4 or 5 steps
(you can make up more) in the P2P connection but there's no benefit
from making the user aware of them.

>  And if we become a GO, then things
> become even more funny since we can only send invites, not actually
> initiate a connection.

Invitation is just a technical name for a frame sequence, group
formation is another, but it's just ways to connect to a device.  Note
how Android shows the same Accept/Decline dialog whether you're using
group formation or invitation. (same or similar... I thought the
wording was the same but don't have screenshots at hand)

On a similar note:
The P2P devices I've seen don't have a physical WSC button (not
surprising), but they don't even have a virtual button or the word
Push Button anywhere in the user interfaces.  Take for example Android
connecting to a wifi-display TV, neither mentions any WSC term like
Push Button in their UIs.  The verbs are connect and accept/decline
connection (and similar).  WSC is really just a protocol used at the
network level and an implementation detail, as are the P2P roles.

>  So all these methods become somewhat irrelevant.
>   In fact, I wonder if we should be removing the WSC interface when we
> become the GO and adding another one for performing invitations.
>
> > I was just noting they're not happening on different interfaces.
>
> Of course.

Oh so this was just a typo I was replying to I guess.

>  That's because P2P_CLIENT is just a station iftype under the
> hood in the kernel with some extra stuff bolted on.  But we knew that ;)
>
> Maybe what we should do is just implement the bare minimum client side
> API, learn from it and assume that whatever API we come up with now will
> likely not survive when we start implementing GO side.

There really shouldn't be any difference to the user.

>
> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
--===============8505647758205398995==--

