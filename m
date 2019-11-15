Content-Type: multipart/mixed; boundary="===============5041237223811127371=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 01:38:55 +0100
Message-ID: <CAOq732K8318ev5AiK6XqCqtDAST741wKGRR5bW5pA3_LuJX5TQ@mail.gmail.com>
In-Reply-To: <40ab712b-572b-8598-c558-820484d1662e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5041237223811127371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Nov 2019 at 21:36, Denis Kenzior <denkenz@gmail.com> wrote:
> On 11/14/19 1:37 PM, Andrew Zaborowski wrote:
> >>> Yeah, I wasn't going to implement it at this time.  But since you'll
> >>> have RSSI in every mode of wireless connections, AP, adhoc, ...
> >>> wouldn't it make sense to have a common interface and share code in
> >>> iwd and in the clients?
> >>
> >> You don't though.  For AP you have multiple clients, which rssi are you
> >> going to show?
> >
> > That would be per client obviously, when/if information about the
> > clients is added.
>
> And the kernel has APIs for this?  AFAIK you don't even get this info
> without polling.  So trying to use our agent for this is not going to wor=
k.

I think there's a patchset that's being rebased occasionally.  But
what I mean is that maybe that interface doc shouldn't be buried in
station-api.txt.

>
> >
> >> Same goes for p2p-go really.
> >
> > With P2P we are initiating the connections, so we have to expose
> > information about each peer anyway.
> >
>
> So lets see how that works out given the above.  I think for now I would
> leave all of this out.

Ok.

>
> >> Then we can't do this as a global registration.  Because some
> >> sub-elements are dynamic it would be up to the application to update t=
he
> >> IE properly.  I'm really not sure we can avoid building the WFD IE
> >> ourselves.
> >
> > I think it should still be global actually, but maybe we need to
> > expand the API somehow.  I think it should be global because an
> > application like gnome-screencast is not going to know which device to
> > use.  But we may need to add a way for the service to say it's
> > connected now so that its not considered for any simultaneous
> > connections, until the first connection is closed.
>
> Well, it is explicitly allowed to run multiple WFD sessions if the
> infrastructure is there, even without a P2P link.
>
> So I generally agree this should be global, just pointing out that
> certain elements would need to be dynamic.  This also (probably?)
> precludes us from advertising a Sink role and a Source role for example.
>   And also makes things like doing simultaneous P2P_GO + P2P_CLIENT sort
> of pointless.

When talking about the API it's only a question of whether the
parameters dictionary should have to booleans, one for sink, one for
source, or one "role" variable.  We're not acting on that information
anyway, it's only so we can encode it in the IE.

>
> So overall I'd say we should ignore the possibility of multiple P2P
> iftypes.  It will be either a P2P_GO with multiple clients or a
> P2P_CLIENT and we're limited to 1.

In the code I'm currently ignoring that possibilty, but talking about
the API it wouldn't make much difference.

>
> >
> > So since our assumption is that we're always initiating our
> > connections (or in the future responing to an invitation, but the
> > response is again our initiative), we could also register services
> > per-connection and per-scan?  This would work for gnome-screencast,
> > since I believe it has its own dialog that shows you available devices
> > to connect to... not sure about other services.
> >
>
> We can always introduce a per phy agent that would override the global
> one if we really encounter a use case that required this.  Or allow
> multiple agents to be registered and if an application triggers a
> connection, then the agent registered on that application's dbus unique
> name (if any) gets preferred for any IEs broadcast.
>
> For now I'd ignore this and assume we can only do one role at a time.

Right.  But I'm thinking if there is a whole better way of doing the
service registration, i.e. per connection instead of globally.  Say
your use case is you're connecting first to a TV and then to a
keyboard, or simultaneously (as a GO).  There's no point advertising
the WFD capabilities to the keyboard device or to anyone other than
the TV, once your WFD session is running and functional.  Maybe the
ServiceManager is the wrong way to go and the Connect / PushButton
method should receive the relevant information.

>
> >>
> >> Yeah, but that's the problem.  What do you actually mean by
> >> AvailableConnections?  Do you mean:
> >>
> >> 1.  connections on a given P2P_CLIENT or P2P_GO interface?  or
> >> 2.  number of P2P_CLIENT & P2P_GO interfaces?
> >
> > So this should not bleed into the API.  As long as we allow the user
> > to make another connection, it should be signalled to the user
> > somehow.  Whether we're using a separate interface or just make
> > another connection from our GO interface.
>
> Then just indicate what role we have and let the application make that
> choice.  So if we're in P2P_GO mode, it can try to establish another
> connection.  And if we're in P2P_CLIENT mode, tough luck.

