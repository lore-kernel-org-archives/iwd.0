Content-Type: multipart/mixed; boundary="===============8570042789639528294=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 09:25:30 -0600
Message-ID: <4fcb640d-2255-83a3-044c-b5ad92e9b6d4@gmail.com>
In-Reply-To: <CAOq732JU_+kDbH0FD3AxRscBn8CUpi8Cntf7GycymCSgVJzgfg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8570042789639528294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>> Station.Disconnect does not affect WSC state FYI.  It can't since
>> Station doesn't even know about the ongoing WSC process until after
>> station_connect_network is invoked.  So in that respect we'd be
>> completely consistent.
> =

> What I meant is that Disconnect() can cancel your station connection
> attempt at any point, while with Peer.Disconnect() you're going to
> have to be more careful for no reason.

You will have to explain that then, because I don't get it?  How is =

Peer.Disconnect any different?  Your 'Peer' state doesn't change to =

connecting until after WSC runs.  And if we become a GO, then things =

become even more funny since we can only send invites, not actually =

initiate a connection.  So all these methods become somewhat irrelevant. =

  In fact, I wonder if we should be removing the WSC interface when we =

become the GO and adding another one for performing invitations.

> I was just noting they're not happening on different interfaces.

Of course.  That's because P2P_CLIENT is just a station iftype under the =

hood in the kernel with some extra stuff bolted on.  But we knew that ;)

Maybe what we should do is just implement the bare minimum client side =

API, learn from it and assume that whatever API we come up with now will =

likely not survive when we start implementing GO side.

Regards,
-Denis
--===============8570042789639528294==--

