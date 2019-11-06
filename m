Content-Type: multipart/mixed; boundary="===============1860736040236015413=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/3] rrm: add radio resource management module
Date: Wed, 06 Nov 2019 15:59:29 -0600
Message-ID: <93b7533b-410b-0803-cd4a-e439d942af66@gmail.com>
In-Reply-To: <62ca199a1e05bc90e09f7469282ecafce8a3ca4a.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1860736040236015413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> Shouldn't you be checking that station exists first?  Also, you have
>> a
>> bit of a chicken/egg problem since station is watching the same
>> netdev_watch.  So by luck of the draw it may be getting notified
>> (and
>> thus created) after the rrm module.
>>
>> How we get around this is unclear.  One way would be to check the
>> iftype
>> to be station and just assume that the station object comes around
>> eventually.  Perhaps by lazy-instantiating the station watch only
>> once
>> an actual request arrives.
> =

> What about adding a module depends on station? This would make RRM get
> initialized after station which should make the netdev watch call into
> station before RRM.
> =


Possible, though that seems to be really unobvious.  And if someone =

changes watchlist to use push_head instead of push_tail, things start to =

break.

Also, this is not really a module-initialization order issue but what =

order does the watchlist get called issue.  So it just seems like the =

wrong way to go.

Perhaps we need an explicit API for when an interface gets added, or =

just cheat and use delayed-init.

Regards,
-Denis
--===============1860736040236015413==--

