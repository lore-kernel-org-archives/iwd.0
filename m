Content-Type: multipart/mixed; boundary="===============6341158350196693516=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] ap: Implement P2P GO-side 4-way handshake IP
 Allocation
Date: Fri, 09 Jul 2021 13:48:19 -0500
Message-ID: <444fbf46-19e3-e30c-dd66-f6a066af2cd3@gmail.com>
In-Reply-To: <CAOq732LuhUpE3bAgh+=q4do3oAaeb5gQyyH2TkeHTBAZKhiJJw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6341158350196693516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>>> +#define IP4_FROM_STR(str)                                            \
>>> +     (__extension__ ({                                               \
>>> +             struct in_addr ia;                                      \
>>> +             inet_pton(AF_INET, str, &ia) =3D=3D 1 ? ntohl(ia.s_addr) =
: 0; \
>>
>> Why the ntohl?  Why is handshake_state storing those parameters in host =
order
>> anyway?
> =

> I guess at this point it's just because why not.  We can use either

So I really don't agree with such point of view.  IP addresses are usually =

assumed to be stored in network order.  Consistency is king.  We should alw=
ays =

be consistent unless there's a good reason not to be, and then you want to =
keep =

that inconsistency to a minimum.

> order.  I still think it would be good to use a typedef if we want to
> store a network byte-order value, like struct in_addr uses in_addr_t.
> =


We could.  We also have __be32/16 types.  But all of these are just annotat=
ions. =

  They're still not that helpful compared to just being consistent.

>>> @@ -877,12 +916,18 @@ static void ap_handshake_event(struct handshake_s=
tate *hs,
>>>                enum handshake_event event, void *user_data, ...)
>>>    {
>>>        struct sta_state *sta =3D user_data;
>>> +     struct ap_state *ap =3D sta->ap;
>>>        va_list args;
>>>
>>>        va_start(args, user_data);
>>>
>>>        switch (event) {
>>>        case HANDSHAKE_EVENT_COMPLETE:
>>> +             if (sta->ip_alloc_lease && !sta->hs->support_ip_allocatio=
n)
>>> +                     /* Client sent no IP Address Request */
>>> +                     l_dhcp_server_release_lease(ap->netconfig_dhcp,
>>> +                                     l_steal_ptr(sta->ip_alloc_lease));
>>> +
>>
>> I'm not sure about this part.  Is there any harm in just leaving the lea=
se be?
>> Shouldn't l_dhcp_server just select the same lease if the client tries
>> re-running DHCP?
> =

> Yeah, I think it would re-use the memory (after memzeroing it) and the
> IP.  Ideally we shouldn't assume this about the DHCP implementation,
> is there any reason to not release the lease here?
> =


I was wondering about potential race conditions here.  By the time we recei=
ve =

message 4, the client might already be running dhcp...  Would there be any =

issues with just hard-pulling a lease like this?

>> You could also try to mess with the lease timeout in case
>> you're worried about clients connecting and not running DHCP...
> =

> Thinking about this there may also be future UIs that will display
> active/expired DHCP leases like a lot of APs do.  Ideally the lease
> list would really reflect the leases requested/acked.

Maybe allocate the lease like we received a DISCOVER?  And only confirm it =
once =

the handshake is done and the IP Allocation KDE was used?

> =

> Speaking of this I wonder if instead of relying on only the lease
> timeouts for AP clients that have disassociated, instead ap.c should
> notify the l_dhcp_server to automatically move the client's lease to
> the expired list.  If the client reconnects before the IP pool becomes
> full it can still re-use the lease, assuming it's using a permanent
> BSSID.  I wonder if automatic reconnects by clients that randomize
> BSSIDs could dry out to the IP pool too quickly.

I think that would be fine for the type of use cases we're targeting.

Regards,
-Denis
--===============6341158350196693516==--

