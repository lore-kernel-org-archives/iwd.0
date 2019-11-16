Content-Type: multipart/mixed; boundary="===============8812628340600869175=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 22:10:31 -0600
Message-ID: <03165533-fb0a-4c37-24fa-3a88d7bfcbbb@gmail.com>
In-Reply-To: <CAOq732Jq2EyqvXxsHznHyhpgeOcefAH0gTwaFY2shoyp0ummbA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8812628340600869175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/15/19 9:02 PM, Andrew Zaborowski wrote:
> On Sat, 16 Nov 2019 at 03:28, Denis Kenzior <denkenz@gmail.com> wrote:
>>>>    And if we become a GO, then things
>>>> become even more funny since we can only send invites, not actually
>>>> initiate a connection.
>>>
>>> Invitation is just a technical name for a frame sequence, group
>>> formation is another, but it's just ways to connect to a device.  Note
>>> how Android shows the same Accept/Decline dialog whether you're using
>>> group formation or invitation. (same or similar... I thought the
>>> wording was the same but don't have screenshots at hand)
>>
>> - How are you handling the case where the Peer wants us to display our
>> PIN?  And provision discovery in general?
> =

> We can add a signal for this, but this is independent of the role and
> not a high priority.

It sort of is.  How is the user notified that some other device is =

trying to connect to us?  How do they know its time to enter the =

password or just display it on the screen?

And a signal is not enough as the UI might want to perform an =

authorization step here as well.

> =

> Do we have a use case for this?

Absolutely.

> =

>> - Invitations?
>> - invitation by a P2P Device (not group owner) of another P2P Device?
> =

> We don't need to unless we're also going to be running on peripheral
> devices, but that's not our current use case.

The latter is optional and of dubious value.  The former might be kind =

of important.

> =

>> - The fact that GO has a bunch of stats about its clients and you
>> probably want to expose that similarly to AP mode?
> =

> We don't expose anything in AP mode?
> =


AP mode isn't really finished.  We need to add this some day.

> Our main use case is to provide bluetooth-like connections to devices.
> =

>> - The fact that GO has to handle connections from legacy clients and
>> thus needs to provide legacy WPS methods?
> =

> Is there a use case for this?
> =


If you want to pass conformance tests it is.  See Table 7: GOUT Protocol =

Conformance Tests in the Wi-Fi Direct Test plan.

>> - persistent groups, with custom or saved credentials?
> =

> We will need to start saving credentials because that's something
> that's actually in use, and we need to do this both on the GO and
> client.

Fair enough.

> =

>>
>> To me it seems quite impractical to mix GO and client and to try and
>> hide these details.  I have very strong doubts you will succeed here.
>>
>> And I also think you're not avoiding exposing topology details.  For
>> example, is Peer.Disconnect resulting in a disconnection of a single
>> peer or group tear down?
> =

> Assuming that is the last peer in that group then either will work, I
> don't see the difference here.

But you may want to keep the group around.   Anyway, this is not a =

biggie but I think you're making an assumption this would never be wanted.

> =

> If there are more peers then obviously you don't want to break things
> by disconnecting them?

Sure, this one is obvious.

> =

>>
>> I think you really need to send a v4.  I just don't see how you're
> =

> Yes, we agreed on that, although I'm still missing any reasoning for
> the Cancel method for example.  If you have ideas on how to handle the

That's just how Station & WSC work today, and actually work pretty well =

compared to any other WPS API I saw.  I don't see why following the same =

pattern is so bad?  In the end the user still invokes a single method =

and gets connected.

Really, all your criticisms apply to station/wsc as well.  But then =

aborts are sort of an uncommon case anyway.

> following I'd also welcome them:
> =

>   * how to best signal whether the device is available to start a new con=
nection,
>     assuming you didn't like the AvailableConnections (int) property.

At the moment I think exposing the role is the way to go.  But feel free =

to convince me otherwise.

> =

>   * how to trigger device discovery, optimally in a way that forces the
> client to stop it after
>     a while, basically to make sure it's not left running when the UI
> isn't active.  For
>     example for our "agents" we automatically detect if they're
> disconnected, here we
>     probably also want the client to "own" the scan in some way.

One idea would be to add a StartDiscovery / StopDiscovery methods and =

track client state.  So if a client drops off the bus, then we =

automatically stop discovery sessions initiated by it.  This could also =

be used to send parameters for the discovery.  E.g. only WFD devices. =

Each distinct dbus client (i.e. dbus unique service name) can set its =

own parameters for peers it is interested in.

However, these commands might need to be limited if we're in some =

existing connection or not.  You're the expert on the details here.

> =

>> handling many of the P2P concepts, much less P2P-GO specific ones in
>> this one.
> =

> What are some P2P-GO specific concepts that would affect the DBus API?
>   As long as we provide for having multiple active connections, and we
> allow for new properties on the Peer interface in the future, we
> should be fine.
> =


I think this was already covered.  If you can unify the API, great.  I =

think there are some nasty stumbling blocks though.

Regards,
-Denis
--===============8812628340600869175==--

