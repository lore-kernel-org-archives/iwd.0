Content-Type: multipart/mixed; boundary="===============2908310588816722520=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Thu, 14 Nov 2019 12:19:02 -0600
Message-ID: <87661ec5-d56b-2463-e6b6-11dd8c2db072@gmail.com>
In-Reply-To: <CAOq732LOs7Ru+zxhH=WCj5QDWy6SBWX9LTvhHWx2SH2zgFY9zQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2908310588816722520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/14/19 10:59 AM, Andrew Zaborowski wrote:
> Hi Denis,
> =

> On Thu, 14 Nov 2019 at 05:42, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 10/10/19 3:51 PM, Andrew Zaborowski wrote:
>>> Proposed minimum P2P interfaces for establishing basic connections.  The
>>> device discovery results in creation of P2PPeer objects.
>>>
>>> In the Wi-Fi Display API we are passing raw IE data because there's a
>>> relatively big set of different values that may be encoded in them.  We
>>> could reduce them to 2-3 bools and integers but this might limit the
>>> client implementations feature set.
>>
>> So I'm not really a huge fan of this.  We'd still need to be able to
>> understand what is inside the IE in order to verify it properly.  I'd
>> err on the side of providing some attributes instead of full on binary
>> IEs.
>>
>> Also, some of the subelements involved should really be filled in by iwd
>> itself and not the external application.  Otherwise you'll end up with
>> some sort of Frankenstein where the app provides some info but we'd need
>> to rewrite or modify it anyway.
> =

> I didn't plan to interpret the contents of the IE in any way.  The
> idea would be to have little service-specific code, and in case of WFD
> there's no need to do anything more than passing the ies.

So two issues:
- Passing in unchecked binary info from an unprivileged process is just =

not going to happen though.  We have to look inside anyway to sanitize it.
- Some of the sub elements are dynamic (connected bssid for example). =

So you will end up having to interpret it anyway.

> =

> So I see only two options, either full on binary IE passed in both
> directions between iwd and the service implementation, or full on
> individual values from the WFD subelements.  There's a lot of them
> though, for example for a probe response you have at least:
> =

>   * 12 capability bits in a bitmap
>   * RTSP tcp port
>   * throughput
>   * optional coupled sink status
>   * optional coupled sink MAC
>   * R2 support (true/false)
> =

> + 10 or more optional values...

So lets start with the bare minimum and see.  In the end this API is =

experimental, so we can still change things.

> =

> I just had a look at the how gnome-screencast is passing those to NM /
> wpa_supplicant and they basically hardcode the IE in one place in the
> code and never touch the contents...  On receival they only check if
> the WFD IEs were present and don't really look at the contents either.
> This is very new code though and I haven't looked at openwfd or
> miraclecast in detail.

Even more reason not to bother with passing IEs around.

<snip>

>>
>>> +
>>> +Methods              array(on) GetPeers()
>>> +
>>> +                     Returns a list (possibly empty) of detected P2P p=
eers.
>>> +                     Each record returned contains a tuple of the foll=
owing
>>> +                     values.
>>> +
>>> +                     object Object
>>> +
>>> +                             net.connman.iwd.P2PPeer object representi=
ng
>>
>> Name this iwd.Peer?
> =

> Sounds very generic, are we sure we won't have another spec that uses
> "peers" too?

I'm not aware of any.  But P2PPeer does not CamelCase well regardless. =

I'm happy to hear other ideas.

<snip>

>>> +             void RegisterSignalLevelAgent(object path,
>>> +                                              array(int16) levels)
>>> +
>>> +                     Register the agent object to receive signal stren=
gth
>>> +                     level change notifications on the
>>> +                     net.connman.iwd.SignalLevelAgent interface, see
>>> +                     signal-level-agent-api.txt.  The "levels"
>>
>> We moved this into the station api.  So maybe just refer to that here...
>>
>> Though really, I wonder if you even want to bother with this for the
>> first iteration?  I'd maybe leave this out?
> =

