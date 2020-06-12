Content-Type: multipart/mixed; boundary="===============7997620557948270626=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/4] network: delay connect if ANQP has not completed
Date: Fri, 12 Jun 2020 13:44:29 -0500
Message-ID: <b615766b-f307-46c0-40df-6710c813b0e5@gmail.com>
In-Reply-To: <02637a099750f4104d077f8b37d1983be3ca90ac.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7997620557948270626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 6/12/20 1:01 PM, James Prestwood wrote:
> Hi Denis,
> =

>> Sorry I couldn't make up my mind yesterday as to which way to go in
>> canceling
>> remaining ANQP requests on connect or not.
>>
>> This series looks good, but I'm not sure why you'd treat
>> 'connect_after_anqp'
>> differently than a regular connect request over d-bus.  Those can
>> come in during
>> autoconnect phase and can still get stuck in the 'agent limbo'...
>>
>> By the way, it might also warrant a WARN_ON if we ever hit the
>>
>> +	if (network->connect_after_anqp)
>> +		return -EALREADY;
>> +
>>
>> condition inside network_autoconnect().  Since it really shouldn't
>> happen and is
>> likely a bug in station if it did.
> =

> So this behavior is actually happening with my new ANQP delay autotest:
>   - During scan callback ANQP is started
>   - Connect() comes in before ANQP is done.
>   - ANQP finishes and notifies network, which resumes the Connect(). But
> we need to now do an agent request.
>   - Then autoconnect comes in and attempts to connect, but we are
> missing secrets so it then closes the network settings
>   - Agent request comes back and settings have been destroyed out from
> under it so we fail with NotConfigured.
> =

> Maybe instead we could have network disable autoconnect when we are in
> this limbo state of an agent request? And/or while waiting for ANQP to
> finish.

But this behavior is not related to anqp itself.  Hence why I'm asking why =

you're trying to treat the 'connect while in anqp and then needing secrets' =

different from 'connect while in autoconnect and needing secrets'

Maybe we should simply not close settings if agent requests are pending in =

network_autoconnect.

Regards,
-Denis
--===============7997620557948270626==--

