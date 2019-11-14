Content-Type: multipart/mixed; boundary="===============5300079654744652510=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Thu, 14 Nov 2019 14:33:59 -0600
Message-ID: <40ab712b-572b-8598-c558-820484d1662e@gmail.com>
In-Reply-To: <CAOq732LyHrLpTyR-qU6Hons4eNK-xnxv2S_LeYJ91AqXytPh6A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5300079654744652510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/14/19 1:37 PM, Andrew Zaborowski wrote:
> On Thu, 14 Nov 2019 at 19:20, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 11/14/19 10:59 AM, Andrew Zaborowski wrote:
>>> I didn't plan to interpret the contents of the IE in any way.  The
>>> idea would be to have little service-specific code, and in case of WFD
>>> there's no need to do anything more than passing the ies.
>>
>> So two issues:
>> - Passing in unchecked binary info from an unprivileged process is just
>> not going to happen though.  We have to look inside anyway to sanitize i=
t.
> =

> Fair enough, although I think the level of sanitization would only
> need to be the same as when we send out an SSID provided by an
> unprivileged process... we only check it's utf-8, not too long and
> such.

Well, about the only place we do this is in Adhoc and AP code.  And the =

SSID gets sanitized by the kernel (and maybe even the firmware) as well. =

  So there are multiple layers of protection here.

But in general, we do not allow arbitrary binary blobs to be passed =

around.  That's just not our design philosophy.

> =

>> - Some of the sub elements are dynamic (connected bssid for example).
>> So you will end up having to interpret it anyway.
> =

> AFAIK we don't strictly need to do anything and things will work just
> like with wpa_supplicant... but we could.
> =


Fair enough

>>> Yeah, I wasn't going to implement it at this time.  But since you'll
>>> have RSSI in every mode of wireless connections, AP, adhoc, ...
>>> wouldn't it make sense to have a common interface and share code in
>>> iwd and in the clients?
>>
>> You don't though.  For AP you have multiple clients, which rssi are you
>> going to show?
> =

> That would be per client obviously, when/if information about the
> clients is added.

And the kernel has APIs for this?  AFAIK you don't even get this info =

without polling.  So trying to use our agent for this is not going to work.

> =

>> Same goes for p2p-go really.
> =

> With P2P we are initiating the connections, so we have to expose
> information about each peer anyway.
> =


So lets see how that works out given the above.  I think for now I would =

leave all of this out.

>> Then we can't do this as a global registration.  Because some
>> sub-elements are dynamic it would be up to the application to update the
>> IE properly.  I'm really not sure we can avoid building the WFD IE
>> ourselves.
> =

> I think it should still be global actually, but maybe we need to
> expand the API somehow.  I think it should be global because an
> application like gnome-screencast is not going to know which device to
> use.  But we may need to add a way for the service to say it's
> connected now so that its not considered for any simultaneous
> connections, until the first connection is closed.

Well, it is explicitly allowed to run multiple WFD sessions if the =

infrastructure is there, even without a P2P link.

So I generally agree this should be global, just pointing out that =

certain elements would need to be dynamic.  This also (probably?) =

precludes us from advertising a Sink role and a Source role for example. =

  And also makes things like doing simultaneous P2P_GO + P2P_CLIENT sort =

of pointless.

So overall I'd say we should ignore the possibility of multiple P2P =

iftypes.  It will be either a P2P_GO with multiple clients or a =

P2P_CLIENT and we're limited to 1.

> =

> So since our assumption is that we're always initiating our
> connections (or in the future responing to an invitation, but the
> response is again our initiative), we could also register services
> per-connection and per-scan?  This would work for gnome-screencast,
> since I believe it has its own dialog that shows you available devices
> to connect to... not sure about other services.
> =


We can always introduce a per phy agent that would override the global =

one if we really encounter a use case that required this.  Or allow =

multiple agents to be registered and if an application triggers a =

connection, then the agent registered on that application's dbus unique =

name (if any) gets preferred for any IEs broadcast.

For now I'd ignore this and assume we can only do one role at a time.

>>
>> Yeah, but that's the problem.  What do you actually mean by
>> AvailableConnections?  Do you mean:
>>
>> 1.  connections on a given P2P_CLIENT or P2P_GO interface?  or
>> 2.  number of P2P_CLIENT & P2P_GO interfaces?
> =

> So this should not bleed into the API.  As long as we allow the user
> to make another connection, it should be signalled to the user
> somehow.  Whether we're using a separate interface or just make
> another connection from our GO interface.

Then just indicate what role we have and let the application make that =

choice.  So if we're in P2P_GO mode, it can try to establish another =

connection.  And if we're in P2P_CLIENT mode, tough luck.

> =

>>
>> If 1, then this makes no sense anyway.  For P2P_CLIENT it is always 1.
>> For P2P_GO it is essentially unlimited.
> =

> Right, but we need to inform the user somehow whether we can make
> another connection with whatever role we have currently negotiated or
> because we're idle.
> =

> (and for P2P_GO we may want to set an artificial limit, it's only
> unlimited in theory)

Why? The hardware is the arbiter of this in the end.

> =

>>
>> For 2, I doubt you will ever find any hardware capable of doing more
>> than 1 anyway.  And it is a complication I wouldn't worry about now
>> regardless.  So if the v1 API is limited to a single connection and we
>> later find out it is actually possible to do more, then we worry about
>> it then.
> =

> So from what I've seen, it is possible, but not until we support the
> GO role.  However our main usecase right now (I believe...) is a PC,
> phone, tablet, rather than a peripheral device, so I think this is
> definitely going to be expected from iwd, so are you sure you want to
> limit the API to a single connection?

Ah, imprecise wording here.  By single connection I mean a single =

P2P_GO/P2P_CLIENT interface active at a time.  So if we're in P2P_GO =

mode, we can do multiple 'connections'.  But since we're not doing =

P2P_GO yet, then effectively we would only support a single active peer =

today.

> =

> AFAIK the android API for apps doesn't have this limit for example.
> =


Right, but they still expect apps to setup the topology appropriately. =

And this is maybe something you need to consider for the future: being =

able to force one mode vs the other.

> =

>>
>>>>> +
>>>>> +Methods              ConnectPushButton()
>>>>> +
>>>>> +                     Connect to the P2P peer in the Push Button mode
>>>>> +                     using the device pointed to by the .Device prop=
erty.
>>>>> +                     Returns when connection is complete.
>>>>
>>>> Why are you method names different from SimpleConfiguration?  in fact,
>>>> why not just add .SimpleConfiguration interface to the same object path
>>>> and just have clients use that?
>>>
>>> Could do this, yes, although it would have been nice to have "Connect"
>>> in the method names.  And I'm not sure how to resolve this in the code
>>> since the implementation of the methods will be very different from
>>> the one in wsc.c, preferably I wouldn't duplicate setup_wsc_interface.
>>
>> Pretty easy I would think?  I mean you do have the netdev associated
>> with it, so you can simply check the interface type.
> =

> We only have a netdev after the GO Negotiation.
> =

> Esentially I'd need to have a new struct wsc, which would encapsulate eit=
her:
> =

>   * a current struct wsc for a station interface, or
>   * a P2P peer that corresponds to a scan result.
> =

> Then the wsc.c PushButton method, for instance, would need to either
> do its current work or delegate it to a p2p.c function and exit.

Then make wsc work more like struct network.  And have it register the =

interface when a station is available or on request for a p2p peer.  We =

may have to be creative.

Regards,
-Denis
--===============5300079654744652510==--