> Yeah, I wasn't going to implement it at this time.  But since you'll
> have RSSI in every mode of wireless connections, AP, adhoc, ...
> wouldn't it make sense to have a common interface and share code in
> iwd and in the clients?

You don't though.  For AP you have multiple clients, which rssi are you =

going to show?  Same goes for p2p-go really.  With adhoc you have an =

even weirder problem.

>>> +             void RegisterWFDService(object path, array(byte) payload)
>>
>> I would maybe make this a bit more generic in case other P2P services
>> are supported in the future, like file sharing, etc.
> =

> I was thinking of having a separate agent interface and separate
> register method for each service, the parameters are going to be
> different... but we could also have a common register method and
> another method on the service's agent to query the actual values of
> the parameters (at the cost of additional round trips)
> =


I'd just make this into a dictionary of parameters and have it depend on =

the service type.

>>
>> But, I'm not sure this belongs here?  P2P is a per-phy interface; do you
>> really want the clients to register WiFi Display per phy?  Or just once
>> and have it apply to all devices in the system, current or ones yet to
>> be plugged in?  Perhaps we need a ServiceManager or add this to
>> AgentManager API?
> =

> Yep, perhaps a ServiceManager (P2PServiceManager?) is a better place...
> =

>>
>> I suppose it might be in theory possible to support both a Sink and a
>> Source role on different phys, but then shouldn't you be distinguishing
>> between the roles somehow?
> =

> It is possible but luckily it's all up to the wfd implementation.
> We'd only see this information if we wanted to build the WFD IEs
> ourselves like you suggest but we wouldn't be doing anything more than
> encoding / decoding it from the IEs.

Then we can't do this as a global registration.  Because some =

sub-elements are dynamic it would be up to the application to update the =

IE properly.  I'm really not sure we can avoid building the WFD IE =

ourselves.

<snip.

>>> +             uint16 MaxConnections [readonly]
>>> +
>>> +                     Maximum number of concurrent P2P peers that local
>>> +                     hardware is capable of connecting to.  Often 1.
>>
>> I think we've talked about this before.  Given what we now know, I would
>> drop this for now.  I think the likelihood of this becoming > 1 is
>> astronomically small and we shouldn't even worry about this.
> =

> So I don't really have enough information to say that, the 2 P2P
> capable adapters that I worked with only support one client or one GO
> interface but those are only 2 adapters.
> =

> I have actually changed this since this proposal to be named
> AvailableConnections and switch between 1 and 0 as the device becomes
> busy.  So it has an additional use of indicating whether a connection
> is in progress... the Connected property on the Peer only becomes 1
> when the connection is operative.

Yeah, but that's the problem.  What do you actually mean by =

AvailableConnections?  Do you mean:

1.  connections on a given P2P_CLIENT or P2P_GO interface?  or
2.  number of P2P_CLIENT & P2P_GO interfaces?

If 1, then this makes no sense anyway.  For P2P_CLIENT it is always 1. =

For P2P_GO it is essentially unlimited.

For 2, I doubt you will ever find any hardware capable of doing more =

than 1 anyway.  And it is a complication I wouldn't worry about now =

regardless.  So if the v1 API is limited to a single connection and we =

later find out it is actually possible to do more, then we worry about =

it then.

> =

>> This means
>> we can also move some attributes / methods from the Peer interface onto
>> this one.
> =

> So this is a slightly different topic and I wouldn't do it.
> Apparently some device will make sure they become the GO during GO
> Negotiation (or as soon as P2P is enabled) and then use the invitation
> procedure instead of the group formation procedure, so then they can
> be connected to multiple peripherals and this seems to be an actual
> use case.

Yeah, see above.  You're talking about 1 here.  And I'd argue that =

AvailableConnections or MaxConnections still doesn't make sense in this =

