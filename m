Content-Type: multipart/mixed; boundary="===============2637139937692032957=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: ap mode problem
Date: Wed, 21 Apr 2021 12:19:25 -0700
Message-ID: <8c17278656a8692fdc15e313bb5037586bd1bc52.camel@gmail.com>
In-Reply-To: <CAG17S_NmBoT=1JLFw4CHY5zbmHfvv6TfOwdKOTs-g2BcqWaYWw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2637139937692032957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

<snip>
> ...
> Apr 21 11:47:28 deskrune iwd[2298]: Wiphy phy0 will only use the
> default interface
> Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Request from
> ae:53:10:32:ee:8a
> Apr 21 11:47:51 deskrune iwd[2298]: AP Probe Response delivered OK
> Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication from
> ae:53:10:32:ee:8a
> Apr 21 11:47:51 deskrune iwd[2298]: AP Authentication frame 2 ACKed
> by STA
> Apr 21 11:47:51 deskrune iwd[2298]: AP Association Request from
> ae:53:10:32:ee:8a
> Apr 21 11:47:51 deskrune iwd[2298]: AP (Re)Association Response ACK
> received
> Apr 21 11:47:52 deskrune iwd[2298]: 4-Way handshake failed for
> ifindex: 3, reason: 15

Looks like the station isn't responding to EAPoL messages. To confirm
could you run iwmon along side iwd during this and send the logs?

https://iwd.wiki.kernel.org/debugging

> Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request from
> b0:02:47:cc:83:f9
> Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Response delivered OK
> Apr 21 11:47:54 deskrune iwd[2298]: AP Probe Request from
> b0:02:47:cc:83:f9
> Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Request from
> ee:b9:80:a7:13:81
> Apr 21 11:47:57 deskrune iwd[2298]: AP Probe Response delivered OK
> Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from
> b8:27:eb:18:74:9c
> Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Response delivered OK
> Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from
> b8:27:eb:18:74:9c
> Apr 21 11:47:58 deskrune iwd[2298]: AP Probe Request from
> b8:27:eb:18:74:9c
> Apr 21 11:48:01 deskrune iwd[2298]: AP Deauthentication from
> ae:53:10:32:ee:8a, reason 3
> =

> Is this incompatible? It works with hostapd/dnsmasq.
> =

> Keith
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============2637139937692032957==--