I think it would be nicer to just prefer GO automatically (maybe
without forcing it), for example by having the GO Intent default to 14
out of 15 and be configurable in main.conf.

>
> >
> >>
> >> If 1, then this makes no sense anyway.  For P2P_CLIENT it is always 1.
> >> For P2P_GO it is essentially unlimited.
> >
> > Right, but we need to inform the user somehow whether we can make
> > another connection with whatever role we have currently negotiated or
> > because we're idle.
> >
> > (and for P2P_GO we may want to set an artificial limit, it's only
> > unlimited in theory)
>
> Why? The hardware is the arbiter of this in the end.

Some dedicated access points have trouble serving 10 connections
simultaneously on one radio channel so for our off the shelf hardware
and minimal ap.c code it's going to be very difficult.

>
> >
> >>
> >> For 2, I doubt you will ever find any hardware capable of doing more
> >> than 1 anyway.  And it is a complication I wouldn't worry about now
> >> regardless.  So if the v1 API is limited to a single connection and we
> >> later find out it is actually possible to do more, then we worry about
> >> it then.
> >
> > So from what I've seen, it is possible, but not until we support the
> > GO role.  However our main usecase right now (I believe...) is a PC,
> > phone, tablet, rather than a peripheral device, so I think this is
> > definitely going to be expected from iwd, so are you sure you want to
> > limit the API to a single connection?
>
> Ah, imprecise wording here.  By single connection I mean a single
> P2P_GO/P2P_CLIENT interface active at a time.  So if we're in P2P_GO
> mode, we can do multiple 'connections'.  But since we're not doing
> P2P_GO yet, then effectively we would only support a single active peer
> today.

So I assume you're Ok having the Disconnect method on the Peer
interface, not on P2PDevice? So that our DBus clients are prepared to
support multiple connections instead of 1?

Or I wonder if we should repurpose WSC.Cancel to also disconnect a
fully established connection.  There's no need for separate Cancel and
Disconnect methods, but Disconnect sounds more correct.

>
> >
> > AFAIK the android API for apps doesn't have this limit for example.
> >
>
> Right, but they still expect apps to setup the topology appropriately.
> And this is maybe something you need to consider for the future: being
> able to force one mode vs the other.
>
> >
> >>
> >>>>> +
> >>>>> +Methods              ConnectPushButton()
> >>>>> +
> >>>>> +                     Connect to the P2P peer in the Push Button mo=
de
> >>>>> +                     using the device pointed to by the .Device pr=
operty.
> >>>>> +                     Returns when connection is complete.
> >>>>
> >>>> Why are you method names different from SimpleConfiguration?  in fac=
t,
> >>>> why not just add .SimpleConfiguration interface to the same object p=
ath
> >>>> and just have clients use that?
> >>>
> >>> Could do this, yes, although it would have been nice to have "Connect"
> >>> in the method names.  And I'm not sure how to resolve this in the code
> >>> since the implementation of the methods will be very different from
> >>> the one in wsc.c, preferably I wouldn't duplicate setup_wsc_interface.
> >>
> >> Pretty easy I would think?  I mean you do have the netdev associated
> >> with it, so you can simply check the interface type.
> >
> > We only have a netdev after the GO Negotiation.
> >
> > Esentially I'd need to have a new struct wsc, which would encapsulate e=
ither:
> >
> >   * a current struct wsc for a station interface, or
> >   * a P2P peer that corresponds to a scan result.
> >
> > Then the wsc.c PushButton method, for instance, would need to either
> > do its current work or delegate it to a p2p.c function and exit.
>
> Then make wsc work more like struct network.  And have it register the
> interface when a station is available or on request for a p2p peer.  We
> may have to be creative.

Right, I was just thinking that there's going to be little common code
between the two usages of the WSC interface.  For the first case it's
going to be the same wsc.c code there is today, but for the latter the
3 methods will directly call into p2p.c and exit.  (specifically
PushButton, StartPin and Cancel)

Best regards
--===============5041237223811127371==--