context.

> =

> MaxConnections still doesn't sound right because in theory there's no
> maximum, but we still need some way to indicate if we're busy.

Exactly.  So you need to find another way.

>>> +
>>> +Methods              ConnectPushButton()
>>> +
>>> +                     Connect to the P2P peer in the Push Button mode
>>> +                     using the device pointed to by the .Device proper=
ty.
>>> +                     Returns when connection is complete.
>>
>> Why are you method names different from SimpleConfiguration?  in fact,
>> why not just add .SimpleConfiguration interface to the same object path
>> and just have clients use that?
> =

> Could do this, yes, although it would have been nice to have "Connect"
> in the method names.  And I'm not sure how to resolve this in the code
> since the implementation of the methods will be very different from
> the one in wsc.c, preferably I wouldn't duplicate setup_wsc_interface.

Pretty easy I would think?  I mean you do have the netdev associated =

with it, so you can simply check the interface type.

>>> +
>>> +             Disconnect() [optional]
>>
>> A method can't be optional?
> =

> Well since the optional concept is kind of made up it just means
> returning an error when the method or property doesn't apply.

Made up?  I don't think so.  Properties are explicitly allowed to be =

optional.  Methods are not.  Check the D-Bus spec ;)  We never had any =

optional methods and never will :)

>>> +             boolean Connected [readonly]
>>> +
>>> +                     Whether there's currently an active connection
>>> +                     to this peer.  The property is read-only and
>>> +                     changes as a result of the Connect and
>>> +                     Disconnect methods calls.
>>
>> This wording might need to be updated....
> =

> You mean because we'd only have one connection?

Sorry, should have been more clear.  The Connect and maybe even =

Disconnect method calls will be named differently.  So the wording needs =

to be updated accordingly.

>>
>> Okay, so you want to notify the agent instead of adding a WFD specific
>> interface to the Peer object.  I still wonder if we can avoid
>> transporting raw IEs here... Also, how are you making sure that the
>> peers are actually ones that the agent cares about?  There's no sense in
>> sending Source role peer info if we're also a Source...
>>
>> Can we be a source and a sink at the same time?
> =

> Yeah, but I don't really see benefit in hiding the WFD sources if
> we're the source, or WFD sinks if we're a sink.  It'll be simpler for
> everyone if the WFD service takes care of this.

That goes against our core design principles and you know it :)

> =

>>
>>> +
>>> +             void NewConnection(object peer, array(byte) payload)
>>> +
>>> +                     Called when a new P2P connection has been establi=
shed
>>> +                     to a WFD-capable peer.  The peer object has the
>>> +                     net.connman.iwd.P2PPerr interface.  The byte array
>>
>> typo
>>
>>> +                     contains the reassembled payload of the WFD
>>> +                     Information Elements presented by the peer.
>>
>> So I'm not entirely sure how this is useful?  The fact that we made a
>> connection to a peer is already available via the Peer.Connected
>> property.  Is the payload somehow different from what was sent via
>> WFDPeersChanged?
> =

> Hmm, no, it should be the same in practice, so yeah, we can maybe drop th=
is.

okay

> =

> The spec actually has a different subset of subelements allowed in
> each frame (Associate vs. Beacon or Probe Response) but in
> wpa_supplicant for example, you set one WFD IE for all possible
> frames.
> =

> The bit that might change is "Available for WFD Session" now that I
> think of it... but I assume when a device is not available it simply
> won't be discovering or entering group formation.  But it could be a
> candidate for modifying inside iwd rather than taking a value from the
> DBus client.
> =

> By the way, one thing that needs to change in this proposal is how
> peer discovery (scanning) is triggered and how the current state is
> signalled.  Discovery is more expensive than we previously thought and
> can't be automatically enabled whenever the P2P interface is enabled.
> =


Funny, okay I'm curious to learn more now.

Regards,
-Denis
--===============2908310588816722520==--

