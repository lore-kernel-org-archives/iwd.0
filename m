Content-Type: multipart/mixed; boundary="===============2757597117424153048=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH] netdev: fix asymmetry in handshake events
Date: Tue, 05 Jan 2021 09:06:33 -0800
Message-ID: <3f9bb79a81beb41099c3ed099f00701e329d22f9.camel@gmail.com>
In-Reply-To: <1433a640-3dba-432e-2382-54839851b3d4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2757597117424153048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Wouldn't this cause us to issue another Disconnect?  Sort of useless
> to do that =

> if we know we're disconnected already.  The kernel just told us.
> =

Yes, your right.

> Perhaps this should be treated as another handshake event.  Like =

> HANDSHAKE_EVENT_ABORTED.

Well basically I wanted this symmetry for the diagnostic interface, for
purposes of timing auth/assoc/handshake etc. as well as obtaining the
status/reason code. This was a quick hack but there were unforseen
consequences.

I was planning on this eventually but instead maybe I could just make
the netdev result events subscribeable with a watchlist. This would get
me the auth/assoc timings, status/reason code, as well as handle this
case as station already does without the need for a special purpose
event.

Thanks,
James

--===============2757597117424153048==--

