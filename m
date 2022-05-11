Content-Type: multipart/mixed; boundary="===============3728341793948843173=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Wed, 11 May 2022 13:21:40 -0500
Message-ID: <3060872f-32b5-6faa-92b7-de0e8f3a1800@gmail.com>
In-Reply-To: CACsRnHVzueqtOTO1vu73F7JkF2iv46F_2_dgzExH-vrKx5F6Gw@mail.gmail.com

--===============3728341793948843173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

> One thing I was wondering is if some level of info logging would be
> possible for the dhcp client. This could be similar in verbosity to
> dhclient or networkd which would make it easier to see what happened
> with this kind of thing. DHCP happens on a relatively slow basis so it
> wouldn't spam much. I attempted to add this but I couldn't really find
> a good place for it.

You can start iwd with IWD_DHCP_DEBUG set but not '-d'.  So it would only p=
rint =

the DHCP info and not anything else.

Or do you mean a reduced set of information prints from the dhcp_client?  S=
hould =

be possible by introducing something like l_dhcp_client_set_debug_level().

Or do you mean something else?

Regards,
-Denis
--===============3728341793948843173==--

