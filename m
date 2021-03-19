Content-Type: multipart/mixed; boundary="===============5418504249406816686=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 5/6] netdev: add SAE offload support
Date: Fri, 19 Mar 2021 11:42:08 -0500
Message-ID: <b8d353a4-0d8f-2c6b-6766-7ab1b1d5597d@gmail.com>
In-Reply-To: <74ef3a343ebd0dcaae122b767bd56a88b5b79efd.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5418504249406816686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

>> So we only offload SAE connections, right?  Otherwise for 802.1X + HS
>> offload
>> this may be incorrect...
> =

> Yes, but this should only get set if we are actually doing offloading,
> which we don't yet support for 1x/PSK. I havent dove into this yet, but
> what would the procedure be here for 1x offloading (theoretically)?

Ok, figured.  I was just wondering if this warrants a TODO or a comment.

1X cannot be offloaded.  Only the 4way handshake can.  So in theory, if we'=
re =

offloading the 4way handshake, we still need to go through eapol for the 80=
2.1X =

part.  And once that is successful, then we issue NL80211_CMD_SET_PMK to te=
ll =

the driver that 802.1X succeeded.  Not sure whether we get an event after t=
he =

driver completes the handshake?

> =

> Now in light of CMD_EXTERNAL_AUTH the code below in a previous patch
> needs to change to account for this:
> =

> if (!wiphy_supports_cmds_auth_assoc(wiphy))
> 	hs->offload =3D true;
> =

> But as far as this check goes I don't see an issue unless you think
> 8021x offload has more handling that needs to be done. I'm not exactly
> sure how much of 1x is offloaded (auth/assoc?, EAP?, 4-way? all?)

Auth/Assoc is offloaded to the driver, 1X is done by userspace, 4-way is th=
en =

done by the driver.

Regards,
-Denis
--===============5418504249406816686==--

