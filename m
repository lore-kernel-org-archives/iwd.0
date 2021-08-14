Content-Type: multipart/mixed; boundary="===============5019500437193600915=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/9] handshake: Add HANDSHAKE_EVENT_IP_REQUEST
Date: Fri, 13 Aug 2021 22:31:39 -0500
Message-ID: <1f9d39ee-b015-f554-de96-88bb83e94d85@gmail.com>
In-Reply-To: <CAOq732LZAqfz1aO71U_2tUhhFFQjpB+H7VC6XmTbt2LkLuWU_Q@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5019500437193600915==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +     if (sm->handshake->support_ip_allocation &&
>>> +                     !sm->handshake->client_ip_addr) {
>>> +             handshake_event(sm->handshake, HANDSHAKE_EVENT_IP_REQUEST=
);
>>> +
>>> +             if (!sm->handshake->client_ip_addr)
>>
>> Isn't this condition already checked above?
> =

> The intention was for the handshake_event handler to try to set this,
> so this is expected to have changed since then.  But if it's still
> NULL then we assume there was some problem with the IP allocation.
> =


This really begs for a comment then.

>> Do you want to distinguish between P2P IP request and FILS IP Request?  =
Might
>> make things a bit more explicit ?
> =

> I thought the API could be the same for both (granted FILS sends more
> bits of data from the lease, but I was thinking eventually we'd store
> a whole struct l_dhcp_lease object in the handshake_state, replacing
> client_ip_addr, subnet_mask and go_ip_addr).
> =

> In reality, on the authenticator side we only create a struct
> handshake_state after the association, so this only applies for P2P, I
> can put P2P in the event name.

Sounds like adding P2P to the event name would make things clearer.

Regards,
-Denis
--===============5019500437193600915==--

