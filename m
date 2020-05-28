Content-Type: multipart/mixed; boundary="===============0679314696466427882=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] anqp: refactor to use frame-xchg
Date: Thu, 28 May 2020 17:40:24 +0000
Message-ID: <8995436a-a96b-ef56-b99a-0e2ac6f8d00a@gmail.com>
In-Reply-To: <9aa953f7148035150dbac69774703a763833603d.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0679314696466427882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

<snip>

>>>    =

>>> -uint32_t anqp_request(uint32_t ifindex, const uint8_t *addr,
>>> +bool anqp_request(uint64_t wdev_id, const uint8_t *addr,
>>
>> See above for the likely reason why we had this return a uint32_t
>> originally.
> =

> I am kinda thinking this should be implemented in frame-xchg since
> cancellation doesn't even exist at this point. Then we can just give
> that ID directly to station and ANQP doesnt need to track it.
> =


I'm fine either way.  You could in theory do this in anqp.c for now and =

just use frame_xchg_stop for the ongoing operation.  But adding this =

directly too frame-xchg would be fine as well.

>> Do we currently send a single ANQP request per network?  If so, maybe
>> we
>> can drop this structure completely, by:
>>
>> 1. Adding network_get_station() getter if necessary
>> 2. Using the network object itself as the user_data for
>> station_anqp_response_cb
>> 3. Maybe storing pending inside network itself?
>>
>> The above would also make it easier to solve the issue of the user
>> triggering Connect just when ANQP hasn't been done yet...
> =

> The tricky part is that ANQP is directly tied to the scan results, so

Hm, how so?

> putting anything in network is difficult. We could have
> network_set_anqp_pending (or a better name), then if that was set and
> Connect() came in we would know to wait. But that would get ugly as
> station would need to detect that a Connect() came in (so another flag
> in network + getter) while waiting for ANQP and to re-issue the
> Connect() once ANQP completed.

Well, can't we just check if anqp is pending for the network inside =

network_connect() or so, and if it is, defer taking any action until =

anqp succeeds / fails?

If that is too complicated, then I guess we have to document that =

.Connect shouldn't be called until KnownNetwork property has been =

signaled and make our auto tests do this as well.

Regards,
-Denis
--===============0679314696466427882==--

