Content-Type: multipart/mixed; boundary="===============4077990083308711422=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] ap: Pass vendor IEs between frames and the user
Date: Thu, 18 Feb 2021 13:57:17 -0600
Message-ID: <f1f10731-18ba-d0bf-8e99-e02a6b1c58bd@gmail.com>
In-Reply-To: <CAOq732+uUbU2etN3P-bUEZwER1_kbXmEJ24L7yLyPcoBamALWg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4077990083308711422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,


> In any case I don't see any need for the latter option right now.  You
> also seem to prefer the simpler approach too.  The reason I went for
> ap_add_vendor_ie_writer() is that it can be extended in the future if
> we needed the IE order-by-tag logic mentioned in 802.11-2016 9.4.2.1
> and would only require one-line changes in the callers.

If this API is only used for Vendor IEs, then I don't believe there are any =

ordering requirements..

>> Also, you may consider flipping things around and instead of using a 'pu=
ll'
>> mechanism, using a 'push' mechanism instead.  Add a couple of new events=
 to
>> signal that vendor IEs need to be updated (beaconing, association respon=
se, etc)
>> and have the clients invoke a function to write the new IEs.  This may b=
e more
>> flexible and would allow you hide some implementation details (i.e. add a
>> growable buffer instead of a variable-length stack buffer, something whi=
ch we
>> probably should not use in this instance)
> =

> That will force us to memcpy those buffers when sending one of those
> frames, and we would probably need reference counting too.  We may
> also end up generating the IE contents even if the related frame never
> gets sent, so we may be doing extra work.

I don't really see how your last point can happen, but putting that aside..=
.  It =

is possible that you'd incur a few extra memcpys.  It depends on how you se=
t =

things up.  If you make the callers pass in a refence-countable buffer for =

example, then memcpy could be kept to a minimum.

I'm somewhat against using variable length stack buffers for the underlying =

implementation.  It may be too easy to screw up and overflow since the logi=
c is =

in two places.

> =

> Also we may need to build the probe response IEs based specifically on
> the contents of the probe request (that happens to not be a problem
> with Association Req / Association Response in P2P right now) but my
> current patch doesn't handle that either, I think I'll add a separate,
> but similar, ops-> callback for writing the probe response IEs which
> takes the probe request IEs string as an extra parameter.

Yes, this is another good alternative.  In theory, the setup you describe i=
s =

somewhat similar to how we handled 'auth_proto' inside netdev.c.  So I can =

definitely see how you may want to filter authenticate / associate requests =

through the P2P subclass before moving on to generating the auth/assoc resp=
onse.

Regards,
-Denis
--===============4077990083308711422==--

